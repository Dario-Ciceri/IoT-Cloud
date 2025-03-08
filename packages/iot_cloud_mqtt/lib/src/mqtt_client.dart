import 'dart:io';
import 'dart:typed_data';

import 'package:cbor/cbor.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/typed_data.dart' as typed;

/// Main MQTT OTA Client class for firmware updates
class MqttClientHandler {
  // Client properties
  late MqttServerClient client;
  String? serverAddress;
  HttpServer? firmwareServer;

  // Constructor
  MqttClientHandler({
    this.serverAddress,
  });

  /// Connect to the MQTT broker
  Future<void> connect({
    String host = 'localhost',
    int port = 1883,
    String username = 'serverpod',
    String password = 'serverpod',
    String clientId = 'dart_ota_client',
  }) async {
    client = MqttServerClient.withPort(
      host,
      clientId,
      port,
    );
    client.logging(on: false);
    client.keepAlivePeriod = 20;
    client.onConnected = _onConnected;
    client.onDisconnected = _onDisconnected;
    client.onUnsubscribed = _onUnsubscribed;
    client.onSubscribed = _onSubscribed;
    client.onSubscribeFail = _onSubscribeFail;
    client.pongCallback = _pong;
    client.autoReconnect = true;

    final connMess = MqttConnectMessage()
        .authenticateAs(username, password)
        .withWillTopic('status/client')
        .withWillMessage('{"status":"offline","source":"client"}')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMess;

    try {
      print('Connecting to MQTT broker at $host:$port');
      await client.connect();

      if (client.connectionStatus?.state == MqttConnectionState.connected) {
        print('Connected successfully');

        // Subscribe to firmware update response topics
        client.subscribe('firmware/update/response', MqttQos.atLeastOnce);
        client.subscribe('debug/#', MqttQos.atLeastOnce);
        client.subscribe('status/#', MqttQos.atLeastOnce);

        print('Subscribed to firmware response and debug topics');

        // Set up message handler
        client.updates!.listen(_handleMessage);

        await Future.delayed(Duration(seconds: 3));
        await updateDeviceFromCustomServer(
          targetDeviceId: 'UNOWIFIR4',
          serverHost: '192.168.1.25',
          serverPort: 8082,
          serverPath: '/s/rUwrX0nx',
        );
      } else {
        print('Connection failed: ${client.connectionStatus}');
        throw Exception('MQTT connection failed');
      }
    } catch (e) {
      print('Exception during MQTT connection: $e');
      client.disconnect();
      rethrow;
    }
  }

  /// Handle incoming MQTT messages
  Future<void> _handleMessage(
      List<MqttReceivedMessage<MqttMessage?>>? messages) async {
    if (messages == null || messages.isEmpty) return;

    final receivedMessage = messages[0];
    final topic = receivedMessage.topic;
    final payload = receivedMessage.payload as MqttPublishMessage;
    final payloadBytes = payload.payload.message;

    print('Received message:');
    print('Topic: $topic');
    _printPayloadAsHex(payloadBytes);

    // Try to decode as CBOR
    try {
      final decodedData = _decodeCborPayload(payloadBytes);
      print('Decoded CBOR Data: $decodedData');

      if (decodedData is Map) {
        // Extract and print relevant information
        final device = decodedData['device'];

        if (decodedData.containsKey('message')) {
          print('Device: $device - Message: ${decodedData['message']}');
        }

        if (decodedData.containsKey('status')) {
          print(
              'Device: $device - Status: ${decodedData['status']} - ${decodedData['message'] ?? ''}');
        }

        if (decodedData.containsKey('percentage')) {
          print('Device: $device - Progress: ${decodedData['percentage']}%');
        }

        if (decodedData.containsKey('current') &&
            decodedData.containsKey('total')) {
          final current = decodedData['current'];
          final total = decodedData['total'];
          final percent = total > 0 ? (current * 100 ~/ total) : 0;
          print(
              'Device: $device - Download: $current/$total bytes ($percent%)');
        }
      }
    } catch (e) {
      print('CBOR decoding error: $e');
      try {
        final stringPayload = String.fromCharCodes(payloadBytes);
        print('As string: $stringPayload');
      } catch (e2) {
        print('Unable to convert to string: $e2');
      }
    }

    print('-------------------');
  }

