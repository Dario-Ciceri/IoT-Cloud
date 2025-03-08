// In lib/src/endpoints/url_shortener_endpoint.dart
import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class UrlShortenerEndpoint extends Endpoint {
  // Metodo interno per generare un URL corto
  Future<String> createShortUrl(Session session, String longUrl) async {
    // Genera un codice corto
    final shortCode = _generateShortCode();

    // Crea una nuova mappatura
    final mapping = UrlMapping(
      shortCode: shortCode,
      originalUrl: longUrl,
      createdAt: DateTime.now(),
    );

    // Salva nel database
    await UrlMapping.db.insertRow(session, mapping);

    // Usa un valore di configurazione per il domain
    // Puoi definire questo valore nelle tue variabili d'ambiente o config.yaml
    final baseUrl = '192.168.1.25:8082';

    // Costruisci l'URL completo
    return '$baseUrl/s/$shortCode';
  }

  String _generateShortCode() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }
}
