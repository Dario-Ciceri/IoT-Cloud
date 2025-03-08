// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:minio/minio.dart';
import 'package:serverpod/serverpod.dart';

/// Concrete implementation of S3 cloud storage for use with MinIO.
class S3CloudStorage extends CloudStorage {
  final String region;
  final String bucket;
  final bool public;
  final String minioIp;
  final int minioPort;
  late final Minio minio;

  S3CloudStorage({
    required Serverpod serverpod,
    required String storageId,
    String? publicHost,
    required this.region,
    required this.bucket,
    required this.public,
    required this.minioIp,
    required this.minioPort,
  }) : super(storageId) {
    serverpod.loadCustomPasswords([
      (envName: 'SERVERPOD_AWS_ACCESS_KEY_ID', alias: 'AWSAccessKeyId'),
      (envName: 'SERVERPOD_AWS_SECRET_KEY', alias: 'AWSSecretKey'),
    ]);

    var awsAccessKeyId = serverpod.getPassword('AWSAccessKeyId');
    var awsSecretKey = serverpod.getPassword('AWSSecretKey');

    if (awsAccessKeyId == null) {
      throw StateError('AWSAccessKeyId must be configured in your passwords.');
    }
    if (awsSecretKey == null) {
      throw StateError('AWSSecretKey must be configured in your passwords.');
    }

    minio = Minio(
      endPoint: minioIp,
      port: minioPort,
      useSSL: false,
      enableTrace: true,
      accessKey: awsAccessKeyId,
      secretKey: awsSecretKey,
    );
  }

  @override
  Future<void> storeFile({
    required Session session,
    required String path,
    required ByteData byteData,
    DateTime? expiration,
    bool verified = true,
  }) async {
    final uri = Uri.parse(
      await minio.presignedPutObject(
        bucket,
        Uri.parse(path).path.replaceFirst(bucket, ''),
      ),
    );
    final response =
        await http.put(uri, body: byteData.buffer.asUint8List(), headers: {
      'Content-Type': 'application/octet-stream',
      'Content-Length': byteData.lengthInBytes.toString(),
    });

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(
          'Failed to store file. Status code: ${response.statusCode}');
    }
  }

  @override
  Future<ByteData?> retrieveFile({
    required Session session,
    required String path,
  }) async {
    final uri = Uri.parse(
      await minio.presignedGetObject(
        bucket,
        Uri.parse(path).path.replaceFirst(bucket, ''),
      ),
    );
    print("retrieveFile: $uri");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return ByteData.view(Uint8List.fromList(response.bodyBytes).buffer);
    }
    return null;
  }

  @override
  Future<Uri?> getPublicUrl({
    required Session session,
    required String path,
  }) async {
    if (await fileExists(session: session, path: path)) {
      final uri = Uri.parse(
        await minio.presignedGetObject(
          bucket,
          Uri.parse(path).path.replaceFirst(bucket, ''),
        ),
      );
      print("getPublicUrl: $uri");
      return uri;
    }
    return null;
  }

  @override
  Future<bool> fileExists({
    required Session session,
    required String path,
  }) async {
    try {
      final uri = Uri.parse(
        await minio.presignedUrl(
          'HEAD',
          bucket,
          Uri.parse(path).path.replaceFirst(bucket, ''),
        ),
      );
      final response = await http.head(uri);
      print("fileExists: $uri");
      print("fileExists: ${response.reasonPhrase}");
      print("fileExists: ${response.statusCode}");
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> deleteFile({
    required Session session,
    required String path,
  }) async {
    final uri = Uri.parse(
      await minio.presignedUrl(
        'DELETE',
        bucket,
        Uri.parse(path).path.replaceFirst(bucket, ''),
      ),
    );
    final response = await http.delete(uri);
    print("Delete file: $uri");

    if (response.statusCode != 204 && response.statusCode != 200) {
      throw Exception(
          'Failed to delete file. Status code: ${response.statusCode}');
    }
  }

  @override
  Future<String?> createDirectFileUploadDescription({
    required Session session,
    required String path,
    Duration expirationDuration = const Duration(minutes: 10),
    int maxFileSize = 10 * 1024 * 1024,
  }) async {
    final res = await minio.presignedPutObject(bucket, path);
    print("createDirectFileUploadDescription: $res");
    return res;
    // final datetime = SigV4.generateDatetime();

    // final policy = Policy.fromS3PresignedPost(
    //   path,
    //   bucket,
    //   _awsAccessKeyId,
    //   expirationDuration.inMinutes,
    //   maxFileSize,
    //   region: region,
    //   public: public,
    // );

    // final key =
    //     SigV4.calculateSigningKey(_awsSecretKey, datetime, region, 's3');
    // final signature = SigV4.calculateSignature(key, policy.encode());

    // return json.encode({
    //   "type": "multipart",
    //   "url": _endpoint,
    //   "field": "file",
    //   "file-name": path.split('/').last,
    //   "request-fields": {
    //     "key": policy.key,
    //     "policy": policy.encode(),
    //     "acl": public ? "public-read" : "private",
    //     "x-amz-algorithm": "AWS4-HMAC-SHA256",
    //     "x-amz-credential": policy.credential,
    //     "x-amz-date": policy.datetime,
    //     "x-amz-signature": signature
    //   }
    // });
  }

  @override
  Future<bool> verifyDirectFileUpload({
    required Session session,
    required String path,
  }) async {
    return fileExists(session: session, path: path);
  }
}
