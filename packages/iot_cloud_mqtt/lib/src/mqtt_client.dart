import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:typed_data';
import 'package:cbor/cbor.dart';

class MqttClientHandler {
  Future<MqttServerClient> connect() async {
    MqttServerClient client = MqttServerClient.withPort(
      'localhost',
      'serverpod_client',
      1883,
    );
    client.logging(on: false);
    client.keepAlivePeriod = 60;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    final connMess = MqttConnectMessage()
        .authenticateAs("serverpod", "serverpod")
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMess;

    try {
      print('Connecting');
      await client.connect();
      print('Connected successfully');

      String topic = '#';
      print('Subscribing to: $topic');
      client.subscribe(topic, MqttQos.atLeastOnce);
    } catch (e) {
      print('Connection failed: $e');
      client.disconnect();
    }

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      if (c == null || c.isEmpty) return;

      final receivedMessage = c[0];
      final topic = receivedMessage.topic;
      final payload = receivedMessage.payload as MqttPublishMessage;
      final payloadBytes = payload.payload.message;

      print('Received message:');
      print('Topic: $topic');
      printPayloadAsHex(payloadBytes);

      try {
        final decodedData = decodeCborPayload(payloadBytes);
        print('Decoded CBOR Data: $decodedData');

        if (decodedData is Map) {
          if (decodedData.containsKey('timestamp')) {
            print('Timestamp: ${decodedData['timestamp']}');
          }
          if (decodedData.containsKey('data')) {
            print('Data: ${decodedData['data']}');
          }
        }
      } catch (e) {
        print('Error processing message: $e');
        try {
          final stringPayload = String.fromCharCodes(payloadBytes);
          print('As string: $stringPayload');
        } catch (e2) {
          print('Unable to convert to string: $e2');
        }
      }

      print('-------------------');
    });

    return client;
  }

  dynamic decodeCborPayload(List<int> payload) {
    try {
      final decoder = CborDecoder();
      final decodedValue = decoder.convert(Uint8List.fromList(payload));

      return decodedValue;
    } catch (e) {
      print('CBOR decoding error: $e');
      rethrow;
    }
  }

  void printPayloadAsHex(List<int> payload) {
    final buffer = StringBuffer();
    buffer.write('Payload as hex: ');
    for (final byte in payload) {
      buffer.write(byte.toRadixString(16).padLeft(2, '0'));
      buffer.write(' ');
    }
    print(buffer.toString());
  }

  Future<void> disconnect(MqttServerClient client) async {
    try {
      print('Unsubscribing from topics...');
      client.unsubscribe('#');
      print('Disconnecting');
      client.disconnect();
    } catch (e) {
      print('Error during disconnection: $e');
    }
  }

  void onConnected() {
    print('Connected to broker');
  }

  void onDisconnected() {
    print('Disconnected from broker');
  }

  void onSubscribed(String topic) {
    print('Subscribed to topic: $topic');
  }

  void onSubscribeFail(String topic) {
    print('Failed to subscribe to topic: $topic');
  }

  void onUnsubscribed(String? topic) {
    print('Unsubscribed from topic: $topic');
  }

  void pong() {
    print('Ping response received');
  }
}
