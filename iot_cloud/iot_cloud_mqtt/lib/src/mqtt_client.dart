import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:typed_data';
import 'package:cbor/cbor.dart';

class MqttClientHandler {
  Future<MqttServerClient> connect() async {
    MqttServerClient client = MqttServerClient.withPort(
      '192.168.1.243', // Match your Arduino's broker address
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

      String topic = 'arduino-uno-r4-wifi/loopback';
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
        // Correctly use the CBOR library according to its API
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
        // Try to print as string for debugging
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

  // Correctly implement CBOR decoding according to the library's API
  dynamic decodeCborPayload(List<int> payload) {
    try {
      // Create a decoder instance
      final decoder = CborDecoder();

      // Decode the CBOR data
      final decodedValue = decoder.convert(Uint8List.fromList(payload));

      return decodedValue;
    } catch (e) {
      print('CBOR decoding error: $e');
      rethrow; // Rethrow to handle in the calling function
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
      client.unsubscribe('arduino-uno-r4-wifi/loopback');
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
