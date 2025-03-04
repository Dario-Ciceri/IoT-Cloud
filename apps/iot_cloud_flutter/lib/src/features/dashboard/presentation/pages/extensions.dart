// Questo file contiene tutte le schermate aggiuntive per la dashboard IoT

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

///////////////////////////
// MAPPA DISPOSITIVI
///////////////////////////

@RoutePage()
class DevicesMapPage extends StatefulWidget {
  const DevicesMapPage({super.key});

  @override
  State<DevicesMapPage> createState() => _DevicesMapPageState();
}

class _DevicesMapPageState extends State<DevicesMapPage> {
  bool _showAllDevices = true;
  bool _showOfflineDevices = true;
  String _selectedRoom = 'Tutti';

  // Dati fittizi dei dispositivi
  final List<Map<String, dynamic>> _devices = [
    {
      'id': 'dev1',
      'name': 'Termostato Soggiorno',
      'type': 'Temperatura',
      'status': 'Online',
      'location': LatLng(45.4642, 9.1900), // Milano
      'room': 'Soggiorno',
      'icon': Icons.thermostat,
      'color': Colors.orange,
    },
    {
      'id': 'dev2',
      'name': 'Sensore Porta Ingresso',
      'type': 'Sicurezza',
      'status': 'Online',
      'location': LatLng(45.4648, 9.1905), // Milano, leggermente spostato
      'room': 'Ingresso',
      'icon': Icons.door_front_door,
      'color': Colors.blue,
    },
    {
      'id': 'dev3',
      'name': 'Smart Light Cucina',
      'type': 'Illuminazione',
      'status': 'Offline',
      'location': LatLng(45.4645, 9.1895), // Milano, altro punto
      'room': 'Cucina',
      'icon': Icons.lightbulb,
      'color': Colors.amber,
    },
    {
      'id': 'dev4',
      'name': 'Telecamera Esterno',
      'type': 'Sicurezza',
      'status': 'Online',
      'location': LatLng(45.4650, 9.1910), // Milano, esterno
      'room': 'Esterno',
      'icon': Icons.videocam,
      'color': Colors.red,
    },
    {
      'id': 'dev5',
      'name': 'Sensore Finestra Camera',
      'type': 'Sicurezza',
      'status': 'Online',
      'location': LatLng(45.4638, 9.1898), // Milano, camera
      'room': 'Camera',
      'icon': Icons.window,
      'color': Colors.green,
    },
  ];

  List<String> get rooms =>
      ['Tutti', ..._devices.map((d) => d['room'] as String).toSet().toList()];

