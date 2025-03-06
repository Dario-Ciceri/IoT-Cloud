import 'dart:io';

class PlatformIOService {
  final String containerName;

  PlatformIOService({this.containerName = 'platformio'});

  Future<ProcessResult> runCommand(List<String> args,
      {String? workingDirectory}) async {
    // Usa docker exec per eseguire comandi nel container
    List<String> dockerArgs = ['exec'];

    // Aggiungi working directory se specificato
    if (workingDirectory != null) {
      dockerArgs.addAll(['-w', workingDirectory]);
    }

    // Aggiungi nome container e comando PlatformIO
    dockerArgs.addAll([containerName, 'platformio', ...args]);

    // Esegui il log del comando per debugging
    final cmdString = 'docker ${dockerArgs.join(' ')}';
    print('Executing Docker command: $cmdString');

    // Esegui il comando
    return Process.run('docker', dockerArgs);
  }

  // Lettura e scrittura file generici nel container
  Future<String?> readFileInContainer(String path) async {
    try {
      final result =
          await Process.run('docker', ['exec', containerName, 'cat', path]);

      if (result.exitCode == 0) {
        return result.stdout.toString();
      }
      return null;
    } catch (e) {
      print('Error reading file: $e');
      return null;
    }
  }

  Future<bool> writeFileInContainer(String path, String content) async {
    try {
      // Crea file temporaneo
      final tempFile =
          '/tmp/platformio_${DateTime.now().millisecondsSinceEpoch}.tmp';
      await File(tempFile).writeAsString(content);

      // Copia nel container
      final result =
          await Process.run('docker', ['cp', tempFile, '$containerName:$path']);

      // Pulisci
      await File(tempFile).delete();

      return result.exitCode == 0;
    } catch (e) {
      print('Error writing file: $e');
      return false;
    }
  }

  Future<List<String>> listFilesInContainer(String dirPath) async {
    try {
      final result = await Process.run('docker', [
        'exec',
        containerName,
        'find',
        dirPath,
        '-type',
        'f',
        '-not',
        '-path',
        '*/\\.git/*'
      ]);

      if (result.exitCode == 0) {
        return result.stdout
            .toString()
            .split('\n')
            .where((line) => line.trim().isNotEmpty)
            .toList();
      }
      return [];
    } catch (e) {
      print('Error listing files: $e');
      return [];
    }
  }

  Future<ProcessResult> initProject(
      String path, String board, String framework) async {
    // In Docker, assicurati prima che la directory esista
    try {
      await Process.run('docker', ['exec', containerName, 'mkdir', '-p', path]);
    } catch (e) {
      print('Error creating directory in container: $e');
    }

    // CORREZIONE: usa la sintassi corretta per platformio init
    final args = ['init', '-b', board];

    // Esegui il comando init nel path specificato
    final result = await runCommand(args, workingDirectory: path);

    // Se init è riuscito e il framework è specificato, aggiungiamo o aggiorniamo platformio.ini
    if (result.exitCode == 0 && framework.isNotEmpty) {
      try {
        // Leggi il contenuto attuale di platformio.ini
        final iniResult = await Process.run(
            'docker', ['exec', containerName, 'cat', '$path/platformio.ini']);

        if (iniResult.exitCode == 0) {
          String iniContent = iniResult.stdout.toString();

          // Cerca la sezione [env:boardname]
          final envSection = RegExp(r'\[env:[^\]]+\]').stringMatch(iniContent);

          if (envSection != null) {
            // Aggiungi o aggiorna framework
            if (iniContent.contains('framework =')) {
              // Sostituisci framework esistente
              iniContent = iniContent.replaceAllMapped(
                  RegExp(r'framework\s*=\s*[^\n]+'),
                  (match) => 'framework = $framework');
            } else {
              // Aggiungi framework dopo la sezione
              final index = iniContent.indexOf(envSection) + envSection.length;
              iniContent = iniContent.substring(0, index) +
                  '\nframework = $framework' +
                  iniContent.substring(index);
            }

            // Scrivi il file modificato
            await writeFileInContainer('$path/platformio.ini', iniContent);

            // Crea anche un file main.cpp base se non esiste
            await createDefaultMainFile(path, framework);
          }
        }
      } catch (e) {
        print('Error updating platformio.ini: $e');
      }
    }

    return result;
  }

  // Crea un main.cpp base in base al framework
  Future<bool> createDefaultMainFile(
      String projectPath, String framework) async {
    // Verifica se esiste già
    final srcDir = '$projectPath/src';

    // Crea directory src se non esiste
    await Process.run('docker', ['exec', containerName, 'mkdir', '-p', srcDir]);

    // Verifica se esiste già main file
    final checkResult = await Process.run(
        'docker', ['exec', containerName, 'ls', '$srcDir/main.cpp']);

    if (checkResult.exitCode == 0) {
      // File esiste già
      return true;
    }

    // Genera contenuto in base al framework
    String content = '';
    if (framework.toLowerCase() == 'arduino') {
      content = '''
#include <Arduino.h>

void setup() {
  Serial.begin(115200);
  Serial.println("Hello from PlatformIO!");
}

void loop() {
  delay(1000);
}
''';
    } else if (framework.toLowerCase() == 'espidf') {
      content = '''
#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

extern "C" void app_main() {
  printf("Hello from PlatformIO ESP-IDF!\\n");
  while (1) {
    vTaskDelay(1000 / portTICK_PERIOD_MS);
  }
}
''';
    } else {
      content = '''
#include <stdio.h>

int main() {
  printf("Hello from PlatformIO!\\n");
  return 0;
}
''';
    }

    // Scrivi file
    return writeFileInContainer('$srcDir/main.cpp', content);
  }