  /// Disconnect from the MQTT broker
  Future<void> disconnect() async {
    try {
      print('Unsubscribing from topics...');
      client.unsubscribe('firmware/update/response');
      client.unsubscribe('debug/#');
      client.unsubscribe('status/#');

      // Stop firmware HTTP server if running
      await stopFirmwareServer();

      print('Disconnecting from MQTT broker');
      client.disconnect();
    } catch (e) {
      print('Error during disconnection: $e');
    }
  }

  // MQTT callbacks
  void _onConnected() {
    print('Connected to MQTT broker');
  }

  void _onDisconnected() {
    print('Disconnected from MQTT broker');
  }

  void _onSubscribed(String topic) {
    print('Subscribed to topic: $topic');
  }

  void _onSubscribeFail(String topic) {
    print('Failed to subscribe to topic: $topic');
  }

  void _onUnsubscribed(String? topic) {
    print('Unsubscribed from topic: $topic');
  }

  void _pong() {
    print('Ping response received');
  }

  /// Decode CBOR payload
  dynamic _decodeCborPayload(List<int> payload) {
    try {
      final decoder = CborDecoder();
      final decodedValue = decoder.convert(Uint8List.fromList(payload));
      return decodedValue;
    } catch (e) {
      print('CBOR decoding error: $e');
      rethrow;
    }
  }

  /// Print payload as hexadecimal
  void _printPayloadAsHex(List<int> payload) {
    final buffer = StringBuffer();
    buffer.write('Payload as hex: ');

    // Limit display to first 64 bytes for readability
    final displayBytes = payload.length > 64 ? payload.sublist(0, 64) : payload;

    int lineCount = 0;
    for (final byte in displayBytes) {
      if (lineCount > 0 && lineCount % 16 == 0) {
        buffer.write('\n                ');
      }
      buffer.write(byte.toRadixString(16).padLeft(2, '0'));
      buffer.write(' ');
      lineCount++;
    }

    if (payload.length > 64) {
      buffer.write('... (${payload.length - 64} more bytes)');
    }

    print(buffer.toString());
  }

  /// Send firmware update command to a device using separate host, port, and path
  /// This method is preferred over the full URL method for better compatibility with devices
  Future<void> sendFirmwareUpdateCommand({
    required String targetDeviceId,
    // Separate server parameters
    String? serverHost,
    int? serverPort,
    String? serverPath,
    // Legacy full URL option (used only if serverHost is null)
    String? firmwareUrl,
    // Optional parameters
    int? contentLength,
    bool chunkedTransfer = false,
  }) async {
    // Ensure client is connected
    if (client.connectionStatus?.state != MqttConnectionState.connected) {
      throw Exception('MQTT client not connected');
    }

    // Validate input parameters
    if (serverHost == null && firmwareUrl == null) {
      throw Exception('Either serverHost or firmwareUrl must be provided');
    }

    // Build update command (CBOR map)
    final encoder = CborMapEncoder();

    // Add target device ID (required)
    encoder.writeString('target', targetDeviceId);

    // Add server parameters or full URL
    if (serverHost != null) {
      encoder.writeString('host', serverHost);
      encoder.writeInt(
          'port', serverPort ?? 80); // Default to port 80 if not specified
      encoder.writeString(
          'path', serverPath ?? '/'); // Default to root path if not specified
    } else if (firmwareUrl != null) {
      encoder.writeString('url', firmwareUrl);
    }

    // Add optional parameters if provided
    if (contentLength != null) {
      encoder.writeInt('content_length', contentLength);
    }

    if (chunkedTransfer) {
      encoder.writeBool('chunked', true);
    }

    // Encode the map to CBOR binary format
    final Uint8List cborData = encoder.getData();

    // Publish to firmware update command topic
    final topic = 'firmware/update/command';

    // Create MqttClientPayloadBuilder and add the CBOR data
    final builder = MqttClientPayloadBuilder();

    // Convert Uint8List to typed.Uint8Buffer for MQTT client
    final buffer = typed.Uint8Buffer();
    buffer.addAll(cborData);
    builder.addBuffer(buffer);

    print('Sending firmware update command to $targetDeviceId');
    if (serverHost != null) {
      print(
          'Firmware server: http://$serverHost:${serverPort ?? 80}${serverPath ?? '/'}');
    } else {
      print('Firmware URL: $firmwareUrl');
    }

    // Publish the message
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!,
        retain: false);

