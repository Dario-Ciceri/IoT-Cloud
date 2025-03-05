import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

@RoutePage()
class FirmwareUpdatePage extends StatefulWidget {
  const FirmwareUpdatePage({super.key});

  @override
  State<FirmwareUpdatePage> createState() => _FirmwareUpdatePageState();
}

class _FirmwareUpdatePageState extends State<FirmwareUpdatePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showOnlyUpdatable = false;

  // Dati fittizi dei dispositivi
  final List<Map<String, dynamic>> _devices = [
    {
      'id': 'dev001',
      'name': 'Termostato Soggiorno',
      'type': 'ESP32',
      'model': 'ESP32-WROOM-32',
      'currentVersion': '1.2.3',
      'latestVersion': '1.3.0',
      'updateAvailable': true,
      'lastUpdated': DateTime.now().subtract(const Duration(days: 45)),
      'status': 'Online',
      'icon': Icons.thermostat,
      'updatingProgress': 0.0,
      'isUpdating': false,
    },
    {
      'id': 'dev002',
      'name': 'Sensore Porta Ingresso',
      'type': 'Arduino',
      'model': 'Arduino Nano 33 IoT',
      'currentVersion': '2.0.1',
      'latestVersion': '2.0.1',
      'updateAvailable': false,
      'lastUpdated': DateTime.now().subtract(const Duration(days: 7)),
      'status': 'Online',
      'icon': Icons.door_front_door,
      'updatingProgress': 0.0,
      'isUpdating': false,
    },
    {
      'id': 'dev003',
      'name': 'Smart Light Cucina',
      'type': 'ESP8266',
      'model': 'NodeMCU',
      'currentVersion': '0.9.2',
      'latestVersion': '1.0.0',
      'updateAvailable': true,
      'lastUpdated': DateTime.now().subtract(const Duration(days: 120)),
      'status': 'Online',
      'icon': Icons.lightbulb,
      'updatingProgress': 0.0,
      'isUpdating': false,
    },
    {
      'id': 'dev004',
      'name': 'Sensore Umidità Serra',
      'type': 'ESP32',
      'model': 'ESP32-S3',
      'currentVersion': '1.1.0',
      'latestVersion': '1.2.0',
      'updateAvailable': true,
      'lastUpdated': DateTime.now().subtract(const Duration(days: 60)),
      'status': 'Offline',
      'icon': Icons.water_drop,
      'updatingProgress': 0.0,
      'isUpdating': false,
    },
    {
      'id': 'dev005',
      'name': 'Telecamera Esterna',
      'type': 'ESP32',
      'model': 'ESP32-CAM',
      'currentVersion': '2.1.0',
      'latestVersion': '2.1.0',
      'updateAvailable': false,
      'lastUpdated': DateTime.now().subtract(const Duration(days: 15)),
      'status': 'Online',
      'icon': Icons.videocam,
      'updatingProgress': 0.0,
      'isUpdating': false,
    },
  ];

  // Dati fittizi degli aggiornamenti firmware disponibili
  final List<Map<String, dynamic>> _availableFirmwares = [
    {
      'id': 'fw001',
      'name': 'ESP32 Core Update',
      'version': '1.3.0',
      'targetDevices': ['ESP32-WROOM-32'],
      'description':
          'Aggiornamento stabile con miglioramenti alla gestione energetica e connettività WiFi.',
      'releaseDate': DateTime.now().subtract(const Duration(days: 5)),
      'size': 1.2, // In MB
      'changelog': [
        'Migliorata efficienza energetica in modalità sleep',
        'Correzione bug nella connessione WiFi',
        'Aggiunto supporto per nuovi sensori',
        'Migliorata stabilità complessiva'
      ]
    },
    {
      'id': 'fw002',
      'name': 'NodeMCU Firmware',
      'version': '1.0.0',
      'targetDevices': ['NodeMCU'],
      'description':
          'Versione stabile con nuove funzionalità e miglioramenti prestazionali.',
      'releaseDate': DateTime.now().subtract(const Duration(days: 10)),
      'size': 0.8, // In MB
      'changelog': [
        'Prima versione stabile',
        'Migliorata gestione memoria',
        'Aggiunto supporto per protocollo MQTT 5.0',
        'Ottimizzazione consumi energetici'
      ]
    },
    {
      'id': 'fw003',
      'name': 'ESP32-S3 Update',
      'version': '1.2.0',
      'targetDevices': ['ESP32-S3'],
      'description':
          'Aggiornamento con miglioramenti alla connettività Bluetooth e gestione sensori.',
      'releaseDate': DateTime.now().subtract(const Duration(days: 7)),
      'size': 1.5, // In MB
      'changelog': [
        'Migliorata la stabilità Bluetooth',
        'Aggiunto supporto per più sensori contemporanei',
        'Ottimizzazione algoritmo di lettura',
        'Corretto bug nel deep sleep'
      ]
    },
  ];

  // Dati fittizi della cronologia aggiornamenti
  final List<Map<String, dynamic>> _updateHistory = [
    {
      'id': 'upd001',
      'deviceId': 'dev002',
      'deviceName': 'Sensore Porta Ingresso',
      'fromVersion': '1.9.2',
      'toVersion': '2.0.1',
      'date': DateTime.now().subtract(const Duration(days: 7)),
      'status': 'Completato',
      'duration': '2m 34s',
    },
    {
      'id': 'upd002',
      'deviceId': 'dev005',
      'deviceName': 'Telecamera Esterna',
      'fromVersion': '2.0.8',
      'toVersion': '2.1.0',
      'date': DateTime.now().subtract(const Duration(days: 15)),
      'status': 'Completato',
      'duration': '3m 12s',
    },
    {
      'id': 'upd003',
      'deviceId': 'dev001',
      'deviceName': 'Termostato Soggiorno',
      'fromVersion': '1.1.7',
      'toVersion': '1.2.3',
      'date': DateTime.now().subtract(const Duration(days: 45)),
      'status': 'Completato',
      'duration': '2m 18s',
    },
    {
      'id': 'upd004',
      'deviceId': 'dev004',
      'deviceName': 'Sensore Umidità Serra',
      'fromVersion': '1.0.5',
      'toVersion': '1.1.0',
      'date': DateTime.now().subtract(const Duration(days: 60)),
      'status': 'Completato',
      'duration': '1m 56s',
    },
    {
      'id': 'upd005',
      'deviceId': 'dev003',
      'deviceName': 'Smart Light Cucina',
      'fromVersion': '0.8.9',
      'toVersion': '0.9.2',
      'date': DateTime.now().subtract(const Duration(days: 120)),
      'status': 'Completato',
      'duration': '2m 05s',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Filtra i dispositivi in base ai criteri attuali
  List<Map<String, dynamic>> get filteredDevices {
    if (_showOnlyUpdatable) {
      return _devices.where((d) => d['updateAvailable'] == true).toList();
    }
    return _devices;
  }

  // Avvia l'aggiornamento di un dispositivo
  void _startUpdate(String deviceId) {
    final deviceIndex = _devices.indexWhere((d) => d['id'] == deviceId);
    if (deviceIndex == -1) return;

    // Simula l'avvio dell'aggiornamento
    setState(() {
      _devices[deviceIndex]['isUpdating'] = true;
      _devices[deviceIndex]['updatingProgress'] = 0.0;
    });

    // Simula il progresso dell'aggiornamento
    Future.delayed(const Duration(milliseconds: 500), () {
      _simulateUpdateProgress(deviceId);
    });
  }

  // Simula il progresso dell'aggiornamento
  void _simulateUpdateProgress(String deviceId) {
    final deviceIndex = _devices.indexWhere((d) => d['id'] == deviceId);
    if (deviceIndex == -1 || !_devices[deviceIndex]['isUpdating']) return;

    if (_devices[deviceIndex]['updatingProgress'] < 1.0) {
      setState(() {
        _devices[deviceIndex]['updatingProgress'] += 0.1;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        _simulateUpdateProgress(deviceId);
      });
    } else {
      // Aggiornamento completato
      setState(() {
        _devices[deviceIndex]['isUpdating'] = false;
        _devices[deviceIndex]['currentVersion'] =
            _devices[deviceIndex]['latestVersion'];
        _devices[deviceIndex]['updateAvailable'] = false;
        _devices[deviceIndex]['lastUpdated'] = DateTime.now();

        // Aggiungi alla cronologia
        _updateHistory.insert(0, {
          'id': 'upd${math.Random().nextInt(1000)}',
          'deviceId': deviceId,
          'deviceName': _devices[deviceIndex]['name'],
          'fromVersion': _devices[deviceIndex]['currentVersion'],
          'toVersion': _devices[deviceIndex]['latestVersion'],
          'date': DateTime.now(),
          'status': 'Completato',
          'duration':
              '${math.Random().nextInt(3) + 1}m ${math.Random().nextInt(60)}s',
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Aggiornamento di ${_devices[deviceIndex]['name']} completato!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aggiornamenti Firmware'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Dispositivi'),
            Tab(text: 'Firmware Disponibili'),
            Tab(text: 'Cronologia'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Controlla aggiornamenti',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Ricerca aggiornamenti in corso...')),
              );
              // Simulazione ricerca aggiornamenti
              Future.delayed(const Duration(seconds: 2), () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Nessun nuovo aggiornamento trovato')),
                );
              });
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab Dispositivi
          _buildDevicesTab(),

          // Tab Firmware Disponibili
          _buildFirmwareTab(),

          // Tab Cronologia
          _buildHistoryTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Mostra dialog per caricare firmware personalizzato
          _showUploadFirmwareDialog();
        },
        tooltip: 'Carica Firmware',
        child: const Icon(Icons.upload_file),
      ),
    );
  }

  // Costruisce la tab dei dispositivi
  Widget _buildDevicesTab() {
    return Column(
      children: [
        // Filtro
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Text('Mostra solo dispositivi aggiornabili'),
              const SizedBox(width: 8),
              Switch(
                value: _showOnlyUpdatable,
                onChanged: (value) {
                  setState(() {
                    _showOnlyUpdatable = value;
                  });
                },
              ),
            ],
          ),
        ),

        // Lista dispositivi
        Expanded(
          child: filteredDevices.isEmpty
              ? const Center(
                  child: Text('Nessun dispositivo trovato'),
                )
              : ListView.builder(
                  itemCount: filteredDevices.length,
                  itemBuilder: (context, index) {
                    final device = filteredDevices[index];
                    final bool isUpdatable = device['updateAvailable'] == true;
                    final bool isOnline = device['status'] == 'Online';

                    return Slidable(
                      endActionPane: isUpdatable &&
                              isOnline &&
                              !device['isUpdating']
                          ? ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) => _startUpdate(device['id']),
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  icon: Icons.system_update,
                                  label: 'Aggiorna',
                                ),
                              ],
                            )
                          : null,
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isUpdatable
                                ? Colors.amber.withOpacity(0.2)
                                : Colors.green.withOpacity(0.2),
                            child: Icon(
                              device['icon'] as IconData,
                              color: isUpdatable ? Colors.amber : Colors.green,
                            ),
                          ),
                          title: Text(device['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${device['type']} - ${device['model']}'),
                              Text(
                                'v${device['currentVersion']} ${isUpdatable ? '→ v${device['latestVersion']} disponibile' : '(aggiornato)'}',
                                style: TextStyle(
                                  color: isUpdatable
                                      ? Colors.amber[800]
                                      : Colors.green,
                                  fontWeight: isUpdatable
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              Text(
                                'Ultimo aggiornamento: ${DateFormat('dd/MM/yyyy').format(device['lastUpdated'])}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          trailing: device['isUpdating']
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: CircularProgressIndicator(
                                        value: device['updatingProgress'],
                                        strokeWidth: 3,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                        '${(device['updatingProgress'] * 100).toInt()}%'),
                                  ],
                                )
                              : isUpdatable && isOnline
                                  ? ElevatedButton(
                                      onPressed: () =>
                                          _startUpdate(device['id']),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      child: const Text('Aggiorna'),
                                    )
                                  : isOnline
                                      ? const Icon(Icons.check_circle,
                                          color: Colors.green)
                                      : const Icon(Icons.offline_bolt,
                                          color: Colors.grey),
                          onTap: () {
                            // Mostra dettagli del dispositivo e versioni firmware
                            _showDeviceUpdateDetails(device);
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // Costruisce la tab dei firmware disponibili
  Widget _buildFirmwareTab() {
    return ListView.builder(
      itemCount: _availableFirmwares.length,
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        final firmware = _availableFirmwares[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: const Icon(Icons.sd_card),
            title: Text(firmware['name']),
            subtitle: Text(
              'v${firmware['version']} - ${DateFormat('dd/MM/yyyy').format(firmware['releaseDate'])}',
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      firmware['description'],
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Dimensione: ${firmware['size']} MB - Per: ${(firmware['targetDevices'] as List).join(", ")}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const Divider(),
                    const Text(
                      'Novità in questa versione:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(
                      (firmware['changelog'] as List).length,
                      (i) => Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• '),
                            Expanded(
                              child: Text(firmware['changelog'][i]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Dispositivi compatibili
                    _buildCompatibleDevices(firmware),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Mostra dispositivi compatibili con un firmware
  Widget _buildCompatibleDevices(Map<String, dynamic> firmware) {
    final compatibleDevices = _devices
        .where((d) => (firmware['targetDevices'] as List).contains(d['model']))
        .toList();

    if (compatibleDevices.isEmpty) {
      return const Text('Nessun dispositivo compatibile trovato');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dispositivi compatibili:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: compatibleDevices.length,
          itemBuilder: (context, index) {
            final device = compatibleDevices[index];
            final bool needsUpdate =
                firmware['version'] != device['currentVersion'];

            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                device['icon'] as IconData,
                color: needsUpdate ? Colors.amber : Colors.green,
              ),
              title: Text(device['name']),
              subtitle: Text(
                'Versione attuale: ${device['currentVersion']}',
              ),
              trailing: needsUpdate && device['status'] == 'Online'
                  ? ElevatedButton(
                      onPressed: () => _startUpdate(device['id']),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Aggiorna'),
                    )
                  : device['status'] == 'Online'
                      ? const Text('Aggiornato',
                          style: TextStyle(color: Colors.green))
                      : const Text('Offline',
                          style: TextStyle(color: Colors.grey)),
            );
          },
        ),
      ],
    );
  }

  // Costruisce la tab della cronologia
  Widget _buildHistoryTab() {
    return ListView.builder(
      itemCount: _updateHistory.length,
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        final update = _updateHistory[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.check, color: Colors.white),
            ),
            title: Text(update['deviceName']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Da v${update['fromVersion']} a v${update['toVersion']}'),
                Text(
                  '${DateFormat('dd/MM/yyyy HH:mm').format(update['date'])} - Durata: ${update['duration']}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            trailing: Text(
              update['status'],
              style: TextStyle(
                color: update['status'] == 'Completato'
                    ? Colors.green
                    : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Mostra dettagli dell'aggiornamento
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Dettagli aggiornamento per ${update['deviceName']}'),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Mostra dialog per caricare un firmware personalizzato
  void _showUploadFirmwareDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Carica Firmware Personalizzato'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nome firmware',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Versione',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // Simulazione selezione file
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Selezione file...')),
                );
              },
              icon: const Icon(Icons.attach_file),
              label: const Text('Seleziona file .bin'),
            ),
            const SizedBox(height: 8),
            const Text(
              'Formati supportati: .bin, .hex, .uf2',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Firmware caricato con successo!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Carica'),
          ),
        ],
      ),
    );
  }

  // Mostra dettagli dell'aggiornamento per un dispositivo
  void _showDeviceUpdateDetails(Map<String, dynamic> device) {
    final bool isUpdatable = device['updateAvailable'] == true;
    final bool isOnline = device['status'] == 'Online';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: isUpdatable
                        ? Colors.amber.withOpacity(0.2)
                        : Colors.green.withOpacity(0.2),
                    child: Icon(
                      device['icon'] as IconData,
                      color: isUpdatable ? Colors.amber : Colors.green,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          device['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${device['type']} - ${device['model']}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isOnline
                          ? Colors.green.withOpacity(0.2)
                          : Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      device['status'],
                      style: TextStyle(
                        color: isOnline ? Colors.green : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Informazioni firmware attuale
              const Text(
                'Firmware Attuale',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              _buildInfoRow('Versione', 'v${device['currentVersion']}'),
              _buildInfoRow(
                'Ultimo aggiornamento',
                DateFormat('dd/MM/yyyy HH:mm').format(device['lastUpdated']),
              ),
              const Divider(),

              // Informazioni aggiornamento disponibile
              if (isUpdatable) ...[
                const Text(
                  'Aggiornamento Disponibile',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _buildInfoRow('Nuova versione', 'v${device['latestVersion']}'),

                // Trova il firmware corrispondente
                Builder(builder: (context) {
                  final firmware = _availableFirmwares.firstWhere(
                    (f) =>
                        f['version'] == device['latestVersion'] &&
                        (f['targetDevices'] as List).contains(device['model']),
                    orElse: () => {
                      'changelog': [],
                      'description': 'Informazioni non disponibili'
                    },
                  );

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (firmware['description'] != null)
                        _buildInfoRow('Descrizione', firmware['description']),
                      if (firmware['changelog'] != null &&
                          (firmware['changelog'] as List).isNotEmpty) ...[
                        const SizedBox(height: 8),
                        const Text(
                          'Novità in questa versione:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        ...List.generate(
                          (firmware['changelog'] as List).length,
                          (i) => Padding(
                            padding:
                                const EdgeInsets.only(bottom: 4.0, left: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• '),
                                Expanded(
                                  child: Text(firmware['changelog'][i]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                }),

                const SizedBox(height: 24),

                // Bottone aggiornamento
                SizedBox(
                  width: double.infinity,
                  child: isOnline
                      ? ElevatedButton.icon(
                          onPressed: device['isUpdating']
                              ? null
                              : () {
                                  Navigator.pop(context);
                                  _startUpdate(device['id']);
                                },
                          icon: device['isUpdating']
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.system_update),
                          label: Text(
                            device['isUpdating']
                                ? 'Aggiornamento in corso...'
                                : 'Aggiorna a v${device['latestVersion']}',
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: Colors.green,
                          ),
                        )
                      : ElevatedButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.offline_bolt),
                          label: const Text('Dispositivo offline'),
                        ),
                ),
              ] else ...[
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle_outline,
                            size: 48, color: Colors.green),
                        SizedBox(height: 8),
                        Text(
                          'Il dispositivo ha la versione più recente',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              // Opzioni avanzate
              const SizedBox(height: 16),
              const Divider(),
              const Text(
                'Opzioni avanzate',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.upload_file),
                title: const Text('Carica firmware personalizzato'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  Navigator.pop(context);
                  _showUploadFirmwareDialog();
                },
              ),
              ListTile(
                leading: const Icon(Icons.restore),
                title: const Text('Ripristina versione precedente'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  // Funzionalità di downgrade
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Funzionalità di downgrade non implementata in questa demo'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper per le righe di informazioni
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
