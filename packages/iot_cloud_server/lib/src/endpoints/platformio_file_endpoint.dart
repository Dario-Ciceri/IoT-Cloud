import 'dart:io';
import 'package:serverpod/serverpod.dart';
import 'package:path/path.dart' as path;

import '../generated/protocol.dart';

class PlatformioFileEndpoint extends Endpoint {
  Future<List<PlatformioFile>> listFiles(
    Session session,
    String directoryPath,
  ) async {
    try {
      final directory = Directory(directoryPath);
      if (!await directory.exists()) {
        return [];
      }

      final List<PlatformioFile> files = [];
      await for (final entity in directory.list()) {
        final stat = await entity.stat();
        final bool isDirectory = entity is Directory;

        files.add(PlatformioFile(
          name: path.basename(entity.path),
          path: entity.path,
          isDirectory: isDirectory,
          size: isDirectory ? null : stat.size,
          lastModified: stat.modified,
        ));
      }

      return files;
    } catch (e) {
      return [];
    }
  }

  Future<String?> readFile(
    Session session,
    String filePath,
  ) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return null;
      }

      return await file.readAsString();
    } catch (e) {
      return null;
    }
  }

  Future<bool> writeFile(
    Session session,
    String filePath,
    String content,
  ) async {
    try {
      final file = File(filePath);
      await file.writeAsString(content);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createDirectory(
    Session session,
    String directoryPath,
  ) async {
    try {
      final directory = Directory(directoryPath);
      await directory.create(recursive: true);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteFileOrDirectory(
    Session session,
    String path,
    bool recursive,
  ) async {
    try {
      // Check if it's a directory using isDirectory
      final isDirectory = await FileSystemEntity.isDirectory(path);

      if (isDirectory) {
        final directory = Directory(path);
        await directory.delete(recursive: recursive);
      } else {
        final file = File(path);
        await file.delete();
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