    print('Update command sent successfully');
  }

  /// Get the size of a firmware file in bytes
  Future<int> getFirmwareFileSize(String firmwarePath) async {
    try {
      final file = File(firmwarePath);
      if (!await file.exists()) {
        throw Exception('Firmware file not found: $firmwarePath');
      }
      final fileSize = await file.length();
      return fileSize;
    } catch (e) {
      print('Error getting firmware file size: $e');
      rethrow;
    }
  }

  /// Find the most appropriate local IP address
  Future<String> getLocalIpAddress() async {
    try {
      // If address was already provided, use it
      if (serverAddress != null) {
        return serverAddress!;
      }

      // Get all network interfaces
      final interfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.IPv4,
      );

      if (interfaces.isEmpty) {
        print('No network interfaces found, falling back to loopback');
        return InternetAddress.loopbackIPv4.address;
      }

      // Sort interfaces to prioritize wlan and eth interfaces
      interfaces.sort((a, b) {
        // Prioritize wireless and ethernet interfaces
        final aName = a.name.toLowerCase();
        final bName = b.name.toLowerCase();

        // Check if either interface is wireless or ethernet
        final aIsPreferred = aName.contains('wlan') ||
            aName.contains('eth') ||
            aName.contains('en');
        final bIsPreferred = bName.contains('wlan') ||
            bName.contains('eth') ||
            bName.contains('en');

        if (aIsPreferred && !bIsPreferred) return -1;
        if (!aIsPreferred && bIsPreferred) return 1;

        // If both or neither are preferred, sort by name
        return aName.compareTo(bName);
      });

      // Print available interfaces for debugging
      print('Available network interfaces:');
      for (var interface in interfaces) {
        print(
            '${interface.name}: ${interface.addresses.map((a) => a.address).join(', ')}');
      }

      // Use the first address of the preferred interface
      final selectedInterface = interfaces.first;
      if (selectedInterface.addresses.isEmpty) {
        throw Exception('Selected network interface has no addresses');
      }

      final ipAddress = selectedInterface.addresses.first.address;
      print(
          'Selected server IP address: $ipAddress (${selectedInterface.name})');

      // Cache the detected address
      serverAddress = ipAddress;
      return ipAddress;
    } catch (e) {
      print('Error determining local IP address: $e');
      print('Falling back to loopback address');
      return InternetAddress.loopbackIPv4.address;
    }
  }

  /// Host a firmware file on a local HTTP server
  Future<Map<String, dynamic>> hostFirmwareFile({
    required String firmwarePath,
    int port = 8080,
  }) async {
    try {
      final file = File(firmwarePath);
      if (!await file.exists()) {
        throw Exception('Firmware file not found: $firmwarePath');
      }

      // Dynamically determine the server's IP address if not set
      final ipAddress = await getLocalIpAddress();

      // Stop any existing server
      await stopFirmwareServer();

      // Create a simple HTTP server
      firmwareServer = await HttpServer.bind(ipAddress, port);
      print('Firmware HTTP server started at http://$ipAddress:$port');

      // Handle requests
      firmwareServer!.listen((HttpRequest request) async {
        print(
            'Received firmware download request from: ${request.connectionInfo?.remoteAddress.address}');

        // Set headers
        request.response.headers.contentType =
            ContentType('application', 'octet-stream');
        request.response.headers.add('Content-Length', await file.length());

        // Send the file
        await file.openRead().pipe(request.response);
        await request.response.close();
        print('Firmware file sent to device');
      });

      // Return server parameters
      return {
        'host': ipAddress,
        'port': port,
        'path': '/firmware',
        'url': 'http://$ipAddress:$port/firmware',
        'fileSize': await file.length(),
      };
    } catch (e) {
      print('Error hosting firmware file: $e');
      rethrow;
    }
  }

  /// Stop the firmware HTTP server if it's running
  Future<void> stopFirmwareServer() async {
    if (firmwareServer != null) {
      await firmwareServer!.close(force: true);
      print('Firmware HTTP server stopped');
      firmwareServer = null;
    }
  }

  /// Update a device with a local firmware file
  Future<void> updateDeviceFromLocalFile({
    required String targetDeviceId,
    required String firmwarePath,
    int httpPort = 8080,
    bool useDirectParams = true, // Set to false to use legacy URL method
  }) async {
    try {
      print('Starting OTA update process for device: $targetDeviceId');

      // 1. Host the firmware file and get server details
      final serverInfo =
          await hostFirmwareFile(firmwarePath: firmwarePath, port: httpPort);

      print('Firmware server details:');
      print('Host: ${serverInfo['host']}');
      print('Port: ${serverInfo['port']}');
      print('Path: ${serverInfo['path']}');
      print('Full URL: ${serverInfo['url']}');
      print('File size: ${serverInfo['fileSize']} bytes');

      // 2. Send update command to device
      if (useDirectParams) {
        // Send with separate host, port, and path (recommended)
        await sendFirmwareUpdateCommand(
          targetDeviceId: targetDeviceId,
          serverHost: serverInfo['host'],
          serverPort: serverInfo['port'],
          serverPath: serverInfo['path'],
          contentLength: serverInfo['fileSize'],
          chunkedTransfer: false,
        );
      } else {
        // Legacy method using full URL
        await sendFirmwareUpdateCommand(
          targetDeviceId: targetDeviceId,
          firmwareUrl: serverInfo['url'],
          contentLength: serverInfo['fileSize'],
          chunkedTransfer: false,
        );
      }

      print('OTA update initiated for device: $targetDeviceId');
      print('Monitor the device status for progress updates');
      print(
          'The HTTP server will remain running until you call stopFirmwareServer()');
    } catch (e) {
      print('Error during firmware update process: $e');
      rethrow;
    }
  }

  /// Shortcut to directly send an update to a specific server
  Future<void> updateDeviceFromCustomServer({
    required String targetDeviceId,
    required String serverHost,
    int serverPort = 80,
    String serverPath = '/',
    int? contentLength,
  }) async {
    try {
      print('Starting direct OTA update for device: $targetDeviceId');
      print('Using server: http://$serverHost:$serverPort$serverPath');

      if (contentLength != null) {
        print('Content length: $contentLength bytes');
      } else {
        print(
            'Content length: not specified (will be determined during download)');
      }

      await sendFirmwareUpdateCommand(
        targetDeviceId: targetDeviceId,
        serverHost: serverHost,
        serverPort: serverPort,
        serverPath: serverPath,
        contentLength: contentLength,
      );

      print('Update command sent to device');
    } catch (e) {
      print('Error sending update command: $e');
      rethrow;
    }
  }
}

