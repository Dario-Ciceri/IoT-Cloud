import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:iot_cloud_server/src/services/platformio_service.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class PlatformioEndpoint extends Endpoint {
  final PlatformIOService _platformioService = PlatformIOService();

  // Verifica stato PlatformIO
  Future<PlatformioStatus> checkPlatformIO(Session session) async {
    try {
      final result = await _platformioService.runCommand(['--version']);

      return PlatformioStatus(
        installed: result.exitCode == 0,
        version: result.stdout.toString().trim(),
        errorMessage: result.exitCode != 0 ? result.stderr.toString() : null,
      );
    } catch (e) {
      session.log('Error checking PlatformIO: $e');
      return PlatformioStatus(
        installed: false,
        version: '',
        errorMessage: e.toString(),
      );
    }
  }

  // Gestione progetti
  Future<bool> initProject(
    Session session,
    String path,
    String board,
    String framework,
    String name,
    String? description,
  ) async {
    try {
      session.log(
          'Initializing project: $name at $path with board $board and framework $framework');

      final result =
          await _platformioService.initProject(path, board, framework);

      if (result.exitCode != 0) {
        session.log('PlatformIO init failed: ${result.stderr}');
        return false;
      }

      final project = PlatformioProject(
        name: name,
        path: path,
        description: description,
        board: board,
        framework: framework,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await PlatformioProject.db.insertRow(session, project);
      return true;
    } catch (e) {
      session.log('Error initializing project: $e');
      return false;
    }
  }

  Future<List<PlatformioProject>> listProjects(Session session) async {
    try {
      return await PlatformioProject.db.find(session);
    } catch (e) {
      session.log('Error listing projects: $e');
      return [];
    }
  }

  Future<PlatformioProject?> getProject(Session session, int id) async {
    try {
      return await PlatformioProject.db.findById(session, id);
    } catch (e) {
      session.log('Error getting project $id: $e');
      return null;
    }
  }

  Future<bool> deleteProject(Session session, int id) async {
    try {
      // Ottieni il progetto per il path
      final project = await PlatformioProject.db.findById(session, id);
      if (project == null) {
        return false;
      }

      // Elimina dai record
      await PlatformioProject.db.deleteRow(session, project);

      // Nota: non eliminiamo la directory per sicurezza
      // Se necessario, implementare la cancellazione fisica

      return true;
    } catch (e) {
      session.log('Error deleting project $id: $e');
      return false;
    }
  }

  // Gestione build/upload
  Future<PlatformioBuildResult> buildProject(
    Session session,
    PlatformioProject project,
  ) async {
    try {
      final startTime = DateTime.now();

      session.log('Building project at path: ${project.path}');
      final result = await _platformioService.buildProject(project.path);

      final endTime = DateTime.now();
      final duration = endTime.difference(startTime).inMilliseconds;

      return PlatformioBuildResult(
        success: result.exitCode == 0,
        output: result.stdout.toString(),
        errorOutput: result.exitCode != 0 ? result.stderr.toString() : null,
        duration: duration,
      );
    } catch (e) {
      session.log('Error building project: $e');
      return PlatformioBuildResult(
        success: false,
        output: '',
        errorOutput: e.toString(),
        duration: 0,
      );
    }
  }

  Future<PlatformioBuildResult> uploadProject(
    Session session,
    PlatformioProject project,
    String? port,
  ) async {
    try {
      final startTime = DateTime.now();

      session.log('Uploading project at path: ${project.path}' +
          (port != null ? ' to port: $port' : ''));

      final result =
          await _platformioService.uploadProject(project.path, port: port);

      final endTime = DateTime.now();
      final duration = endTime.difference(startTime).inMilliseconds;

      return PlatformioBuildResult(
        success: result.exitCode == 0,
        output: result.stdout.toString(),
        errorOutput: result.exitCode != 0 ? result.stderr.toString() : null,
        duration: duration,
      );
    } catch (e) {
      session.log('Error uploading project: $e');
      return PlatformioBuildResult(
        success: false,
        output: '',
        errorOutput: e.toString(),
        duration: 0,
      );
    }
  }

  // OTA Upload
  Future<PlatformioBuildResult> uploadProjectOTA(
    Session session,
    PlatformioProject project,
    String ipAddress,
    int port,
  ) async {
    try {
      final startTime = DateTime.now();

      session.log('OTA Uploading project to IP: $ipAddress:$port');

      final result = await _platformioService.uploadOTA(project.path, ipAddress,
          port: port);

      final endTime = DateTime.now();
      final duration = endTime.difference(startTime).inMilliseconds;

      return PlatformioBuildResult(
        success: result.exitCode == 0,
        output: result.stdout.toString(),
        errorOutput: result.exitCode != 0 ? result.stderr.toString() : null,
        duration: duration,
      );
    } catch (e) {
      session.log('Error OTA uploading project: $e');
      return PlatformioBuildResult(
        success: false,
        output: '',
        errorOutput: e.toString(),
        duration: 0,
      );
    }
  }

  // Gestione boards
  Future<List<PlatformioBoard>> listBoards(Session session) async {
    try {
      session.log('Listing available boards');
      final result = await _platformioService.listBoards();

      if (result.exitCode != 0) {
        session.log('Failed to list boards: ${result.stderr}');
        return [];
      }

      // Log the raw output for debugging
      session.log(
          'Board list output sample: ${result.stdout.toString().substring(0, min(200, result.stdout.toString().length))}...');

      try {
        final List<Map<String, dynamic>> rawBoards =
            List<Map<String, dynamic>>.from(
                jsonDecode(result.stdout.toString()));

        return rawBoards.map((board) {
          // Estrai i framework in modo sicuro
          List<String> frameworks = [];
          if (board['frameworks'] is List) {
            frameworks = List<String>.from(
                (board['frameworks'] as List).map((item) => item.toString()));
          }

          return PlatformioBoard(
            id: board['id']?.toString() ?? '',
            name: board['name']?.toString() ?? '',
            platform: board['platform']?.toString() ?? '',
            frameworks: frameworks,
            vendor: board['vendor']?.toString(),
            url: board['url']?.toString(),
          );
        }).toList();
      } catch (jsonError) {
        session.log('Error parsing board JSON: $jsonError');
        return [];
      }
    } catch (e) {
      session.log('Error listing boards: $e');
      return [];
    }
  }

  Future<List<PlatformioBoard>> searchBoards(
      Session session, String query) async {
    try {
      session.log('Searching boards with query: $query');
      final result = await _platformioService.searchBoard(query);

      if (result.exitCode != 0) {
        session.log('Board search failed: ${result.stderr}');
        return [];
      }

      try {
        final List<Map<String, dynamic>> rawBoards =
            List<Map<String, dynamic>>.from(
                jsonDecode(result.stdout.toString()));

        return rawBoards.map((board) {
          List<String> frameworks = [];
          if (board['frameworks'] is List) {
            frameworks = List<String>.from(
                (board['frameworks'] as List).map((item) => item.toString()));
          }

          return PlatformioBoard(
            id: board['id']?.toString() ?? '',
            name: board['name']?.toString() ?? '',
            platform: board['platform']?.toString() ?? '',
            frameworks: frameworks,
            vendor: board['vendor']?.toString(),
            url: board['url']?.toString(),
          );
        }).toList();
      } catch (jsonError) {
        session.log('Error parsing board search JSON: $jsonError');
        return [];
      }
    } catch (e) {
      session.log('Error searching boards: $e');
      return [];
    }
  }

  // Gestione dispositivi
  Future<List<PlatformioDevice>> listDevices(Session session) async {
    try {
      session.log('Listing connected devices');
      final result = await _platformioService.listDevices();

      if (result.exitCode != 0) {
        session.log('Failed to list devices: ${result.stderr}');
        return [];
      }

      // Log the raw output for debugging
      session.log('Device list output: ${result.stdout}');

      try {
        final List<Map<String, dynamic>> rawDevices =
            List<Map<String, dynamic>>.from(
                jsonDecode(result.stdout.toString()));

        return rawDevices.map((device) {
          return PlatformioDevice(
            port: device['port']?.toString() ?? '',
            description: device['description']?.toString(),
            hwid: device['hwid']?.toString(),
            vendorId: device['vid']?.toString(),
            productId: device['pid']?.toString(),
          );
        }).toList();
      } catch (jsonError) {
        session.log('Error parsing device JSON: $jsonError');
        return [];
      }
    } catch (e) {
      session.log('Error listing devices: $e');
      return [];
    }
  }

  // Gestione librerie
  Future<bool> installLibrary(
    Session session,
    PlatformioProject project,
    String library,
  ) async {
    try {
      session.log('Installing library: $library for project: ${project.name}');
      final result =
          await _platformioService.installLibrary(project.path, library);

      if (result.exitCode != 0) {
        session.log('Failed to install library: ${result.stderr}');
      }

      return result.exitCode == 0;
    } catch (e) {
      session.log('Error installing library: $e');
      return false;
    }
  }

  Future<List<PlatformioLibrary>> searchLibraries(
      Session session, String query) async {
    try {
      session.log('Searching libraries with query: $query');
      final result = await _platformioService.searchLibrary(query);

      if (result.exitCode != 0) {
        session.log('Library search failed: ${result.stderr}');
        return [];
      }

      try {
        final Map<String, dynamic> rawData =
            jsonDecode(result.stdout.toString());
        final List<Map<String, dynamic>> rawLibraries =
            List<Map<String, dynamic>>.from(rawData['items'] ?? []);

        return rawLibraries.map((lib) {
          return PlatformioLibrary(
            id: lib['id']?.toString() ?? '',
            name: lib['name']?.toString() ?? '',
            description: lib['description']?.toString() ?? '',
            version: lib['version']?.toString() ?? '',
            exampleCount: lib['exampleCount'] as int? ?? 0,
            authorName: lib['authorName']?.toString(),
            homepage: lib['homepage']?.toString(),
          );
        }).toList();
      } catch (jsonError) {
        session.log('Error parsing library search JSON: $jsonError');
        return [];
      }
    } catch (e) {
      session.log('Error searching libraries: $e');
      return [];
    }
  }

  Future<bool> updateLibraryIndex(Session session) async {
    try {
      session.log('Updating library index');
      final result = await _platformioService.updateLibraryIndex();
      return result.exitCode == 0;
    } catch (e) {
      session.log('Error updating library index: $e');
      return false;
    }
  }

  // File edit operations
  Future<String?> readProjectFile(Session session, String path) async {
    try {
      session.log('Reading file: $path');
      return await _platformioService.readFileInContainer(path);
    } catch (e) {
      session.log('Error reading file: $e');
      return null;
    }
  }

  Future<bool> writeProjectFile(
      Session session, String path, String content) async {
    try {
      session.log('Writing file: $path');
      return await _platformioService.writeFileInContainer(path, content);
    } catch (e) {
      session.log('Error writing file: $e');
      return false;
    }
  }

  Future<List<String>> listProjectFiles(
      Session session, String projectPath) async {
    try {
      session.log('Listing files in: $projectPath');
      return await _platformioService.listFilesInContainer(projectPath);
    } catch (e) {
      session.log('Error listing files: $e');
      return [];
    }
  }

  // Board platform operations
  Future<List<PlatformioPlatform>> listPlatforms(Session session) async {
    try {
      session.log('Listing installed platforms');
      final result = await _platformioService.platformList();

      if (result.exitCode != 0) {
        session.log('Failed to list platforms: ${result.stderr}');
        return [];
      }

      try {
        final List<Map<String, dynamic>> rawPlatforms =
            List<Map<String, dynamic>>.from(
                jsonDecode(result.stdout.toString()));

        return rawPlatforms.map((platform) {
          return PlatformioPlatform(
            name: platform['name']?.toString() ?? '',
            version: platform['version']?.toString() ?? '',
            packageName: platform['packageName']?.toString() ?? '',
            title: platform['title']?.toString() ?? '',
            description: platform['description']?.toString() ?? '',
          );
        }).toList();
      } catch (jsonError) {
        session.log('Error parsing platform JSON: $jsonError');
        return [];
      }
    } catch (e) {
      session.log('Error listing platforms: $e');
      return [];
    }
  }

  Future<bool> installPlatform(Session session, String platform) async {
    try {
      session.log('Installing platform: $platform');
      final result = await _platformioService.platformInstall(platform);
      return result.exitCode == 0;
    } catch (e) {
      session.log('Error installing platform: $e');
      return false;
    }
  }

  Future<bool> updatePlatforms(Session session) async {
    try {
      session.log('Updating platforms');
      final result = await _platformioService.platformUpdate();
      return result.exitCode == 0;
    } catch (e) {
      session.log('Error updating platforms: $e');
      return false;
    }
  }

  Future<List<PlatformioProject>> syncProjects(Session session) async {
    try {
      session.log('Syncing projects from file system');

      // Verifica prima se il container è in esecuzione
      final containerCheck =
          await Process.run('docker', ['ps', '--format', '{{.Names}}']);
      if (!containerCheck.stdout.toString().contains('platformio')) {
        session.log('PlatformIO container is not running!');
        return [];
      }

      // Verifica la directory dei progetti nel container
      final dirCheck = await Process.run('docker',
          ['exec', 'platformio', 'ls', '-la', '/platformio/projects']);
      session.log('Directory check result: ${dirCheck.stdout}');

      // Ottiene progetti dal database
      final dbProjects = await PlatformioProject.db.find(session);
      session.log('Found ${dbProjects.length} projects in database');

      Map<String, PlatformioProject> dbProjectsByPath = {};
      for (var project in dbProjects) {
        dbProjectsByPath[project.path] = project;
      }

      // Scansiona progetti nel file system con path esplicito
      final fsProjects =
          await _platformioService.scanExistingProjects('/platformio/projects');
      session.log('Found ${fsProjects.length} projects in file system');

      // Log di ogni progetto trovato
      for (var projectInfo in fsProjects) {
        session.log(
            'Found project: ${projectInfo['name']} at ${projectInfo['path']}');
      }

      // Sincronizza aggiunte
      int addedCount = 0;
      for (var projectInfo in fsProjects) {
        final path = projectInfo['path'] as String;

        // Verifica se il progetto è già nel DB
        if (!dbProjectsByPath.containsKey(path)) {
          // Nuovo progetto da aggiungere al DB
          final project = PlatformioProject(
            name: projectInfo['name'] as String,
            path: path,
            description: null,
            board: projectInfo['board'] as String? ?? 'unknown',
            framework: projectInfo['framework'] as String? ?? 'unknown',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          session
              .log('Adding project to DB: ${project.name} at ${project.path}');
          try {
            await PlatformioProject.db.insertRow(session, project);
            addedCount++;
          } catch (insertError) {
            session.log('Error inserting project: $insertError');
          }
        }
      }

      session.log('Added $addedCount new projects to database');

      // Aggiorna i progetti dal DB
      final updatedProjects = await PlatformioProject.db.find(session);
      session.log('Returning ${updatedProjects.length} projects after sync');
      return updatedProjects;
    } catch (e) {
      session.log('Error syncing projects: $e');
      // Restituisci i progetti dal DB in caso di errore
      try {
        return await PlatformioProject.db.find(session);
      } catch (findError) {
        session.log('Error fetching projects after sync error: $findError');
        return [];
      }
    }
  }

  Future<Map<String, String>> executeDockerCommand(
    Session session,
    String command,
  ) async {
    try {
      session.log('Executing Docker command: $command');

      // Dividi il comando in parti
      final parts = command.split(' ');
      if (parts.isEmpty) {
        return {
          'success': 'false',
          'error': 'Empty command',
        };
      }

      // Comando Docker exec per il container platformio
      final List<String> dockerArgs = ['exec', 'platformio', ...parts];

      final result = await Process.run('docker', dockerArgs);

      return {
        'success': result.exitCode == 0 ? 'true' : 'false',
        'stdout': result.stdout.toString(),
        'stderr': result.stderr.toString(),
        'exitCode': result.exitCode.toString(),
      };
    } catch (e) {
      session.log('Error executing Docker command: $e');
      return {
        'success': 'false',
        'error': e.toString(),
      };
    }
  }
}