  Future<ProcessResult> buildProject(String projectPath) async {
    return runCommand(['run'], workingDirectory: projectPath);
  }

  Future<ProcessResult> uploadProject(String projectPath,
      {String? port}) async {
    final args = ['run', '--target', 'upload'];
    if (port != null) {
      args.addAll(['--upload-port', port]);
    }
    return runCommand(args, workingDirectory: projectPath);
  }

  // Aggiungi OTA upload
  Future<ProcessResult> uploadOTA(String projectPath, String ipAddress,
      {int port = 3232}) async {
    final args = ['run', '--target', 'upload', '--upload-port', '$ipAddress'];
    return runCommand(args, workingDirectory: projectPath);
  }

  Future<ProcessResult> listBoards() async {
    return runCommand(['boards', '--json-output']);
  }

  Future<ProcessResult> searchBoard(String query) async {
    return runCommand(['boards', query, '--json-output']);
  }

  Future<ProcessResult> listDevices() async {
    return runCommand(['device', 'list', '--json-output']);
  }

  Future<ProcessResult> installLibrary(
      String projectPath, String library) async {
    return runCommand(['lib', 'install', library],
        workingDirectory: projectPath);
  }

  Future<ProcessResult> searchLibrary(String query) async {
    return runCommand(['lib', 'search', query, '--json-output']);
  }

  Future<ProcessResult> updateLibraryIndex() async {
    return runCommand(['lib', 'update-index']);
  }

  Future<ProcessResult> libraryList(String projectPath) async {
    return runCommand(['lib', 'list'], workingDirectory: projectPath);
  }

  // Gestione board platforms
  Future<ProcessResult> platformList() async {
    return runCommand(['platform', 'list', '--json-output']);
  }

  Future<ProcessResult> platformInstall(String platform) async {
    return runCommand(['platform', 'install', platform]);
  }

  Future<ProcessResult> platformUpdate() async {
    return runCommand(['platform', 'update']);
  }

  Future<List<Map<String, dynamic>>> scanExistingProjects(
      String basePath) async {
    try {
      print('Scanning for projects in container path: $basePath');

      // Usa 'ls' invece di 'test' per verificare la directory
      final dirCheck = await Process.run(
          'docker', ['exec', containerName, 'ls', '-la', basePath]);

      print('Directory check output: ${dirCheck.stdout}');
      print('Directory check error: ${dirCheck.stderr}');

      if (dirCheck.exitCode != 0) {
        print('Cannot access directory $basePath: ${dirCheck.stderr}');
        return [];
      }

      // Usa direttamente ls per trovare i potenziali progetti (directory)
      final dirList = await Process.run(
          'docker', ['exec', containerName, 'ls', '-la', basePath]);

      if (dirList.exitCode != 0) {
        print('Error listing directories: ${dirList.stderr}');
        return [];
      }

      // Analizza l'output di ls per trovare directory
      final lines = dirList.stdout.toString().split('\n');

      // La lista dei path delle directory (escludi . e ..)
      final List<String> directories = [];

      for (final line in lines) {
        // Cerca le righe che iniziano con 'd' (directory)
        if (line.trim().startsWith('d')) {
          // Estrai il nome della directory (ultimo elemento dopo lo split)
          final parts = line.trim().split(RegExp(r'\s+'));
          if (parts.length > 8) {
            final dirName = parts.last;

            // Ignora . e ..
            if (dirName != '.' && dirName != '..') {
              final fullPath = '$basePath/$dirName';
              directories.add(fullPath);
              print('Found directory: $fullPath');
            }
          }
        }
      }

      print('Found ${directories.length} potential project directories');

      // Lista per i risultati
      final List<Map<String, dynamic>> projects = [];

      // Cerca platformio.ini in ogni directory
      for (final dir in directories) {
        final iniPath = '$dir/platformio.ini';

        // Usa cat invece di test per verificare l'esistenza del file
        final catResult = await Process.run(
            'docker', ['exec', containerName, 'cat', iniPath]);

        // Se cat ha successo, il file esiste e abbiamo il suo contenuto
        if (catResult.exitCode == 0) {
          // Abbiamo già il contenuto del file
          final iniContent = catResult.stdout.toString();

          // Estrai informazioni
          Map<String, String> projectInfo = _parseIniFile(iniContent);
          projectInfo['path'] = dir;
          projectInfo['name'] = dir.split('/').last;

          print(
              'Found project: ${projectInfo['name']} at ${projectInfo['path']}');

          projects.add(projectInfo);
        } else {
          print('No platformio.ini found at $iniPath');
        }
      }

      print('Found ${projects.length} PlatformIO projects');
      return projects;
    } catch (e) {
      print('Error scanning projects: $e');
      return [];
    }
  }

  // Analizza platformio.ini per estrarre informazioni
  Map<String, String> _parseIniFile(String iniContent) {
    Map<String, String> info = {
      'board': '',
      'framework': '',
    };

    // Cerca la sezione [env:xxx]
    final envMatch = RegExp(r'\[env:[^\]]+\]').firstMatch(iniContent);
    if (envMatch != null) {
      final envSection = iniContent.substring(envMatch.start);

      // Cerca board
      final boardMatch =
          RegExp(r'board\s*=\s*([^\s\n]+)').firstMatch(envSection);
      if (boardMatch != null && boardMatch.groupCount >= 1) {
        info['board'] = boardMatch.group(1)!.trim();
      }

      // Cerca framework
      final frameworkMatch =
          RegExp(r'framework\s*=\s*([^\s\n]+)').firstMatch(envSection);
      if (frameworkMatch != null && frameworkMatch.groupCount >= 1) {
        info['framework'] = frameworkMatch.group(1)!.trim();
      }
    }

    return info;
  }
}