/// Custom CBOR map encoder
class CborMapEncoder {
  final List<int> _buffer = [];

  CborMapEncoder() {
    // Map header (indefinite length)
    _startMap();
  }

  // Write initial map header
  void _startMap() {
    _buffer.add(0xBF); // Start indefinite-length map
  }

  // Write a string key-value pair
  void writeString(String key, String value) {
    _writeTextString(key);
    _writeTextString(value);
  }

  // Write a string key with integer value
  void writeInt(String key, int value) {
    _writeTextString(key);
    _writeInt(value);
  }

  // Write a string key with boolean value
  void writeBool(String key, bool value) {
    _writeTextString(key);
    _writeBool(value);
  }

  // Write a text string
  void _writeTextString(String text) {
    final Uint8List utf8Bytes = Uint8List.fromList(text.codeUnits);
    final int length = utf8Bytes.length;

    // Major type 3 (text string)
    if (length < 24) {
      _buffer.add(0x60 + length);
    } else if (length < 256) {
      _buffer.add(0x78);
      _buffer.add(length);
    } else if (length < 65536) {
      _buffer.add(0x79);
      _buffer.add(length >> 8);
      _buffer.add(length & 0xFF);
    } else {
      _buffer.add(0x7A);
      _buffer.add(length >> 24);
      _buffer.add((length >> 16) & 0xFF);
      _buffer.add((length >> 8) & 0xFF);
      _buffer.add(length & 0xFF);
    }

    // Add the string bytes
    _buffer.addAll(utf8Bytes);
  }

