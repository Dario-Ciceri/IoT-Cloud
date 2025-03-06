import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/arduino.dart';

import 'package:iot_cloud_client/iot_cloud_client.dart';

void main() {
  // Inizializza il client Serverpod
  final client = Client('http://localhost:8080/');

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlatformIO IDE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: PlatformIOIDE(client: client),
    ),
  );
}

class PlatformIOIDE extends StatefulWidget {
  final Client client;

  const PlatformIOIDE({Key? key, required this.client}) : super(key: key);

  @override
  State<PlatformIOIDE> createState() => _PlatformIOIDEState();
}

class _PlatformIOIDEState extends State<PlatformIOIDE>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _dockerCommandController = TextEditingController();

  // Stato dell'editor
  final CodeController _codeController = CodeController(
    language: arduino,
  );

  // Stato
  List<PlatformioProject> _projects = [];
  List<PlatformioBoard> _boards = [];
  List<PlatformioDevice> _devices = [];
  List<PlatformioLibrary> _searchedLibraries = [];
  List<String> _projectFiles = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Form controllers
  final _projectNameController = TextEditingController();
  final _projectPathController = TextEditingController();
  final _boardController = TextEditingController();
  final _frameworkController = TextEditingController();
  final _librarySearchController = TextEditingController();
  final _ipAddressController = TextEditingController();

  String? _selectedBoard;
  String? _selectedFramework;
  PlatformioProject? _selectedProject;
  String? _selectedFile;
  String? _selectedDevice;
  int _currentTab = 0;
  bool _fileModified = false;

  // Base path per i progetti
  final String _basePath = '/platformio/projects/';

  Future<void> _executeDockerCommand(String command) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result =
          await widget.client.platformio.executeDockerCommand(command);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            result['success'] == 'true'
                ? 'Comando eseguito con successo'
                : 'Errore',
            style: TextStyle(
              color: result['success'] == 'true' ? Colors.green : Colors.red,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Comando: $command'),
                const SizedBox(height: 8),
                Text('Exit code: ${result['exitCode'] ?? 'N/A'}'),
                const Divider(),
                if (result['stdout'] != null && result['stdout']!.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Output:',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SelectableText(
                          result['stdout']!,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (result['stderr'] != null && result['stderr']!.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade900,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Errore:',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SelectableText(
                          result['stderr']!,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (result['error'] != null)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Text('Errore: ${result['error']}'),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Chiudi'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Errore: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _syncProjects() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Mostra subito feedback che l'operazione è iniziata
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sincronizzazione progetti in corso...'),
          duration: Duration(seconds: 1),
        ),
      );

      final projects = await widget.client.platformio.syncProjects();

      setState(() {
        _projects = projects;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sincronizzati ${projects.length} progetti'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Errore durante la sincronizzazione: $e';
      });

      // Mostra un dialogo con l'errore dettagliato
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Errore sincronizzazione'),
          content: SingleChildScrollView(
            child: Text('Dettagli errore:\n$e'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Chiudi'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    // Imposta un valore predefinito per il percorso del progetto
    _projectPathController.text = _basePath + 'my_project';

    // Aggiungi listener al nome per aggiornare automaticamente il path
    _projectNameController.addListener(_updatePathFromName);

    // Aggiungi listener per editore file
    _codeController.addListener(() {
      if (!_fileModified) {
        setState(() {
          _fileModified = true;
        });
      }
    });

    _tabController.addListener(() {
      setState(() {
        _currentTab = _tabController.index;
      });
    });

    _loadInitialData();
  }

  void _updatePathFromName() {
    final name = _projectNameController.text.trim();
    if (name.isNotEmpty) {
      // Converte il nome in un formato valido per un path
      final safeName = name
          .toLowerCase()
          .replaceAll(RegExp(r'[^\w\s]'), '')
          .replaceAll(RegExp(r'\s+'), '_');

      _projectPathController.text = _basePath + safeName;
    } else {
      _projectPathController.text = _basePath + 'my_project';
    }
  }

  @override
  void dispose() {
    _projectNameController.removeListener(_updatePathFromName);
    _projectNameController.dispose();
    _projectPathController.dispose();
    _boardController.dispose();
    _frameworkController.dispose();
    _librarySearchController.dispose();
    _ipAddressController.dispose();
    _codeController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Prima verifica PlatformIO
      final status = await widget.client.platformio.checkPlatformIO();
      if (!status.installed) {
        setState(() {
          _errorMessage =
              'PlatformIO non trovato! Errore: ${status.errorMessage ?? "Sconosciuto"}';
          _isLoading = false;
        });
        return;
      }

      // Carica dati
      await Future.wait([
        _loadProjects(),
        _loadBoards(),
        _loadDevices(),
      ]);
    } catch (e) {
      setState(() {
        _errorMessage = 'Errore di inizializzazione: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadProjects() async {
    try {
      final projects = await widget.client.platformio.listProjects();
      setState(() {
        _projects = projects;
      });
    } catch (e) {
      print('Error loading projects: $e');
    }
  }

  Future<void> _loadBoards() async {
    try {
      final boards = await widget.client.platformio.listBoards();
      setState(() {
        _boards = boards;
      });
    } catch (e) {
      print('Error loading boards: $e');
    }
  }

  Future<void> _loadDevices() async {
    try {
      final devices = await widget.client.platformio.listDevices();
      setState(() {
        _devices = devices;
      });
    } catch (e) {
      print('Error loading devices: $e');
    }
  }

  Future<void> _loadProjectFiles() async {
    if (_selectedProject == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final files = await widget.client.platformio
          .listProjectFiles(_selectedProject!.path);
      setState(() {
        _projectFiles = files;
      });
    } catch (e) {
      print('Error loading project files: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _openFile(String filePath) async {
    if (_fileModified) {
      // Chiedi conferma prima di cambiare file
      final shouldProceed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('File modificato'),
          content: const Text(
              'Hai modifiche non salvate. Continuare senza salvare?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Annulla'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Continua'),
            ),
          ],
        ),
      );

      if (shouldProceed != true) return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final content = await widget.client.platformio.readProjectFile(filePath);
      if (content != null) {
        setState(() {
          _selectedFile = filePath;
          _codeController.text = content;
          _fileModified = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Impossibile aprire il file'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error opening file: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveFile() async {
    if (_selectedFile == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await widget.client.platformio.writeProjectFile(
        _selectedFile!,
        _codeController.text,
      );

      if (result) {
        setState(() {
          _fileModified = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('File salvato con successo'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Errore durante il salvataggio'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error saving file: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _createProject() async {
    final name = _projectNameController.text;
    final path = _projectPathController.text;
    final board = _selectedBoard ?? _boardController.text;
    final framework = _selectedFramework ?? _frameworkController.text;

    if (name.isEmpty || path.isEmpty || board.isEmpty || framework.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Compila tutti i campi obbligatori'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final success = await widget.client.platformio.initProject(
        path,
        board,
        framework,
        name,
        null, // descrizione opzionale
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Progetto creato con successo')),
        );

        // Pulisci form
        _projectNameController.text = '';
        _selectedBoard = null;
        _selectedFramework = null;

        // Aggiorna lista progetti
        await _loadProjects();

        // Seleziona il nuovo progetto
        final newProject = _projects.firstWhere(
          (p) => p.path == path,
          orElse: () => _projects.last,
        );

        setState(() {
          _selectedProject = newProject;
        });

        // Carica i file del progetto
        _loadProjectFiles();

        // Passa alla scheda Editor
        _tabController.animateTo(1);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Errore nella creazione del progetto'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Errore: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _buildProject() async {
    if (_selectedProject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Seleziona un progetto'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Salva prima di compilare
    if (_fileModified && _selectedFile != null) {
      await _saveFile();
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final result =
          await widget.client.platformio.buildProject(_selectedProject!);

      setState(() {
        _isLoading = false;
      });

      // Mostra risultato
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            result.success ? 'Build completato' : 'Build fallito',
            style: TextStyle(
              color: result.success ? Colors.green : Colors.red,
            ),
          ),
          content: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Durata: ${result.duration} ms'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: SelectableText(
                      result.success
                          ? result.output
                          : (result.errorOutput ?? 'Errore sconosciuto'),
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Chiudi'),
            ),
          ],
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Errore: $e';
      });
    }
  }

  Future<void> _uploadProject() async {
    if (_selectedProject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Seleziona un progetto'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Chiedi modalità di upload
    String uploadMode = 'serial';
    String? selectedDevice = _selectedDevice;
    String ipAddress = '';

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Modalità di upload'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Radio button per modalità
                RadioListTile<String>(
                  title: const Text('Seriale'),
                  value: 'serial',
                  groupValue: uploadMode,
                  onChanged: (value) {
                    setDialogState(() {
                      uploadMode = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('OTA (Over The Air)'),
                  value: 'ota',
                  groupValue: uploadMode,
                  onChanged: (value) {
                    setDialogState(() {
                      uploadMode = value!;
                    });
                  },
                ),

                const SizedBox(height: 16),

                // Mostra selezione in base alla modalità
                if (uploadMode == 'serial')
                  _devices.isEmpty
                      ? const Text('Nessun dispositivo seriale rilevato')
                      : DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Dispositivo',
                            border: OutlineInputBorder(),
                          ),
                          value: selectedDevice,
                          items: _devices.map((device) {
                            return DropdownMenuItem<String>(
                              value: device.port,
                              child: Text(
                                  '${device.port} (${device.description ?? "Sconosciuto"})'),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setDialogState(() {
                              selectedDevice = value;
                            });
                          },
                        )
                else
                  TextField(
                    controller: _ipAddressController,
                    decoration: const InputDecoration(
                      labelText: 'Indirizzo IP',
                      border: OutlineInputBorder(),
                      hintText: '192.168.1.100',
                    ),
                    onChanged: (value) {
                      ipAddress = value;
                    },
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Annulla'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Upload'),
              ),
            ],
          );
        },
      ),
    ).then((confirmed) async {
      if (confirmed != true) return;

      // Salva prima di upload
      if (_fileModified && _selectedFile != null) {
        await _saveFile();
      }

      setState(() {
        _isLoading = true;
      });

      try {
        PlatformioBuildResult result;

        if (uploadMode == 'serial') {
          // Upload via seriale
          result = await widget.client.platformio.uploadProject(
            _selectedProject!,
            selectedDevice,
          );
        } else {
          // Upload via OTA
          if (_ipAddressController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Inserisci un indirizzo IP valido'),
                backgroundColor: Colors.red,
              ),
            );
            setState(() {
              _isLoading = false;
            });
            return;
          }

          result = await widget.client.platformio.uploadProjectOTA(
            _selectedProject!,
            _ipAddressController.text,
            3232, // default OTA port
          );
        }

        setState(() {
          _isLoading = false;
        });

        // Mostra risultato
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              result.success ? 'Upload completato' : 'Upload fallito',
              style: TextStyle(
                color: result.success ? Colors.green : Colors.red,
              ),
            ),
            content: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Durata: ${result.duration} ms'),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: SelectableText(
                        result.success
                            ? result.output
                            : (result.errorOutput ?? 'Errore sconosciuto'),
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Chiudi'),
              ),
            ],
          ),
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Errore: $e';
        });
      }
    });
  }

  Future<void> _searchLibraries() async {
    if (_librarySearchController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final libraries = await widget.client.platformio.searchLibraries(
        _librarySearchController.text,
      );

      setState(() {
        _searchedLibraries = libraries;
      });
    } catch (e) {
      print('Error searching libraries: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _installLibrary(PlatformioLibrary library) async {
    if (_selectedProject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Seleziona un progetto'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await widget.client.platformio.installLibrary(
        _selectedProject!,
        library.id,
      );

      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Libreria ${library.name} installata con successo'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Errore durante l\'installazione della libreria ${library.name}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error installing library: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Costruzione dell'UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlatformIO IDE'),
        actions: [
          if (_selectedFile != null && _fileModified)
            IconButton(
              icon: const Icon(Icons.save),
              tooltip: 'Salva file',
              onPressed: _saveFile,
            ),
          if (_selectedProject != null)
            IconButton(
              icon: const Icon(Icons.build),
              tooltip: 'Compila',
              onPressed: _buildProject,
            ),
          if (_selectedProject != null)
            IconButton(
              icon: const Icon(Icons.upload),
              tooltip: 'Upload',
              onPressed: _uploadProject,
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Aggiorna',
            onPressed: () {
              _loadInitialData();
              if (_selectedProject != null) {
                _loadProjectFiles();
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.add_box), text: 'Nuovo'),
            Tab(icon: Icon(Icons.code), text: 'Editor'),
            Tab(icon: Icon(Icons.developer_board), text: 'Board'),
            Tab(icon: Icon(Icons.book), text: 'Librerie'),
            Tab(icon: Icon(Icons.settings), text: 'Strumenti'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildNewProjectTab(),
                _buildEditorTab(),
                _buildBoardsTab(),
                _buildLibrariesTab(),
                _buildToolsTab(),
              ],
            ),
    );
  }

  // Tab per creare nuovo progetto
  Widget _buildNewProjectTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Messaggio di errore se presente
          if (_errorMessage != null)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Errore',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(_errorMessage!),
                ],
              ),
            ),

          // Form creazione progetto
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Crea nuovo progetto',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _projectNameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome progetto',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.create_new_folder),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _projectPathController,
                    decoration: const InputDecoration(
                      labelText: 'Percorso (aggiornato automaticamente)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.folder),
                      helperText:
                          'Il percorso deve essere all\'interno di /platformio/projects/',
                    ),
                    enabled: false,
                  ),
                  const SizedBox(height: 16),

                  // Board e framework
                  _boards.isNotEmpty
                      ? DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Scheda',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.developer_board),
                          ),
                          value: _selectedBoard,
                          hint: const Text('Seleziona scheda'),
                          isExpanded: true,
                          items: _boards.map((board) {
                            return DropdownMenuItem<String>(
                              value: board.id,
                              child: Text('${board.name} (${board.id})'),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedBoard = value;
                              _selectedFramework = null;
                            });
                          },
                        )
                      : TextField(
                          controller: _boardController,
                          decoration: const InputDecoration(
                            labelText: 'ID Scheda',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.developer_board),
                            helperText: 'Es: uno_r4_wifi, nodemcu, esp32dev',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedBoard = value;
                            });
                          },
                        ),

                  const SizedBox(height: 16),

                  // Framework dropdown o input
                  _boards.isNotEmpty &&
                          _selectedBoard != null &&
                          _boards.any((b) => b.id == _selectedBoard)
                      ? DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Framework',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.layers),
                          ),
                          value: _selectedFramework,
                          hint: const Text('Seleziona framework'),
                          isExpanded: true,
                          items: _boards
                              .firstWhere((b) => b.id == _selectedBoard)
                              .frameworks
                              .map((framework) {
                            return DropdownMenuItem<String>(
                              value: framework,
                              child: Text(framework),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedFramework = value;
                            });
                          },
                        )
                      : TextField(
                          controller: _frameworkController,
                          decoration: const InputDecoration(
                            labelText: 'Framework',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.layers),
                            helperText: 'Es: arduino, espidf',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedFramework = value;
                            });
                          },
                        ),

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add_box),
                      label: const Text('Crea Progetto'),
                      onPressed: _createProject,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Lista progetti esistenti
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sincronizzazione progetti',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Cerca progetti PlatformIO esistenti nel container e li sincronizza con il database.',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.sync),
                                  label: const Text(
                                      'Sincronizza progetti esistenti'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: _syncProjects,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Progetti esistenti',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('(${_projects.length} progetti)'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_projects.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Nessun progetto trovato'),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _projects.length,
                      itemBuilder: (context, index) {
                        final project = _projects[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: const Icon(Icons.folder_open),
                            title: Text(project.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Path: ${project.path}'),
                                Text('Board: ${project.board ?? "N/A"}'),
                                Text(
                                    'Framework: ${project.framework ?? "N/A"}'),
                              ],
                            ),
                            isThreeLine: true,
                            selected: _selectedProject?.id == project.id,
                            onTap: () {
                              setState(() {
                                _selectedProject = project;
                              });
                              _loadProjectFiles();
                              _tabController
                                  .animateTo(1); // Switch to editor tab
                            },
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tab per l'editor di codice
  Widget _buildEditorTab() {
    return _selectedProject == null
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.folder_open, size: 80, color: Colors.grey),
                const SizedBox(height: 16),
                const Text(
                  'Nessun progetto selezionato',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    _tabController.animateTo(0);
                  },
                  child: const Text('Seleziona o crea un progetto'),
                ),
              ],
            ),
          )
        : Row(
            children: [
              // File explorer
              SizedBox(
                width: 250,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          _selectedProject!.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Divider(height: 1),

                      // File list
                      Expanded(
                        child: _projectFiles.isEmpty
                            ? const Center(
                                child: Text('Nessun file trovato'),
                              )
                            : ListView.builder(
                                itemCount: _projectFiles.length,
                                itemBuilder: (context, index) {
                                  final filePath = _projectFiles[index];
                                  final fileName = filePath.split('/').last;

                                  // Skip non-source files for brevity
                                  if (!fileName.endsWith('.cpp') &&
                                      !fileName.endsWith('.h') &&
                                      !fileName.endsWith('.ino') &&
                                      !fileName.endsWith('.ini') &&
                                      !fileName.endsWith('.txt')) {
                                    return const SizedBox.shrink();
                                  }

                                  return ListTile(
                                    leading: Icon(
                                      _getIconForFile(fileName),
                                      color: _getColorForFile(fileName),
                                    ),
                                    title: Text(fileName),
                                    dense: true,
                                    selected: _selectedFile == filePath,
                                    onTap: () {
                                      _openFile(filePath);
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),

              // Editor
              Expanded(
                child: _selectedFile == null
                    ? const Center(
                        child: Text('Seleziona un file da modificare'),
                      )
                    : Column(
                        children: [
                          // File path header
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.grey[800]
                                  : Colors.grey[200],
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).dividerColor,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _selectedFile!.replaceFirst(
                                        _selectedProject!.path, ''),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ),
                                if (_fileModified)
                                  const Text(
                                    '• Modificato',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12,
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          // Code editor
                          Expanded(
                            child: CodeTheme(
                              data: CodeThemeData(
                                styles: monokaiSublimeTheme,
                              ),
                              child: SingleChildScrollView(
                                child: CodeField(
                                  controller: _codeController,
                                  gutterStyle: GutterStyle(
                                    width: 48,
                                    margin: 16,
                                  ),
                                  textStyle: const TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          );
  }

  // Tab per gestione boards
  Widget _buildBoardsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sezione dispositivi connessi
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Dispositivi connessi',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        tooltip: 'Aggiorna dispositivi',
                        onPressed: _loadDevices,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_devices.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Nessun dispositivo rilevato'),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _devices.length,
                      itemBuilder: (context, index) {
                        final device = _devices[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: const Icon(Icons.usb),
                            title: Text(device.port),
                            subtitle: Text(device.description ??
                                'Dispositivo sconosciuto'),
                            trailing: IconButton(
                              icon: const Icon(Icons.check_circle),
                              tooltip: 'Seleziona per upload',
                              onPressed: () {
                                setState(() {
                                  _selectedDevice = device.port;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Dispositivo ${device.port} selezionato per upload'),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Sezione OTA
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Upload Over-The-Air (OTA)',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _ipAddressController,
                    decoration: const InputDecoration(
                      labelText: 'Indirizzo IP del dispositivo',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.wifi),
                      hintText: 'Es: 192.168.1.100',
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Upload OTA'),
                      onPressed:
                          _selectedProject == null ? null : _uploadProject,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Sezione schede disponibili
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Schede disponibili',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('(${_boards.length} schede)'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_boards.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Nessuna scheda trovata'),
                      ),
                    )
                  else
                    // Mostriamo solo le prime 10 schede per brevità
                    Column(
                      children: _boards.take(10).map((board) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: const Icon(Icons.developer_board),
                            title: Text('${board.name} (${board.id})'),
                            subtitle: Text(
                              'Platform: ${board.platform}\n'
                              'Frameworks: ${board.frameworks.join(", ")}',
                            ),
                            isThreeLine: true,
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tab per gestione librerie
  Widget _buildLibrariesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ricerca librerie
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cerca librerie',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _librarySearchController,
                          decoration: const InputDecoration(
                            labelText: 'Nome o keyword',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Es: DHT11, WiFi, MQTT...',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _searchLibraries,
                        child: const Text('Cerca'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Risultati ricerca
          if (_searchedLibraries.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Risultati ricerca',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('(${_searchedLibraries.length} librerie)'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _searchedLibraries.length,
                      itemBuilder: (context, index) {
                        final library = _searchedLibraries[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: const Icon(Icons.book),
                            title: Text('${library.name} v${library.version}'),
                            subtitle: Text(library.description),
                            isThreeLine: true,
                            trailing: IconButton(
                              icon: const Icon(Icons.add),
                              tooltip: 'Installa nel progetto corrente',
                              onPressed: () {
                                _installLibrary(library);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Tab per strumenti vari
  Widget _buildToolsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stato PlatformIO
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Stato PlatformIO',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Verifica PlatformIO'),
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        final status =
                            await widget.client.platformio.checkPlatformIO();

                        setState(() {
                          _isLoading = false;
                        });

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              status.installed
                                  ? 'PlatformIO installato!'
                                  : 'PlatformIO non trovato',
                              style: TextStyle(
                                color: status.installed
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Versione: ${status.version}'),
                                if (status.errorMessage != null)
                                  Text(
                                    'Errore: ${status.errorMessage}',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Chiudi'),
                              ),
                            ],
                          ),
                        );
                      } catch (e) {
                        setState(() {
                          _isLoading = false;
                          _errorMessage = 'Errore: $e';
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Diagnostica Docker',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Esegui comandi Docker direttamente nel container platformio',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),

                  // Pulsanti per comandi comuni
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () => _executeDockerCommand(
                            'ls -la /platformio/projects'),
                        child: const Text('List Projects Dir'),
                      ),
                      ElevatedButton(
                        onPressed: () => _executeDockerCommand(
                            'find /platformio -type d -name "projects"'),
                        child: const Text('Find Projects Dir'),
                      ),
                      ElevatedButton(
                        onPressed: () => _executeDockerCommand(
                            'find /platformio -name "platformio.ini"'),
                        child: const Text('Find platformio.ini'),
                      ),
                      ElevatedButton(
                        onPressed: () => _executeDockerCommand('pwd'),
                        child: const Text('Current Dir'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Campo per comando personalizzato
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _dockerCommandController,
                          decoration: const InputDecoration(
                            labelText: 'Comando Docker',
                            hintText: 'Es: ls -la /platformio',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (_dockerCommandController.text.isNotEmpty) {
                            _executeDockerCommand(
                                _dockerCommandController.text);
                          }
                        },
                        child: const Text('Esegui'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Informazioni
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Informazioni',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Questo IDE consente di gestire progetti PlatformIO, '
                    'compilarli e caricarli su dispositivi tramite seriale o OTA. '
                    'È possibile anche gestire librerie e piattaforme.',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'PlatformIO è integrato tramite Docker, quindi tutti i percorsi '
                    'dei progetti devono essere relativi al container Docker.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Utility per determinare icona e colore dei file
  IconData _getIconForFile(String fileName) {
    if (fileName.endsWith('.cpp') ||
        fileName.endsWith('.h') ||
        fileName.endsWith('.ino')) {
      return Icons.code;
    } else if (fileName.endsWith('.ini')) {
      return Icons.settings;
    } else if (fileName.endsWith('.txt') || fileName.endsWith('.md')) {
      return Icons.description;
    } else {
      return Icons.insert_drive_file;
    }
  }

  Color _getColorForFile(String fileName) {
    if (fileName.endsWith('.cpp') || fileName.endsWith('.ino')) {
      return Colors.blue;
    } else if (fileName.endsWith('.h')) {
      return Colors.purple;
    } else if (fileName.endsWith('.ini')) {
      return Colors.orange;
    } else {
      return Colors.grey;
    }
  }
}