  List<Map<String, dynamic>> get filteredDevices {
    return _devices.where((device) {
      if (!_showAllDevices && device['status'] == 'Online') return false;
      if (!_showOfflineDevices && device['status'] == 'Offline') return false;
      if (_selectedRoom != 'Tutti' && device['room'] != _selectedRoom)
        return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mappa Dispositivi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterModal(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtri rapidi
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Filtro stanze
                  for (final room in rooms)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        selected: _selectedRoom == room,
                        label: Text(room),
                        onSelected: (selected) {
                          setState(() {
                            _selectedRoom = selected ? room : 'Tutti';
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Mappa
          Expanded(
            child: FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(45.4642, 9.1900), // Milano
                initialZoom: 16.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                // Layer per i dispositivi
                MarkerLayer(
                  markers: filteredDevices.map((device) {
                    return Marker(
                      point: device['location'] as LatLng,
                      width: 60,
                      height: 60,
                      child: GestureDetector(
                        onTap: () {
                          _showDeviceDetails(context, device);
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: device['status'] == 'Online'
                                    ? colorScheme.primaryContainer
                                    : colorScheme.errorContainer,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: colorScheme.surface,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Icon(
                                device['icon'] as IconData,
                                color: device['status'] == 'Online'
                                    ? colorScheme.primary
                                    : colorScheme.error,
                                size: 20,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Text(
                                device['name'].toString().split(' ').last,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Riepilogo dispositivi
          Container(
            color: colorScheme.surface,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusIndicator(
                    'Online',
                    _devices.where((d) => d['status'] == 'Online').length,
                    Colors.green),
                _buildStatusIndicator(
                    'Offline',
                    _devices.where((d) => d['status'] == 'Offline').length,
                    Colors.red),
                _buildStatusIndicator(
                    'Totale', _devices.length, colorScheme.primary),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Centra mappa sulla posizione dell'utente
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Centraggio su posizione attuale...'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        tooltip: 'Posizione attuale',
        child: const Icon(Icons.my_location),
      ),
    );
  }

  Widget _buildStatusIndicator(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filtri Mappa',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Mostra dispositivi online'),
                    value: _showAllDevices,
                    onChanged: (value) {
                      setState(() {
                        _showAllDevices = value;
                      });
                      this.setState(() {});
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Mostra dispositivi offline'),
                    value: _showOfflineDevices,
                    onChanged: (value) {
                      setState(() {
                        _showOfflineDevices = value;
                      });
                      this.setState(() {});
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Applica'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showDeviceDetails(BuildContext context, Map<String, dynamic> device) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: device['status'] == 'Online'
                          ? colorScheme.primaryContainer
                          : colorScheme.errorContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      device['icon'] as IconData,
                      color: device['status'] == 'Online'
                          ? colorScheme.primary
                          : colorScheme.error,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          device['name'] as String,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${device['type']} • ${device['room']}',
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: device['status'] == 'Online'
                          ? Colors.green.withOpacity(0.2)
                          : Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      device['status'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: device['status'] == 'Online'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Coordinate
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Coordinate'),
                subtitle: Text(
                  '${(device['location'] as LatLng).latitude.toStringAsFixed(4)}, '
                  '${(device['location'] as LatLng).longitude.toStringAsFixed(4)}',
                ),
              ),
              const Divider(),
              // Azioni
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.directions,
                    label: 'Direzioni',
                    onTap: () {
                      Navigator.pop(context);
                      // Qui si potrebbero aprire le direzioni su Google Maps
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.refresh,
                    label: 'Aggiorna',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.settings,
                    label: 'Impostazioni',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////
// PAGINA NOTIFICHE
///////////////////////////

@RoutePage()
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Dati fittizi delle notifiche
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': 'not1',
      'title': 'Consumo Energetico',
      'message': 'Riduzione del 15% rispetto alla settimana scorsa',
      'icon': Icons.trending_down,
      'color': Colors.green,
      'time': DateTime.now().subtract(const Duration(minutes: 25)),
      'isRead': false,
      'type': 'info',
    },
    {
      'id': 'not2',
      'title': 'Allarme Fumo',
      'message': 'Allarme fumo attivato in Cucina',
      'icon': Icons.sensors,
      'color': Colors.red,
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': true,
      'type': 'alert',
    },
    {
      'id': 'not3',
      'title': 'Porta Garage',
      'message': 'Porta garage aperta da 30 minuti',
      'icon': Icons.garage,
      'color': Colors.orange,
      'time': DateTime.now().subtract(const Duration(hours: 5)),
      'isRead': false,
      'type': 'alert',
    },
    {
      'id': 'not4',
      'title': 'Aggiornamento Software',
      'message': 'Gli aggiornamenti per 3 dispositivi sono pronti',
      'icon': Icons.system_update,
      'color': Colors.blue,
      'time': DateTime.now().subtract(const Duration(days: 1)),
      'isRead': true,
      'type': 'info',
    },
    {
      'id': 'not5',
      'title': 'Risparmio Energetico',
      'message':
          'Suggerimento: imposta termostato a 20°C di notte per risparmiare energia',
      'icon': Icons.eco,
      'color': Colors.green,
      'time': DateTime.now().subtract(const Duration(days: 2)),
      'isRead': true,
      'type': 'tip',
    },
    {
      'id': 'not6',
      'title': 'Connessione Wi-Fi',
      'message': 'Il dispositivo "Sensore Finestra" si è disconnesso',
      'icon': Icons.wifi_off,
      'color': Colors.red,
      'time': DateTime.now().subtract(const Duration(days: 3)),
      'isRead': true,
      'type': 'alert',
    },
    {
      'id': 'not7',
      'title': 'Promemoria',
      'message': 'Ricordati di cambiare i filtri del sistema di ventilazione',
      'icon': Icons.calendar_today,
      'color': Colors.purple,
      'time': DateTime.now().subtract(const Duration(days: 4)),
      'isRead': true,
      'type': 'tip',
    },
  ];

  List<Map<String, dynamic>> get allNotifications => _notifications;
  List<Map<String, dynamic>> get unreadNotifications =>
      _notifications.where((n) => !n['isRead']).toList();
  List<Map<String, dynamic>> get alertNotifications =>
      _notifications.where((n) => n['type'] == 'alert').toList();
  List<Map<String, dynamic>> get infoNotifications =>
      _notifications.where((n) => n['type'] == 'info').toList();
  List<Map<String, dynamic>> get tipNotifications =>
      _notifications.where((n) => n['type'] == 'tip').toList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifiche'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: 'Segna tutte come lette',
            onPressed: () {
              setState(() {
                for (var notification in _notifications) {
                  notification['isRead'] = true;
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tutte le notifiche segnate come lette'),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'clear_all') {
                setState(() {
                  _notifications.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tutte le notifiche cancellate'),
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear_all',
                child: Text('Cancella tutte'),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Text('Impostazioni notifiche'),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Tutte',
              icon: Badge(
                isLabelVisible: allNotifications.isNotEmpty,
                label: Text(allNotifications.length.toString()),
                child: const Icon(Icons.notifications),
              ),
            ),
            Tab(
              text: 'Non lette',
              icon: Badge(
                isLabelVisible: unreadNotifications.isNotEmpty,
                label: Text(unreadNotifications.length.toString()),
                child: const Icon(Icons.mark_email_unread),
              ),
            ),
            Tab(
              text: 'Avvisi',
              icon: Badge(
                isLabelVisible: alertNotifications.isNotEmpty,
                label: Text(alertNotifications.length.toString()),
                child: const Icon(Icons.warning),
              ),
            ),
            Tab(
              text: 'Info',
              icon: const Icon(Icons.info),
            ),
            Tab(
              text: 'Suggerimenti',
              icon: const Icon(Icons.lightbulb),
            ),
          ],
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationsList(allNotifications),
          _buildNotificationsList(unreadNotifications),
          _buildNotificationsList(alertNotifications),
          _buildNotificationsList(infoNotifications),
          _buildNotificationsList(tipNotifications),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(List<Map<String, dynamic>> notifications) {
    if (notifications.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Nessuna notifica'),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];

        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  setState(() {
                    notifications.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notifica eliminata'),
                    ),
                  );
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Elimina',
              ),
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  (notification['color'] as Color).withOpacity(0.2),
              child: Icon(
                notification['icon'] as IconData,
                color: notification['color'] as Color,
                size: 20,
              ),
            ),
            title: Text(
              notification['title'] as String,
              style: TextStyle(
                fontWeight: notification['isRead']
                    ? FontWeight.normal
                    : FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification['message'] as String),
                const SizedBox(height: 4),
                Text(
                  _formatNotificationTime(notification['time'] as DateTime),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            trailing: notification['isRead']
                ? null
                : Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
            onTap: () {
              setState(() {
                notification['isRead'] = true;
              });

              // Mostra dettagli notifica
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(notification['title'] as String),
                  content: Text(notification['message'] as String),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Chiudi'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Qui gestiresti un'azione basata sul tipo di notifica
                      },
                      child: const Text('Azione'),
                    ),
                  ],
                ),
              );
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        );
      },
    );
  }

  String _formatNotificationTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m fa';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h fa';
    } else {
      return DateFormat('dd/MM, HH:mm').format(time);
    }
  }
}

///////////////////////////
// PAGINA ACCOUNT
///////////////////////////

@RoutePage()
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // Dati fittizi dell'account
  final Map<String, dynamic> _userData = {
    'name': 'Marco Rossi',
    'email': 'marco.rossi@esempio.it',
    'phone': '+39 123 456 7890',
    'address': 'Via Roma 123, Milano',
    'plan': 'Premium',
    'planExpiry': DateTime.now().add(const Duration(days: 365)),
    'joined': DateTime(2022, 5, 15),
    'avatar': 'https://picsum.photos/150',
    'devices': 7,
    'homes': 1,
    'preferences': {
      'notifications': true,
      'emailUpdates': false,
      'darkMode': true,
      'analytics': true,
    },
  };

  bool _isEditing = false;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _userData['name']);
    _emailController = TextEditingController(text: _userData['email']);
    _phoneController = TextEditingController(text: _userData['phone']);
    _addressController = TextEditingController(text: _userData['address']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                if (_isEditing) {
                  // Salva i dati
                  _userData['name'] = _nameController.text;
                  _userData['email'] = _emailController.text;
                  _userData['phone'] = _phoneController.text;
                  _userData['address'] = _addressController.text;

                  // Mostra conferma
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profilo aggiornato'),
                    ),
                  );
                }

                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profilo utente
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(_userData['avatar']),
                      ),
                      if (_isEditing)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: colorScheme.onPrimary,
                              size: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_isEditing)
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(),
                      ),
                    )
                  else
                    Text(
                      _userData['name'],
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    'Account ${_userData['plan']}',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Iscritto dal ${DateFormat('d MMMM yyyy').format(_userData['joined'])}',
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Statistiche account
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatColumn(
                        'Dispositivi', _userData['devices'].toString()),
                    _buildStatColumn('Case', _userData['homes'].toString()),
                    _buildStatColumn('Scadenza',
                        DateFormat('MM/yyyy').format(_userData['planExpiry'])),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Informazioni personali
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informazioni Personali',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_isEditing) ...[
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Telefono',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'Indirizzo',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ] else ...[
                      _buildInfoRow('Email', _userData['email']),
                      _buildInfoRow('Telefono', _userData['phone']),
                      _buildInfoRow('Indirizzo', _userData['address']),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Preferenze account
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Preferenze',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Notifiche push'),
                      value: _userData['preferences']['notifications'],
                      onChanged: (value) {
                        setState(() {
                          _userData['preferences']['notifications'] = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Aggiornamenti email'),
                      value: _userData['preferences']['emailUpdates'],
                      onChanged: (value) {
                        setState(() {
                          _userData['preferences']['emailUpdates'] = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Modalità scura'),
                      value: _userData['preferences']['darkMode'],
                      onChanged: (value) {
                        setState(() {
                          _userData['preferences']['darkMode'] = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Condividi analytics'),
                      subtitle: const Text('Aiutaci a migliorare il servizio'),
                      value: _userData['preferences']['analytics'],
                      onChanged: (value) {
                        setState(() {
                          _userData['preferences']['analytics'] = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Opzioni sicurezza e privacy
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sicurezza e Privacy',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.password),
                      title: const Text('Cambia password'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Implementazione cambio password
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.security),
                      title: const Text('Autenticazione a due fattori'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Implementazione 2FA
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.delete_outline),
                      title: const Text('Elimina account'),
                      subtitle: const Text('Azione irreversibile'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Implementazione eliminazione account
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Elimina account'),
                            content: const Text(
                                'Sei sicuro di voler eliminare il tuo account? Questa azione è irreversibile.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Annulla'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Funzionalità non implementata in questa demo'),
                                    ),
                                  );
                                },
                                child: const Text('Elimina'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Pulsante logout
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Implementazione logout
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text(
                          'Sei sicuro di voler effettuare il logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Annulla'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // In un'app reale, chiameresti la funzione di logout
                            Navigator.of(context)
                                .pop(); // Torna alla schermata precedente
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          value,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

///////////////////////////
// PAGINA IMPOSTAZIONI
///////////////////////////

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Impostazioni dell'app
  final Map<String, dynamic> _settings = {
    'appearance': {
      'theme': 'system',
      'compactMode': false,
      'showWeather': true,
      'showSavings': true,
    },
    'notifications': {
      'pushEnabled': true,
      'emailEnabled': false,
      'alertsEnabled': true,
      'tipsEnabled': true,
      'devicesEnabled': true,
      'energyEnabled': true,
    },
    'privacy': {
      'locationEnabled': true,
      'analyticsEnabled': true,
      'crashReportsEnabled': true,
    },
    'devices': {
      'autoDetect': true,
      'checkUpdates': true,
      'autoUpdate': false,
    },
    'network': {
      'wifiOnly': false,
      'backgroundSync': true,
      'syncInterval': 15, // minuti
    },
    'advanced': {
      'debugMode': false,
      'apiEndpoint': 'https://api.example.com/v1',
      'cacheSize': 100, // MB
    },
  };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Impostazioni'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Ripristina predefinite',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Ripristina impostazioni'),
                  content: const Text(
                      'Vuoi ripristinare tutte le impostazioni ai valori predefiniti?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Annulla'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // In un'app reale, ripristineresti le impostazioni predefinite
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Impostazioni ripristinate'),
                          ),
                        );
                      },
                      child: const Text('Ripristina'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Aspetto'),
          _buildThemeSelector(),
          SwitchListTile(
            title: const Text('Modalità compatta'),
            subtitle: const Text('Visualizza più informazioni in meno spazio'),
            value: _settings['appearance']['compactMode'],
            onChanged: (value) {
              setState(() {
                _settings['appearance']['compactMode'] = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Mostra meteo'),
            subtitle: const Text('Visualizza previsioni meteo nella dashboard'),
            value: _settings['appearance']['showWeather'],
            onChanged: (value) {
              setState(() {
                _settings['appearance']['showWeather'] = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Mostra consigli risparmio'),
            subtitle:
                const Text('Visualizza widget consigli risparmio energia'),
            value: _settings['appearance']['showSavings'],
            onChanged: (value) {
              setState(() {
                _settings['appearance']['showSavings'] = value;
              });
            },
          ),
          _buildSectionHeader('Notifiche'),
          SwitchListTile(
            title: const Text('Notifiche push'),
            subtitle: const Text('Ricevi notifiche sul dispositivo'),
            value: _settings['notifications']['pushEnabled'],
            onChanged: (value) {
              setState(() {
                _settings['notifications']['pushEnabled'] = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Notifiche email'),
            subtitle: const Text('Ricevi notifiche via email'),
            value: _settings['notifications']['emailEnabled'],
            onChanged: (value) {
              setState(() {
                _settings['notifications']['emailEnabled'] = value;
              });
            },
          ),
          _buildSettingsSection('Tipo notifiche', [
            SwitchListTile(
              title: const Text('Avvisi'),
              dense: true,
              value: _settings['notifications']['alertsEnabled'],
              onChanged: (value) {
                setState(() {
                  _settings['notifications']['alertsEnabled'] = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Suggerimenti'),
              dense: true,
              value: _settings['notifications']['tipsEnabled'],
              onChanged: (value) {
                setState(() {
                  _settings['notifications']['tipsEnabled'] = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Dispositivi'),
              dense: true,
              value: _settings['notifications']['devicesEnabled'],
              onChanged: (value) {
                setState(() {
                  _settings['notifications']['devicesEnabled'] = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Energia'),
              dense: true,
              value: _settings['notifications']['energyEnabled'],
              onChanged: (value) {
                setState(() {
                  _settings['notifications']['energyEnabled'] = value;
                });
              },
            ),
          ]),
          _buildSectionHeader('Privacy e Dati'),
          SwitchListTile(
            title: const Text('Condividi posizione'),
            subtitle:
                const Text('Usa la posizione per funzionalità di geofencing'),
            value: _settings['privacy']['locationEnabled'],
            onChanged: (value) {
              setState(() {
                _settings['privacy']['locationEnabled'] = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Condividi analytics'),
            subtitle: const Text('Aiutaci a migliorare l\'app'),
            value: _settings['privacy']['analyticsEnabled'],
            onChanged: (value) {
              setState(() {
                _settings['privacy']['analyticsEnabled'] = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Invia rapporti di errore'),
            subtitle: const Text('Automaticamente in caso di problemi'),
            value: _settings['privacy']['crashReportsEnabled'],
            onChanged: (value) {
              setState(() {
                _settings['privacy']['crashReportsEnabled'] = value;
              });
            },
          ),
          _buildSectionHeader('Dispositivi'),
          SwitchListTile(
            title: const Text('Rilevamento automatico'),
            subtitle: const Text('Rileva nuovi dispositivi sulla rete'),
            value: _settings['devices']['autoDetect'],
            onChanged: (value) {
              setState(() {
                _settings['devices']['autoDetect'] = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Verifica aggiornamenti'),
            subtitle: const Text(
                'Controlla regolarmente gli aggiornamenti dispositivi'),
            value: _settings['devices']['checkUpdates'],
            onChanged: (value) {
              setState(() {
                _settings['devices']['checkUpdates'] = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Aggiornamento automatico'),
            subtitle: const Text('Aggiorna automaticamente i dispositivi'),
            value: _settings['devices']['autoUpdate'],
            onChanged: (value) {
              setState(() {
                _settings['devices']['autoUpdate'] = value;
              });
            },
          ),
          _buildSectionHeader('Rete e Sincronizzazione'),
          SwitchListTile(
            title: const Text('Solo Wi-Fi'),
            subtitle: const Text('Sincronizza solo su Wi-Fi'),
            value: _settings['network']['wifiOnly'],
            onChanged: (value) {
              setState(() {
                _settings['network']['wifiOnly'] = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Sincronizzazione in background'),
            subtitle: const Text('Aggiorna dati anche con app in background'),
            value: _settings['network']['backgroundSync'],
            onChanged: (value) {
              setState(() {
                _settings['network']['backgroundSync'] = value;
              });
            },
          ),
          ListTile(
            title: const Text('Intervallo sincronizzazione'),
            subtitle: Text('${_settings['network']['syncInterval']} minuti'),
            trailing: SizedBox(
              width: 120,
              child: Slider(
                value: _settings['network']['syncInterval'].toDouble(),
                min: 5,
                max: 60,
                divisions: 11,
                label: '${_settings['network']['syncInterval']} min',
                onChanged: (value) {
                  setState(() {
                    _settings['network']['syncInterval'] = value.toInt();
                  });
                },
              ),
            ),
          ),
          _buildSectionHeader('Avanzate'),
          SwitchListTile(
            title: const Text('Modalità debug'),
            subtitle: const Text('Abilita logging avanzato'),
            value: _settings['advanced']['debugMode'],
            onChanged: (value) {
              setState(() {
                _settings['advanced']['debugMode'] = value;
              });
            },
          ),
          ListTile(
            title: const Text('Endpoint API'),
            subtitle: Text(_settings['advanced']['apiEndpoint']),
            trailing: const Icon(Icons.edit),
            onTap: () {
              _showEndpointDialog();
            },
          ),
          ListTile(
            title: const Text('Dimensione cache'),
            subtitle: Text('${_settings['advanced']['cacheSize']} MB'),
            trailing: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cache svuotata'),
                  ),
                );
              },
              child: const Text('Svuota'),
            ),
          ),
          _buildSectionHeader('Info App'),
          ListTile(
            title: const Text('Versione'),
            subtitle: const Text('1.2.5 (Build 234)'),
          ),
          ListTile(
            title: const Text('Licenze open source'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // In un'app reale, mostreresti le licenze
            },
          ),
          ListTile(
            title: const Text('Termini di servizio'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // In un'app reale, mostreresti i termini
            },
          ),
          ListTile(
            title: const Text('Privacy policy'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // In un'app reale, mostreresti la privacy policy
            },
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildThemeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Text('Tema'),
        ),
        RadioListTile<String>(
          title: const Text('Chiaro'),
          value: 'light',
          groupValue: _settings['appearance']['theme'],
          onChanged: (value) {
            setState(() {
              _settings['appearance']['theme'] = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Scuro'),
          value: 'dark',
          groupValue: _settings['appearance']['theme'],
          onChanged: (value) {
            setState(() {
              _settings['appearance']['theme'] = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Sistema'),
          value: 'system',
          groupValue: _settings['appearance']['theme'],
          onChanged: (value) {
            setState(() {
              _settings['appearance']['theme'] = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  void _showEndpointDialog() {
    final controller =
        TextEditingController(text: _settings['advanced']['apiEndpoint']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Endpoint API'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'URL',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _settings['advanced']['apiEndpoint'] = controller.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Endpoint API aggiornato'),
                ),
              );
            },
            child: const Text('Salva'),
          ),
        ],
      ),
    );
  }
}

///////////////////////////
// PAGINA AIUTO
///////////////////////////

@RoutePage()
class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  // Dati FAQ
  final List<Map<String, dynamic>> _faqItems = [
    {
      'question': 'Come aggiungere un nuovo dispositivo?',
      'answer':
          'Per aggiungere un nuovo dispositivo, vai alla pagina Dispositivi e premi il pulsante "+" in basso a destra. Segui la procedura guidata per connettere il tuo dispositivo alla rete.',
      'isExpanded': false,
    },
    {
      'question': 'Come creare un\'automazione?',
      'answer':
          'Per creare un\'automazione, vai alla pagina Automazioni e premi "Crea Nuova Automazione". Quindi seleziona il trigger (quando) e l\'azione (cosa) desiderati. Ad esempio, puoi impostare luci che si accendono automaticamente al tramonto.',
      'isExpanded': false,
    },
    {
      'question': 'Come risolvere problemi di connessione?',
      'answer':
          'Se riscontri problemi di connessione con i tuoi dispositivi, prova questi passaggi:\n\n1. Verifica che il dispositivo sia alimentato\n2. Assicurati che il tuo smartphone sia connesso alla stessa rete Wi-Fi\n3. Riavvia il router\n4. Riavvia il dispositivo problematico\n5. Prova a rimuovere e aggiungere nuovamente il dispositivo',
      'isExpanded': false,
    },
    {
      'question': 'Come funziona la modalità vacanza?',
      'answer':
          'La modalità vacanza simula la presenza in casa accendendo e spegnendo luci e altri dispositivi in orari casuali. Inoltre, ottimizza i consumi energetici spegnendo i dispositivi non necessari e impostando il termostato a una temperatura di risparmio.',
      'isExpanded': false,
    },
    {
      'question': 'Come condividere l\'accesso con altri utenti?',
      'answer':
          'Puoi condividere l\'accesso alla tua casa intelligente con familiari o coinquilini. Vai su Impostazioni > Gestione Casa > Membri e seleziona "Invita nuovo membro". Puoi assegnare diverse autorizzazioni a ciascun utente.',
      'isExpanded': false,
    },
    {
      'question': 'Come esportare i dati di consumo energetico?',
      'answer':
          'Per esportare i dati di consumo energetico, vai alla pagina Analisi, seleziona il periodo desiderato e tocca il pulsante "Esporta" nell\'angolo in alto a destra. Puoi esportare i dati in formato CSV o PDF.',
      'isExpanded': false,
    },
    {
      'question': 'L\'app è compatibile con assistenti vocali?',
      'answer':
          'Sì, l\'app è compatibile con Google Assistant, Amazon Alexa e Apple HomeKit. Per configurare l\'integrazione, vai su Impostazioni > Integrazioni e seleziona l\'assistente vocale che desideri utilizzare.',
      'isExpanded': false,
    },
    {
      'question':
          'Come ripristinare un dispositivo alle impostazioni di fabbrica?',
      'answer':
          'Per ripristinare un dispositivo alle impostazioni di fabbrica, vai alla pagina del dispositivo specifico, tocca l\'icona delle impostazioni (⚙️) e seleziona "Ripristina dispositivo". Tieni presente che dovrai riconfigurare il dispositivo dopo il ripristino.',
      'isExpanded': false,
    },
  ];

  // Ricerca
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredFaqs {
    if (_searchQuery.isEmpty) return _faqItems;

    return _faqItems.where((faq) {
      return faq['question']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          faq['answer']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aiuto e Supporto'),
      ),
      body: Column(
        children: [
          // Ricerca
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cerca aiuto...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Opzioni di supporto rapide
          if (_searchQuery.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Supporto rapido',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildSupportOption(
                            icon: Icons.chat,
                            label: 'Live chat',
                            onTap: () {
                              _showChatNotAvailableDialog();
                            },
                          ),
                          _buildSupportOption(
                            icon: Icons.email,
                            label: 'Email',
                            onTap: () {
                              _launchEmail();
                            },
                          ),
                          _buildSupportOption(
                            icon: Icons.phone,
                            label: 'Telefono',
                            onTap: () {
                              _launchPhone();
                            },
                          ),
                          _buildSupportOption(
                            icon: Icons.help_center,
                            label: 'Guide',
                            onTap: () {
                              _launchHelpCenter();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // FAQ
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Domande frequenti',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (_searchQuery.isNotEmpty)
                  Text('${filteredFaqs.length} risultati'),
              ],
            ),
          ),

          // Lista FAQ
          Expanded(
            child: filteredFaqs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off,
                            size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text('Nessun risultato trovato'),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            _showContactSupportDialog();
                          },
                          child: const Text('Contatta il supporto'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredFaqs.length,
                    itemBuilder: (context, index) {
                      final faq = filteredFaqs[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ExpansionTile(
                          title: Text(
                            faq['question'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          initiallyExpanded: faq['isExpanded'],
                          onExpansionChanged: (expanded) {
                            setState(() {
                              faq['isExpanded'] = expanded;
                            });
                          },
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(faq['answer']),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () {
                                          // In una vera app, questa funzionalità copierebbe il testo negli appunti
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Testo copiato negli appunti'),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.copy, size: 16),
                                        label: const Text('Copia'),
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            faq['isExpanded'] = false;
                                          });

                                          // In una vera app, questa funzionalità aprirebbe un articolo completo o una guida
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Funzionalità non implementata in questa demo'),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.open_in_new,
                                            size: 16),
                                        label: const Text('Approfondisci'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _searchQuery.isEmpty
          ? BottomAppBar(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hai ancora domande?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showContactSupportDialog();
                    },
                    child: const Text('Contatta il supporto'),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget _buildSupportOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChatNotAvailableDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Live Chat'),
        content: const Text(
            'La Live Chat è disponibile dal lunedì al venerdì dalle 9:00 alle 18:00. Vuoi inviare un\'email al nostro team di supporto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _launchEmail();
            },
            child: const Text('Invia email'),
          ),
        ],
      ),
    );
  }

  void _showContactSupportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contatta il supporto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('support@example.com'),
              onTap: () {
                Navigator.pop(context);
                _launchEmail();
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Telefono'),
              subtitle: const Text('+39 02 1234567'),
              onTap: () {
                Navigator.pop(context);
                _launchPhone();
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Live Chat'),
              subtitle: const Text('Disponibile 9:00-18:00, Lun-Ven'),
              onTap: () {
                Navigator.pop(context);
                _showChatNotAvailableDialog();
              },
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
  }

  void _launchEmail() {
    // In un'app reale, utilizzeresti url_launcher per avviare l'app email
    final Uri emailLaunchUri =
        Uri(scheme: 'mailto', path: 'support@example.com', queryParameters: {
      'subject': 'Richiesta di supporto IoT Cloud',
    });

    launchUrl(emailLaunchUri);
  }

  void _launchPhone() {
    // In un'app reale, utilizzeresti url_launcher per avviare l'app telefono
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: '+390212345678',
    );

    launchUrl(phoneLaunchUri);
  }

  void _launchHelpCenter() {
    // In un'app reale, utilizzeresti url_launcher per aprire il centro di supporto nel browser
    final Uri helpCenterUri = Uri.parse('https://example.com/help');

    launchUrl(helpCenterUri);
  }
}