  // Write an integer
  void _writeInt(int value) {
    if (value >= 0) {
      // Major type 0 (unsigned integer)
      if (value < 24) {
        _buffer.add(value);
      } else if (value < 256) {
        _buffer.add(0x18);
        _buffer.add(value);
      } else if (value < 65536) {
        _buffer.add(0x19);
        _buffer.add(value >> 8);
        _buffer.add(value & 0xFF);
      } else if (value < 4294967296) {
        _buffer.add(0x1A);
        _buffer.add(value >> 24);
        _buffer.add((value >> 16) & 0xFF);
        _buffer.add((value >> 8) & 0xFF);
        _buffer.add(value & 0xFF);
      } else {
        // 64-bit integer
        _buffer.add(0x1B);
        _buffer.add((value >> 56) & 0xFF);
        _buffer.add((value >> 48) & 0xFF);
        _buffer.add((value >> 40) & 0xFF);
        _buffer.add((value >> 32) & 0xFF);
        _buffer.add((value >> 24) & 0xFF);
        _buffer.add((value >> 16) & 0xFF);
        _buffer.add((value >> 8) & 0xFF);
        _buffer.add(value & 0xFF);
      }
    } else {
      // Major type 1 (negative integer)
      int absValue = -1 - value;
      if (absValue < 24) {
        _buffer.add(0x20 + absValue);
      } else if (absValue < 256) {
        _buffer.add(0x38);
        _buffer.add(absValue);
      } else if (absValue < 65536) {
        _buffer.add(0x39);
        _buffer.add(absValue >> 8);
        _buffer.add(absValue & 0xFF);
      } else if (absValue < 4294967296) {
        _buffer.add(0x3A);
        _buffer.add(absValue >> 24);
        _buffer.add((absValue >> 16) & 0xFF);
        _buffer.add((absValue >> 8) & 0xFF);
        _buffer.add(absValue & 0xFF);
      } else {
        // 64-bit integer
        _buffer.add(0x3B);
        _buffer.add((absValue >> 56) & 0xFF);
        _buffer.add((absValue >> 48) & 0xFF);
        _buffer.add((absValue >> 40) & 0xFF);
        _buffer.add((absValue >> 32) & 0xFF);
        _buffer.add((absValue >> 24) & 0xFF);
        _buffer.add((absValue >> 16) & 0xFF);
        _buffer.add((absValue >> 8) & 0xFF);
        _buffer.add(absValue & 0xFF);
      }
    }
  }

  // Write a boolean
  void _writeBool(bool value) {
    _buffer.add(value ? 0xF5 : 0xF4); // true = 0xF5, false = 0xF4
  }

  // Finalize the map and return the data
  Uint8List getData() {
    // End indefinite-length map
    _buffer.add(0xFF);
    return Uint8List.fromList(_buffer);
  }
}
