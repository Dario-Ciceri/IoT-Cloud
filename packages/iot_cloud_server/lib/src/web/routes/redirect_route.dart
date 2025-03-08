import 'dart:io';
import 'package:iot_cloud_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

import 'dart:typed_data';

class RedirectRoute extends Route {
  @override
  Future<bool> handleCall(Session session, HttpRequest request) async {
    // Estrai il codice corto dall'URL
    final shortCode = request.uri.path.replaceFirst('/s/', '');
    session.log("Richiesto URL corto: $shortCode");

    // Cerca nel database
    final mappings = await UrlMapping.db.find(
      session,
      where: (t) => t.shortCode.equals(shortCode),
    );

    if (mappings.isEmpty) {
      session.log("URL corto non trovato: $shortCode");
      request.response.statusCode = 404;
      request.response.write('URL non trovato');
      await request.response.close();
      return false;
    }

    final originalUrl = mappings.first.originalUrl;
    session.log("URL originale: $originalUrl");

    final client = HttpClient();
    HttpClientResponse? res;

    try {
      // Timeout estesi
      client.connectionTimeout = Duration(seconds: 60);
      client.idleTimeout = Duration(seconds: 180);

      // Prepara richiesta GET
      session.log("Download del file da Minio/S3");
      final getReq = await client.getUrl(Uri.parse(originalUrl));
      getReq.headers.add('User-Agent', 'ArduinoOTAProxy/2.0');
      getReq.followRedirects = true;
      getReq.maxRedirects = 10;

      // Esegui richiesta
      res = await getReq.close();
      session.log("Risposta: ${res.statusCode} ${res.reasonPhrase}");

      if (res.statusCode != 200) {
        session.log("Errore HTTP: ${res.statusCode}");
        request.response.statusCode = res.statusCode;
        request.response.write('Errore durante download');
        await request.response.close();
        return false;
      }

      // Scarichiamo prima l'intero file per conoscere la dimensione esatta
      // HEAD non consentito su MinIO

      session.log("Scaricamento completo del file in memoria...");
      List<Uint8List> chunks = [];
      int totalSize = 0;

      // Leggi tutti i chunks dal server di origine
      await for (List<int> chunk in res) {
        final typedChunk = Uint8List.fromList(chunk);
        chunks.add(typedChunk);
        totalSize += chunk.length;
      }

      session.log("File scaricato completamente: $totalSize bytes");

      // Ora prepariamo la risposta con Content-Length esatto
      session.log("Invio al client con Content-Length esatto");

      // Imposta gli headers con Content-Length corretto
      request.response.statusCode = 200;
      request.response.headers.clear();

      // Imposta content type
      final contentType = res.headers.contentType;
      if (contentType != null) {
        request.response.headers.contentType = contentType;
      } else {
        request.response.headers.contentType =
            ContentType('application', 'octet-stream');
      }

      // Imposta Content-Length basato sulla dimensione effettiva del file
      request.response.headers.contentLength = totalSize;
      session.log("Content-Length impostato a: $totalSize bytes");

      // Copia content-disposition se presente
      final dispositionValues = res.headers['content-disposition'];
      if (dispositionValues != null) {
        for (var value in dispositionValues) {
          request.response.headers.add('content-disposition', value);
        }
      }

      // Invia tutti i chunks al client
      for (var chunk in chunks) {
        request.response.add(chunk);
        await request.response.flush();
      }

      // Chiudi la risposta
      await request.response.close();
      session.log("Trasferimento completato con Content-Length esatto");
      return true;
    } catch (e, stack) {
      session.log("Errore nel proxy: $e",
          level: LogLevel.error, stackTrace: stack);

      if (res != null) {
        await res.drain().catchError((e) {});
      }

      if (!(await request.response.done)) {
        try {
          request.response.statusCode = 500;
          request.response.write('Errore interno del server');
          await request.response.close();
        } catch (e) {
          session.log("Errore finale: $e", level: LogLevel.error);
        }
      }
      return false;
    } finally {
      client.close();
    }
  }
}
