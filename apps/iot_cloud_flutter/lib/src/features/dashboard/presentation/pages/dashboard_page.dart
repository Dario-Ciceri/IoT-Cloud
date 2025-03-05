import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:iot_cloud_flutter/src/core/routes/router.gr.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'dart:async';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:confetti/confetti.dart';

// Classe interna di MockData che definisce tutti i dati di esempio
class _MockData {
  static final List<Map<String, dynamic>> devices = [
    {
      'id': 'dev_001',
      'name': 'Termostato Soggiorno',
      'type': 'Temperatura',
      'status': 'Online',
      'value': '22.5°C',
      'battery': 87,
      'lastUpdate': DateTime.now().subtract(const Duration(minutes: 5)),
      'icon': Icons.thermostat,
      'color': Colors.orange,
      'history': _generateTemperatureData(22, 24, 30),
    },
    {
      'id': 'dev_002',
      'name': 'Sensore Porta Ingresso',
      'type': 'Sicurezza',
      'status': 'Online',
      'value': 'Chiuso',
      'battery': 93,
      'lastUpdate': DateTime.now().subtract(const Duration(minutes: 12)),
      'icon': Icons.door_front_door,
      'color': Colors.blue,
      'history': _generateBinaryData(30),
    },
    {
      'id': 'dev_003',
      'name': 'Smart Light Cucina',
      'type': 'Illuminazione',
      'status': 'Online',
      'value': 'Acceso',
      'battery': 72,
      'lastUpdate': DateTime.now().subtract(const Duration(minutes: 8)),
      'icon': Icons.lightbulb,
      'color': Colors.amber,
      'history': _generateBinaryData(30),
    },
    {
      'id': 'dev_004',
      'name': 'Sensore Umidità Serra',
      'type': 'Umidità',
      'status': 'Online',
      'value': '68%',
      'battery': 45,
      'lastUpdate': DateTime.now().subtract(const Duration(minutes: 2)),
      'icon': Icons.water_drop,
      'color': Colors.lightBlue,
      'history': _generateHumidityData(60, 70, 30),
    },
    {
      'id': 'dev_005',
      'name': 'Telecamera Esterna',
      'type': 'Sicurezza',
      'status': 'Offline',
      'value': 'Spento',
      'battery': 0,
      'lastUpdate': DateTime.now().subtract(const Duration(hours: 5)),
      'icon': Icons.videocam,
      'color': Colors.red,
      'history': [],
    },
    {
      'id': 'dev_006',
      'name': 'Sensore Qualità Aria',
      'type': 'Ambiente',
      'status': 'Online',
      'value': 'Ottimo',
      'battery': 95,
      'lastUpdate': DateTime.now().subtract(const Duration(minutes: 15)),
      'icon': Icons.air,
      'color': Colors.green,
      'history': _generateAirQualityData(30),
    },
    {
      'id': 'dev_007',
      'name': 'Smart TV Soggiorno',
      'type': 'Intrattenimento',
      'status': 'Standby',
      'value': 'Inattivo',
      'battery': 100,
      'lastUpdate': DateTime.now().subtract(const Duration(hours: 1)),
      'icon': Icons.tv,
      'color': Colors.purple,
      'history': _generateBinaryData(30),
    },
  ];

  static List<Map<String, dynamic>> get onlineDevices =>
      devices.where((d) => d['status'] == 'Online').toList();
  static List<Map<String, dynamic>> get offlineDevices =>
      devices.where((d) => d['status'] == 'Offline').toList();
  static List<Map<String, dynamic>> get standbyDevices =>
      devices.where((d) => d['status'] == 'Standby').toList();

  static int get totalDevices => devices.length;
  static int get onlineCount => onlineDevices.length;
  static int get offlineCount => offlineDevices.length;
  static int get standbyCount => standbyDevices.length;
  static int get alertsCount => devices
      .where((d) => (int.tryParse(d['battery'].toString()) ?? 100) < 20)
      .length;

  static final List<Map<String, dynamic>> rooms = [
    {
      'name': 'Soggiorno',
      'devices': devices
          .where((d) => d['name'].toString().contains('Soggiorno'))
          .length,
      'icon': Icons.weekend,
    },
    {
      'name': 'Cucina',
      'devices':
          devices.where((d) => d['name'].toString().contains('Cucina')).length,
      'icon': Icons.kitchen,
    },
    {
      'name': 'Esterno',
      'devices':
          devices.where((d) => d['name'].toString().contains('Estern')).length,
      'icon': Icons.home,
    },
    {
      'name': 'Serra',
      'devices':
          devices.where((d) => d['name'].toString().contains('Serra')).length,
      'icon': Icons.grass,
    },
  ];

  static final Map<String, dynamic> energyData = {
    'currentUsage': '3.8 kW',
    'dailyUsage': '18.5 kWh',
    'monthlyUsage': '412 kWh',
    'historicalData': _generateEnergyData(30),
  };

  static List<double> _generateTemperatureData(
      double min, double max, int count) {
    final random = math.Random();
    return List.generate(
        count,
        (index) => double.parse(
            (min + random.nextDouble() * (max - min)).toStringAsFixed(1)));
  }

  static List<double> _generateHumidityData(double min, double max, int count) {
    final random = math.Random();
    return List.generate(
        count,
        (index) => double.parse(
            (min + random.nextDouble() * (max - min)).toStringAsFixed(1)));
  }

  static List<int> _generateBinaryData(int count) {
    final random = math.Random();
    return List.generate(count, (index) => random.nextBool() ? 1 : 0);
  }

  static List<Map<String, dynamic>> _generateEnergyData(int days) {
    final random = math.Random();
    return List.generate(days, (index) {
      final date = DateTime.now().subtract(Duration(days: days - index - 1));
      return {
        'date': date,
        'usage': 10 + random.nextDouble() * 15,
      };
    });
  }

  static List<String> _generateAirQualityData(int count) {
    final random = math.Random();
    final qualities = ['Scarso', 'Moderato', 'Buono', 'Ottimo'];
    return List.generate(
        count, (index) => qualities[random.nextInt(qualities.length)]);
  }

  // Automation rules
  static final List<Map<String, dynamic>> automations = [
    {
      'name': 'Luci automatiche sera',
      'description': 'Accendi le luci al tramonto',
      'active': true,
      'icon': Icons.wb_twilight,
    },
    {
      'name': 'Temperatura notte',
      'description': 'Abbassa termostato alle 23:00',
      'active': true,
      'icon': Icons.nightlight,
    },
    {
      'name': 'Allarme mattina',
      'description': 'Attiva allarme quando tutti escono',
      'active': false,
      'icon': Icons.security,
    },
  ];
}

// Classe per la gestione del tema
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

// Dashboard Page
@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;
  late PageController _pageController;
  bool _showVacationMode = false;
  bool _showSavingsCard = true;
  bool _showWeatherCard = true;
  bool _isEditMode = false;
  bool _useCompactMode = false;
  bool _showConfetti = false;

  // Controller per animazioni
  late AnimationController _pulseController;
  late AnimationController _weatherController;
  late ConfettiController _confettiController;

  // Controller per lo slider di temperature
  double _targetTemperature = 22.5;

  // Mock valori animati
  double _temperature = 22.5;
  double _humidity = 68;
  double _energySavings = 12.7;
  String _weatherCondition = 'Soleggiato';
  int _notificationCount = 3;

  // Metriche per il dashboard
  Map<String, double> _weeklyEnergySavings = {
    'Lunedì': 5.2,
    'Martedì': 4.8,
    'Mercoledì': 6.7,
    'Giovedì': 7.3,
    'Venerdì': 5.9,
    'Sabato': 8.4,
    'Domenica': 9.2,
  };

  // Stato per widget riordinabili
  List<String> _dashboardWidgets = [
    'stats',
    'environment',
    'energy',
    'devices',
    'automation',
    'savings',
    'weather',
  ];

  // Ultime localizzazioni (per geofencing)
  List<Map<String, dynamic>> _locationHistory = [
    {
      'location': 'Casa',
      'time': DateTime.now().subtract(const Duration(minutes: 32)),
      'isHome': true
    },
    {
      'location': 'Ufficio',
      'time': DateTime.now().subtract(const Duration(hours: 8)),
      'isHome': false
    },
    {
      'location': 'Supermercato',
      'time': DateTime.now().subtract(const Duration(hours: 10)),
      'isHome': false
    },
    {
      'location': 'Palestra',
      'time': DateTime.now().subtract(const Duration(days: 1, hours: 18)),
      'isHome': false
    },
  ];

  // Mock modelli di utilizzo
  List<Map<String, dynamic>> _usagePatterns = [
    {'day': 'Lunedì', 'pattern': 'Utilizzo elevato di mattina'},
    {'day': 'Martedì', 'pattern': 'Utilizzo costante'},
    {'day': 'Mercoledì', 'pattern': 'Picco serale'},
    {'day': 'Giovedì', 'pattern': 'Utilizzo elevato di mattina'},
    {'day': 'Venerdì', 'pattern': 'Utilizzo ridotto'},
    {'day': 'Sabato', 'pattern': 'Utilizzo intermittente'},
    {'day': 'Domenica', 'pattern': 'Utilizzo elevato tutto il giorno'},
  ];

  // Previsioni meteo mock per la settimana
  List<Map<String, dynamic>> _weatherForecast = [
    {
      'day': 'Oggi',
      'temp': 24,
      'condition': 'Soleggiato',
      'icon': Icons.wb_sunny
    },
    {'day': 'Domani', 'temp': 22, 'condition': 'Nuvoloso', 'icon': Icons.cloud},
    {
      'day': 'Mercoledì',
      'temp': 20,
      'condition': 'Pioggia',
      'icon': Icons.water_drop
    },
    {
      'day': 'Giovedì',
      'temp': 21,
      'condition': 'Variabile',
      'icon': Icons.cloud_queue
    },
    {
      'day': 'Venerdì',
      'temp': 23,
      'condition': 'Soleggiato',
      'icon': Icons.wb_sunny
    },
  ];

  // Notifiche recenti
  List<Map<String, dynamic>> _recentNotifications = [
    {
      'title': 'Consumo Energetico',
      'message': 'Riduzione del 15% rispetto alla settimana scorsa',
      'icon': Icons.trending_down,
      'color': Colors.green,
      'time': DateTime.now().subtract(const Duration(minutes: 25)),
      'isRead': false,
    },
    {
      'title': 'Allarme Fumo',
      'message': 'Allarme fumo attivato in Cucina',
      'icon': Icons.sensors, // Cambiato da smoke_detector a sensors
      'color': Colors.red,
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': true,
    },
    {
      'title': 'Porta Garage',
      'message': 'Porta garage aperta da 30 minuti',
      'icon': Icons.garage,
      'color': Colors.orange,
      'time': DateTime.now().subtract(const Duration(hours: 5)),
      'isRead': false,
    },
    {
      'title': 'Aggiornamento Software',
      'message': 'Gli aggiornamenti per 3 dispositivi sono pronti',
      'icon': Icons.system_update,
      'color': Colors.blue,
      'time': DateTime.now().subtract(const Duration(days: 1)),
      'isRead': true,
    },
  ];

  // Suggerimenti di risparmio energetico
  List<Map<String, dynamic>> _energySavingTips = [
    {
      'title': 'Ottimizza la temperatura',
      'description':
          'Abbassa il termostato di 1° per risparmiare il 5-8% sui costi di riscaldamento.',
      'icon': Icons.thermostat,
      'savings': '5-8%',
    },
    {
      'title': 'Programma l\'illuminazione',
      'description':
          'Imposta le luci per spegnersi automaticamente quando non sei in casa.',
      'icon': Icons.lightbulb_outline,
      'savings': '€10-15/mese',
    },
    {
      'title': 'Smart plugs notturni',
      'description':
          'Spegni automaticamente gli elettrodomestici in standby durante la notte.',
      'icon': Icons.outlet,
      'savings': '€5-8/mese',
    },
  ];

  Timer? _updateTimer;
  Timer? _notificationTimer;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('it_IT', null);
    _tabController = TabController(length: 4, vsync: this);
    _pageController = PageController();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _weatherController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );

    // Aggiorna dati periodicamente
    _updateTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {
          final random = math.Random();
          _temperature = 21.5 + random.nextDouble() * 2;
          _humidity = 65 + random.nextDouble() * 10;
          _energySavings = 12.0 + random.nextDouble() * 3;

          // Periodicamente cambia la condizione meteo
          if (random.nextInt(4) == 0) {
            final conditions = [
              'Soleggiato',
              'Nuvoloso',
              'Pioggia leggera',
              'Variabile'
            ];
            _weatherCondition = conditions[random.nextInt(conditions.length)];
          }
        });
      }
    });

    // Simula arrivi di notifiche ogni 40-60 secondi
    _notificationTimer = Timer.periodic(const Duration(seconds: 45), (timer) {
      if (mounted) {
        setState(() {
          _notificationCount = math.min(9, _notificationCount + 1);

          // Aggiungi una nuova notifica ogni tanto
          if (math.Random().nextInt(3) == 0) {
            final devices = [
              'Termostato Soggiorno',
              'Sensore Porta',
              'Luce Cucina',
              'Sensore Movimento Ingresso'
            ];
            final actions = [
              'ha cambiato stato',
              'richiede attenzione',
              'è stato attivato',
              'funziona normalmente'
            ];

            _recentNotifications.insert(0, {
              'title': devices[math.Random().nextInt(devices.length)],
              'message': actions[math.Random().nextInt(actions.length)],
              'icon': Icons.notifications_active,
              'color': Colors.purple,
              'time': DateTime.now(),
              'isRead': false,
            });

            if (_recentNotifications.length > 10) {
              _recentNotifications.removeLast();
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    _pulseController.dispose();
    _weatherController.dispose();
    _confettiController.dispose();
    _updateTimer?.cancel();
    _notificationTimer?.cancel();
    super.dispose();
  }

  // Metodi per gestire le funzionalità

  void _toggleVacationMode() {
    HapticFeedback.mediumImpact();
    setState(() {
      _showVacationMode = !_showVacationMode;
      if (_showVacationMode) {
        // Attiva l'animazione confetti per celebrare la modalità vacanza
        _showConfetti = true;
        _confettiController.play();
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            setState(() {
              _showConfetti = false;
            });
          }
        });
      }
    });
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
    });

    if (!_isEditMode) {
      // Salva l'ordine dei widget (in un'applicazione reale salveresti nelle preferenze)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Layout salvato con successo!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _toggleCompactMode() {
    setState(() {
      _useCompactMode = !_useCompactMode;
    });
  }

  void _showVoiceControlDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Row(
                children: [
                  Icon(Icons.mic),
                  SizedBox(width: 8),
                  Text('Controllo Vocale'),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animazione onde sonore
                  Lottie.network(
                    'https://lottie.host/06eea5f6-e79b-4684-bd85-34a890583605/5vfZCwzkJe.json',
                    height: 120,
                    repeat: true,
                  ),
                  const SizedBox(height: 16),
                  const Text('In ascolto...'),
                  const SizedBox(height: 20),
                  const Text('"Accendi le luci in soggiorno"',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.grey)),
                  const Text('"Imposta termostato a 22 gradi"',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.grey)),
                  const Text('"Qual è la temperatura in cucina?"',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.grey)),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Annulla'),
                ),
              ],
            ));
  }

  void _showSettingsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.3,
            maxChildSize: 0.95,
            expand: false,
            builder: (context, scrollController) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  controller: scrollController,
                  children: [
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            'Impostazioni Dashboard',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Personalizza la tua esperienza',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 32),

                    // Layout & Design
                    const Text(
                      'Layout & Design',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Modalità compatta'),
                      subtitle: const Text(
                          'Visualizza più informazioni in meno spazio'),
                      value: _useCompactMode,
                      onChanged: (value) {
                        setModalState(() {
                          _useCompactMode = value;
                        });
                        setState(() {
                          _useCompactMode = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Mostra meteo'),
                      value: _showWeatherCard,
                      onChanged: (value) {
                        setModalState(() {
                          _showWeatherCard = value;
                        });
                        setState(() {
                          _showWeatherCard = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Consigli risparmio'),
                      value: _showSavingsCard,
                      onChanged: (value) {
                        setModalState(() {
                          _showSavingsCard = value;
                        });
                        setState(() {
                          _showSavingsCard = value;
                        });
                      },
                    ),

                    const Divider(height: 32),

                    // Notifiche
                    const Text(
                      'Notifiche',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Notifiche push'),
                      subtitle: const Text('Ricevi avvisi in tempo reale'),
                      value: true,
                      onChanged: (value) {},
                    ),
                    SwitchListTile(
                      title: const Text('Avvisi critici'),
                      subtitle:
                          const Text('Ricevi sempre avvisi per eventi critici'),
                      value: true,
                      onChanged: (value) {},
                    ),
                    SwitchListTile(
                      title: const Text('Aggiornamenti automatici'),
                      subtitle: const Text(
                          'Installa automaticamente gli aggiornamenti'),
                      value: false,
                      onChanged: (value) {},
                    ),

                    const Divider(height: 32),

                    // Informazioni dell'app
                    const Text(
                      'Informazioni App',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const ListTile(
                      title: Text('Versione'),
                      trailing: Text('1.2.5'),
                    ),
                    const ListTile(
                      title: Text('Dispositivi connessi'),
                      trailing: Text('7 attivi'),
                    ),
                    const Divider(height: 16),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _toggleEditMode();
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Personalizza layout dashboard'),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Builder(builder: (context) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final colorScheme = Theme.of(context).colorScheme;
        final textTheme = Theme.of(context).textTheme;

        return Scaffold(
          appBar: AppBar(
            title: const Text('IoT Cloud Dashboard'),
            elevation: 0,
            scrolledUnderElevation: 2,
            surfaceTintColor: colorScheme.surfaceTint,
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            actions: [
              // Bottone modalità voce
              IconButton(
                icon: const Icon(Icons.mic),
                onPressed: _showVoiceControlDialog,
                tooltip: 'Controllo vocale',
              ),
              // Pulsante notifiche con contatore
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {
                      // Mostra pannello notifiche
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => _buildNotificationsPanel(),
                      );

                      // Resetta contatore notifiche
                      setState(() {
                        _notificationCount = 0;
                      });
                    },
                  ),
                  if (_notificationCount > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          _notificationCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              // Switch tema
              Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
              ),
              // Avatar utente
              GestureDetector(
                onTap: _showSettingsSheet,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage('https://picsum.photos/40'),
                  ),
                ),
              ),
            ],
          ),
          drawer: NavigationDrawer(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              if (index < 4) {
                // Schede principali
                setState(() {
                  _selectedIndex = index;
                });
                _pageController.jumpToPage(index);
                Navigator.pop(context);
              } else {
                // Schede aggiuntive
                Navigator.pop(context);
                switch (index) {
                  case 4: // Mappa Dispositivi
                    context.router.push(const DevicesMapRoute());
                    break;
                  case 5: // Notifiche
                    context.router.push(const NotificationsRoute());
                    break;
                  case 6: // Account
                    context.router.push(const AccountRoute());
                    break;
                  case 7: // Impostazioni
                    context.router.push(const SettingsRoute());
                    break;
                  case 8: // Aiuto
                    context.router.push(const HelpRoute());
                    break;
                  case 9: // OTA
                    context.router.push(const FirmwareUpdateRoute());
                    break;
                  case 10: // IDE
                    context.router.push(const CodeEditorRoute());
                    break;
                }
              }
            },
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 24, 16, 24),
                child: Text(
                  'IoT Control Center',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const NavigationDrawerDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              const NavigationDrawerDestination(
                icon: Icon(Icons.devices_outlined),
                selectedIcon: Icon(Icons.devices),
                label: Text('Dispositivi'),
              ),
              const NavigationDrawerDestination(
                icon: Icon(Icons.analytics_outlined),
                selectedIcon: Icon(Icons.analytics),
                label: Text('Analisi'),
              ),
              const NavigationDrawerDestination(
                icon: Icon(Icons.rule_outlined),
                selectedIcon: Icon(Icons.rule),
                label: Text('Automazioni'),
              ),
              const Divider(),
              const NavigationDrawerDestination(
                icon: Icon(Icons.map_outlined),
                selectedIcon: Icon(Icons.map),
                label: Text('Mappa Dispositivi'),
              ),
              NavigationDrawerDestination(
                icon: Badge(
                  label: Text(_notificationCount.toString()),
                  isLabelVisible: _notificationCount > 0,
                  child: const Icon(Icons.notifications_outlined),
                ),
                selectedIcon: Badge(
                  label: Text(_notificationCount.toString()),
                  isLabelVisible: _notificationCount > 0,
                  child: const Icon(Icons.notifications),
                ),
                label: const Text('Notifiche'),
              ),
              const Divider(),
              const NavigationDrawerDestination(
                icon: Icon(Icons.account_circle_outlined),
                selectedIcon: Icon(Icons.account_circle),
                label: Text('Account'),
              ),
              const NavigationDrawerDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: Text('Impostazioni'),
              ),
              const NavigationDrawerDestination(
                icon: Icon(Icons.help_outline),
                selectedIcon: Icon(Icons.help),
                label: Text('Aiuto'),
              ),
              const NavigationDrawerDestination(
                icon: Icon(Icons.update_outlined),
                selectedIcon: Icon(Icons.update),
                label: Text('OTA'),
              ),
              const NavigationDrawerDestination(
                icon: Icon(Icons.code_outlined),
                selectedIcon: Icon(Icons.code),
                label: Text('IDE'),
              ),

              // Modalità Vacanza
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 16, 28, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Modalità Vacanza',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Switch(
                      value: _showVacationMode,
                      onChanged: (value) => _toggleVacationMode(),
                    ),
                  ],
                ),
              ),
              if (_showVacationMode)
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 8, 28, 16),
                  child: Text(
                    'Modalità vacanza attiva: temperatura e dispositivi ottimizzati per risparmio energetico',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
            ],
          ),
          // Confetti overlay per eventi celebrativi
          body: Stack(
            children: [
              PageView(
                controller: _pageController,
                physics:
                    const NeverScrollableScrollPhysics(), // Disable page sliding
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: [
                  // Dashboard Page
                  _buildDashboardTab(),

                  // Devices Page
                  _buildDevicesTab(),

                  // Analytics Page
                  _buildAnalyticsTab(),

                  // Automation Page
                  _buildAutomationTab(),
                ],
              ),

              // Confetti overlay
              if (_showConfetti)
                Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirectionality: BlastDirectionality.explosive,
                    particleDrag: 0.05,
                    emissionFrequency: 0.05,
                    numberOfParticles: 50,
                    gravity: 0.1,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ],
                  ),
                ),

              // Edit mode overlay
              if (_isEditMode)
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: colorScheme.onPrimaryContainer),
                        const SizedBox(width: 8),
                        Text(
                          'Modalità modifica: trascina per riordinare',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: _toggleEditMode,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                          ),
                          child: const Text('Salva'),
                        ),
                      ],
                    ),
                  ),
                ),

              // Modalità vacanza overlay
              if (_showVacationMode)
                Positioned(
                  bottom: 80,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.amber.shade900
                            : Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.flight_takeoff,
                            color:
                                isDark ? Colors.white : Colors.amber.shade900,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Modalità Vacanza Attiva',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  isDark ? Colors.white : Colors.amber.shade900,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _toggleVacationMode,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark
                                  ? Colors.amber.shade800
                                  : Colors.amber.shade200,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              minimumSize: const Size(0, 30),
                            ),
                            child: Text(
                              'Disattiva',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? Colors.white
                                    : Colors.amber.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
              _pageController.jumpToPage(index);
            },
            elevation: 3,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              NavigationDestination(
                icon: Icon(Icons.devices_outlined),
                selectedIcon: Icon(Icons.devices),
                label: 'Dispositivi',
              ),
              NavigationDestination(
                icon: Icon(Icons.analytics_outlined),
                selectedIcon: Icon(Icons.analytics),
                label: 'Analisi',
              ),
              NavigationDestination(
                icon: Icon(Icons.rule_outlined),
                selectedIcon: Icon(Icons.rule),
                label: 'Automazioni',
              ),
            ],
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Aggiungi Dispositivo',
            child: const Icon(Icons.add),
          ),
        );
      }),
    );
  }

  // Pannello delle notifiche
  Widget _buildNotificationsPanel() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Notifiche',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    for (var notif in _recentNotifications) {
                      notif['isRead'] = true;
                    }
                  });
                  Navigator.pop(context);
                },
                child: const Text('Segna tutte come lette'),
              ),
            ],
          ),
          const Divider(),
          if (_recentNotifications.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.notifications_off_outlined,
                        size: 48, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('Nessuna notifica'),
                  ],
                ),
              ),
            )
          else
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: _recentNotifications.length,
                itemBuilder: (context, index) {
                  final notification = _recentNotifications[index];
                  final isRead = notification['isRead'] as bool;

                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            setState(() {
                              _recentNotifications.removeAt(index);
                            });
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
                          fontWeight:
                              isRead ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notification['message'] as String),
                          const SizedBox(height: 4),
                          Text(
                            _formatNotificationTime(
                                notification['time'] as DateTime),
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      trailing: !isRead
                          ? Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          notification['isRead'] = true;
                        });
                      },
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  // Build Dashboard Tab - Versione con widget riordinabili
  Widget _buildDashboardTab() {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          // Simulate data refresh
          await Future.delayed(const Duration(seconds: 1));
          if (mounted) {
            setState(() {
              final random = math.Random();
              _temperature = 21.5 + random.nextDouble() * 2;
              _humidity = 65 + random.nextDouble() * 10;
            });
          }
        },
        child: _isEditMode
            ? _buildReorderableDashboard()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildDashboardWidgets(),
                ),
              ),
      ),
    );
  }

  // Dashboard con widget riordinabili
  Widget _buildReorderableDashboard() {
    return ReorderableListView(
      padding: const EdgeInsets.all(16.0),
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = _dashboardWidgets.removeAt(oldIndex);
          _dashboardWidgets.insert(newIndex, item);
        });
      },
      proxyDecorator: (widget, index, animation) => Material(
        elevation: 4,
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        child: widget,
      ),
      children: _buildReorderableWidgets(),
    );
  }

  // Costruisce i widget del dashboard in modo riordinabile
  List<Widget> _buildReorderableWidgets() {
    List<Widget> widgets = [];

    for (int i = 0; i < _dashboardWidgets.length; i++) {
      String type = _dashboardWidgets[i];
      Widget widget;

      switch (type) {
        case 'stats':
          widget = _buildWidgetContainer(
            key: ValueKey('stats'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Panoramica Dispositivi'),
                const SizedBox(height: 16),
                _buildStatusCardsGrid(),
              ],
            ),
          );
          break;

        case 'environment':
          widget = _buildWidgetContainer(
            key: ValueKey('environment'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Condizioni Ambientali'),
                const SizedBox(height: 16),
                _buildEnvironmentalCards(),
              ],
            ),
          );
          break;

        case 'energy':
          widget = _buildWidgetContainer(
            key: ValueKey('energy'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Consumo Energetico'),
                const SizedBox(height: 16),
                _buildEnergyCard(),
              ],
            ),
          );
          break;

        case 'devices':
          widget = _buildWidgetContainer(
            key: ValueKey('devices'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSectionHeader('Dispositivi Attivi'),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _selectedIndex = 1;
                        });
                        _pageController.jumpToPage(1);
                      },
                      icon: const Icon(Icons.visibility),
                      label: const Text('Vedi Tutti'),
                    ),
                  ],
                ),
                _buildDeviceList(),
              ],
            ),
          );
          break;

        case 'automation':
          widget = _buildWidgetContainer(
            key: ValueKey('automation'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Automazioni Rapide'),
                const SizedBox(height: 16),
                _buildQuickAutomations(),
              ],
            ),
          );
          break;

        case 'savings':
          widget = _showSavingsCard
              ? _buildWidgetContainer(
                  key: ValueKey('savings'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('Consigli Risparmio'),
                      const SizedBox(height: 16),
                      _buildEnergySavingsWidget(),
                    ],
                  ),
                )
              : const SizedBox(key: ValueKey('savings'), height: 0);
          break;

        case 'weather':
          widget = _showWeatherCard
              ? _buildWidgetContainer(
                  key: ValueKey('weather'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('Previsioni Meteo'),
                      const SizedBox(height: 16),
                      _buildWeatherForecastWidget(),
                    ],
                  ),
                )
              : const SizedBox(key: ValueKey('weather'), height: 0);
          break;

        default:
          widget = Container(key: ValueKey('unknown-$i'));
      }

      widgets.add(widget);
    }

    return widgets;
  }

  // Container per widget riordinabili
  Widget _buildWidgetContainer({required Key key, required Widget child}) {
    return Container(
      key: key,
      margin: const EdgeInsets.only(bottom: 24),
      child: child,
    );
  }

  // Costruisce i widget del dashboard in ordine personalizzato
  List<Widget> _buildDashboardWidgets() {
    List<Widget> widgets = [];

    // Welcome Card sempre in cima
    widgets.add(_buildWelcomeCard());
    widgets.add(const SizedBox(height: 24));

    for (String type in _dashboardWidgets) {
      switch (type) {
        case 'stats':
          widgets.add(_buildSectionHeader('Panoramica Dispositivi'));
          widgets.add(const SizedBox(height: 16));
          widgets.add(_buildStatusCardsGrid());
          widgets.add(const SizedBox(height: 24));
          break;

        case 'environment':
          widgets.add(_buildSectionHeader('Condizioni Ambientali'));
          widgets.add(const SizedBox(height: 16));
          widgets.add(_buildEnvironmentalCards());
          widgets.add(const SizedBox(height: 24));
          break;

        case 'energy':
          widgets.add(_buildSectionHeader('Consumo Energetico'));
          widgets.add(const SizedBox(height: 16));
          widgets.add(_buildEnergyCard());
          widgets.add(const SizedBox(height: 24));
          break;

        case 'devices':
          widgets.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionHeader('Dispositivi Attivi'),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                  _pageController.jumpToPage(1);
                },
                icon: const Icon(Icons.visibility),
                label: const Text('Vedi Tutti'),
              ),
            ],
          ));
          widgets.add(const SizedBox(height: 16));
          widgets.add(_buildDeviceList());
          widgets.add(const SizedBox(height: 24));
          break;

        case 'automation':
          widgets.add(_buildSectionHeader('Automazioni Rapide'));
          widgets.add(const SizedBox(height: 16));
          widgets.add(_buildQuickAutomations());
          widgets.add(const SizedBox(height: 24));
          break;

        case 'savings':
          if (_showSavingsCard) {
            widgets.add(_buildSectionHeader('Consigli Risparmio'));
            widgets.add(const SizedBox(height: 16));
            widgets.add(_buildEnergySavingsWidget());
            widgets.add(const SizedBox(height: 24));
          }
          break;

        case 'weather':
          if (_showWeatherCard) {
            widgets.add(_buildSectionHeader('Previsioni Meteo'));
            widgets.add(const SizedBox(height: 16));
            widgets.add(_buildWeatherForecastWidget());
            widgets.add(const SizedBox(height: 24));
          }
          break;
      }
    }

    // Aggiungi modulo delle posizioni recenti (sempre in fondo)
    widgets.add(_buildSectionHeader('Posizioni Recenti'));
    widgets.add(const SizedBox(height: 16));
    widgets.add(_buildLocationHistoryWidget());

    // Spazio in fondo
    widgets.add(const SizedBox(height: 32));

    return widgets;
  }

  Widget _buildStatusCardsGrid() {
    // Layout compatto o standard
    if (_useCompactMode) {
      return Row(
        children: [
          Expanded(
            flex: 3,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Stato Dispositivi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCompactStatusItem(
                          icon: Icons.check_circle_outline,
                          color: Colors.green,
                          title: 'Online',
                          value: '18',
                        ),
                        _buildCompactStatusItem(
                          icon: Icons.error_outline,
                          color: Colors.red,
                          title: 'Offline',
                          value: '3',
                        ),
                        _buildCompactStatusItem(
                          icon: Icons.warning_amber_outlined,
                          color: Colors.orange,
                          title: 'Avvisi',
                          value: '5',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: _buildStatusCard(
              icon: Icons.trending_down,
              color: Colors.green,
              title: 'Risparmio',
              value: '${_energySavings.toStringAsFixed(1)}%',
            ),
          ),
        ],
      );
    } else {
      return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildStatusCard(
            icon: Icons.check_circle_outline,
            color: Colors.green,
            title: 'Online',
            value: '18',
          ),
          _buildStatusCard(
            icon: Icons.error_outline,
            color: Colors.red,
            title: 'Offline',
            value: '3',
          ),
          _buildStatusCard(
            icon: Icons.warning_amber_outlined,
            color: Colors.orange,
            title: 'Avvisi',
            value: '5',
          ),
          _buildStatusCard(
            icon: Icons.trending_down,
            color: Colors.green,
            title: 'Risparmio',
            value: '${_energySavings.toStringAsFixed(1)}%',
          ),
        ],
      );
    }
  }

  // Versione compatta degli status
  Widget _buildCompactStatusItem({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // Build Welcome Card con riepilogo personalizzato
  Widget _buildWelcomeCard() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final now = DateTime.now();
    final hour = now.hour;
    String greeting;

    if (hour < 12) {
      greeting = 'Buongiorno';
    } else if (hour < 18) {
      greeting = 'Buon pomeriggio';
    } else {
      greeting = 'Buonasera';
    }

    return Card(
      elevation: 0,
      color: colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (_showVacationMode)
                  Icon(Icons.flight_takeoff,
                      size: 36, color: colorScheme.onPrimaryContainer)
                else
                  Icon(hour < 18 ? Icons.wb_sunny : Icons.nightlight_round,
                      size: 36, color: colorScheme.onPrimaryContainer),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$greeting, Marco',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '18 di 21 dispositivi online',
                        style: TextStyle(
                          color:
                              colorScheme.onPrimaryContainer.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_useCompactMode)
                  SizedBox(
                    width: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${_temperature.toStringAsFixed(1)}°',
                          style: TextStyle(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          _weatherCondition,
                          style: TextStyle(
                            color:
                                colorScheme.onPrimaryContainer.withOpacity(0.7),
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            // Progresso dispositivi
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 18 / 21,
                    backgroundColor:
                        colorScheme.onPrimaryContainer.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.onPrimaryContainer.withOpacity(0.8),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                if (!_useCompactMode) ...[
                  const SizedBox(width: 16),
                  // Stato casa (attivo solo se non in modalità compatta)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _showVacationMode
                          ? colorScheme.tertiaryContainer
                          : colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _showVacationMode ? Icons.flight : Icons.home,
                          size: 14,
                          color: _showVacationMode
                              ? colorScheme.onTertiaryContainer
                              : colorScheme.onSecondaryContainer,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _showVacationMode ? 'Vacanza' : 'Normale',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _showVacationMode
                                ? colorScheme.onTertiaryContainer
                                : colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),

            // In modalità normale, mostra consigli risparmio e stato dispositivi
            if (!_useCompactMode) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: [
                  _buildInfoChip(
                    icon: Icons.thermostat,
                    label: '${_temperature.toStringAsFixed(1)}°C interno',
                  ),
                  _buildInfoChip(
                    icon: Icons.wb_sunny,
                    label: _weatherCondition,
                  ),
                  _buildInfoChip(
                    icon: Icons.trending_down,
                    label: '-${_energySavings.toStringAsFixed(1)}% energia',
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Chip informative
  Widget _buildInfoChip({required IconData icon, required String label}) {
    final colorScheme = Theme.of(context).colorScheme;

    return Chip(
      backgroundColor: colorScheme.onPrimaryContainer.withOpacity(0.2),
      side: BorderSide.none,
      labelPadding: EdgeInsets.zero,
      avatar: Icon(
        icon,
        size: 16,
        color: colorScheme.onPrimaryContainer,
      ),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: colorScheme.onPrimaryContainer,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
    );
  }

  // Widget previsioni meteo
  Widget _buildWeatherForecastWidget() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _weatherCondition,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${_temperature.toStringAsFixed(1)}°C',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _weatherForecast.length,
                itemBuilder: (context, index) {
                  final forecast = _weatherForecast[index];
                  return Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          forecast['day'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Icon(
                          forecast['icon'] as IconData,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${forecast['temp']}°C',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherDetail(
                  icon: Icons.water_drop,
                  value: '${_humidity.toStringAsFixed(0)}%',
                  label: 'Umidità',
                ),
                _buildWeatherDetail(
                  icon: Icons.air,
                  value: '8 km/h',
                  label: 'Vento',
                ),
                _buildWeatherDetail(
                  icon: Icons.compress,
                  value: '1015 hPa',
                  label: 'Pressione',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Dettagli meteo
  Widget _buildWeatherDetail({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // Widget consigli risparmio energetico
  Widget _buildEnergySavingsWidget() {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        for (var tip in _energySavingTips)
          Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          tip['icon'] as IconData,
                          color: colorScheme.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tip['title'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tip['description'] as String,
                              style: TextStyle(
                                fontSize: 13,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Risparmio: ${tip['savings']}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  // Widget posizioni recenti con geofencing
  Widget _buildLocationHistoryWidget() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.location_on_outlined),
                SizedBox(width: 8),
                Text(
                  'Posizioni recenti',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...List.generate(_locationHistory.length, (index) {
              final location = _locationHistory[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: location['isHome'] as bool
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.orange.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        location['isHome'] as bool
                            ? Icons.home
                            : Icons.location_on,
                        color: location['isHome'] as bool
                            ? Colors.blue
                            : Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location['location'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _formatLocationTime(location['time'] as DateTime),
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (location['isHome'] as bool)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'A casa',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      const Icon(Icons.chevron_right),
                  ],
                ),
              );
            }),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map_outlined),
              label: const Text('Visualizza mappa completa'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build Environmental Cards
  Widget _buildEnvironmentalCards() {
    if (_useCompactMode) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Condizioni interne',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCompactEnvironmentalItem(
                    icon: Icons.thermostat,
                    value: '${_temperature.toStringAsFixed(1)}°C',
                    label: 'Temperatura',
                    color: Colors.orange,
                  ),
                  _buildCompactEnvironmentalItem(
                    icon: Icons.water_drop,
                    value: '${_humidity.toStringAsFixed(0)}%',
                    label: 'Umidità',
                    color: Colors.blue,
                  ),
                  _buildCompactEnvironmentalItem(
                    icon: Icons.co2,
                    value: '450 ppm',
                    label: 'CO₂',
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Slider temperatura
              Row(
                children: [
                  const Icon(Icons.thermostat, size: 20),
                  const SizedBox(width: 8),
                  const Text('Imposta temperatura'),
                  const Spacer(),
                  Text(
                    '${_targetTemperature.toStringAsFixed(1)}°C',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Slider(
                value: _targetTemperature,
                min: 16,
                max: 28,
                divisions: 24,
                onChanged: (value) {
                  setState(() {
                    _targetTemperature = value;
                  });
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: _buildEnvironmentalCard(
              title: 'Temperatura',
              value: '${_temperature.toStringAsFixed(1)}°C',
              icon: Icons.thermostat,
              color: Colors.orange,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildEnvironmentalCard(
              title: 'Umidità',
              value: '${_humidity.toStringAsFixed(0)}%',
              icon: Icons.water_drop,
              color: Colors.blue,
            ),
          ),
        ],
      );
    }
  }

  // Ambiente compatto item
  Widget _buildCompactEnvironmentalItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
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

  // Build Environmental Card
  Widget _buildEnvironmentalCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Aggiornato ora',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            // Solo per temperatura, aggiungi uno slider
            if (title == 'Temperatura') ...[
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Target:'),
                  Text(
                    '${_targetTemperature.toStringAsFixed(1)}°C',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Slider(
                value: _targetTemperature,
                min: 16,
                max: 28,
                divisions: 24,
                onChanged: (value) {
                  setState(() {
                    _targetTemperature = value;
                  });
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Build Energy Card
  Widget _buildEnergyCard() {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Consumo attuale',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.bolt,
                        size: 16,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '3.8 kW',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // In modalità compatta, mostra meno dati
            if (_useCompactMode)
              SizedBox(
                height: 150,
                child: _buildConsumptionChart(),
              )
            else
              SizedBox(
                height: 200,
                child: _buildConsumptionChart(),
              ),

            const SizedBox(height: 16),

            // Riepilogo
            if (_useCompactMode)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildEnergyUsageSummary(
                    title: 'Oggi',
                    value: '18.5 kWh',
                  ),
                  _buildEnergyUsageSummary(
                    title: 'Questo Mese',
                    value: '412 kWh',
                  ),
                  _buildEnergyUsageSummary(
                    title: 'Tendenza',
                    value: '-5.7%',
                    isPositive: false,
                  ),
                ],
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildEnergyUsageSummary(
                    title: 'Oggi',
                    value: '18.5 kWh',
                  ),
                  _buildEnergyUsageSummary(
                    title: 'Questo Mese',
                    value: '412 kWh',
                  ),
                  _buildEnergyUsageSummary(
                    title: 'Tendenza',
                    value: '-5.7%',
                    isPositive: false,
                  ),
                  _buildEnergyUsageSummary(
                    title: 'Costo stimato',
                    value: '€65',
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Grafico consumi
  Widget _buildConsumptionChart() {
    final colorScheme = Theme.of(context).colorScheme;

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 5,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: colorScheme.outline.withOpacity(0.2),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 2,
              getTitlesWidget: (value, meta) {
                // Solo alcuni giorni per ridurre il carico visivo
                if (value % 2 != 0) return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _getWeekdayShort(value.toInt()),
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 5,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()} kWh',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
                );
              },
              reservedSize: 40,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: _getEnergyDataPoints(),
            isCurved: true,
            curveSmoothness: 0.2,
            color: colorScheme.primary,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: colorScheme.primary.withOpacity(0.2),
            ),
          ),
        ],
        minY: 0,
        maxY: 25,
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            // tooltipBgColor: colorScheme
            // .surfaceVariant, // Corretto da tooltipBackgroundColor
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                return LineTooltipItem(
                  '${_getWeekday(touchedSpot.x.toInt())}: ${touchedSpot.y.toStringAsFixed(1)} kWh',
                  TextStyle(color: colorScheme.onSurfaceVariant),
                );
              }).toList();
            },
          ),
          handleBuiltInTouches: true,
        ),
      ),
    );
  }

  // Genera punti per grafico energia
  List<FlSpot> _getEnergyDataPoints() {
    final random = math.Random(42); // Seed fisso per consistenza
    return List.generate(7, (index) {
      // Genera valori random tra 10 e 25 kWh al giorno
      double value = 10 + random.nextDouble() * 15;
      return FlSpot(index.toDouble(), value);
    });
  }

  // Ottieni giorno della settimana abbreviato
  String _getWeekdayShort(int day) {
    List<String> days = ['Lun', 'Mar', 'Mer', 'Gio', 'Ven', 'Sab', 'Dom'];
    return days[day % 7];
  }

  // Ottieni giorno della settimana
  String _getWeekday(int day) {
    List<String> days = [
      'Lunedì',
      'Martedì',
      'Mercoledì',
      'Giovedì',
      'Venerdì',
      'Sabato',
      'Domenica'
    ];
    return days[day % 7];
  }

  // Build Energy Usage Summary
  Widget _buildEnergyUsageSummary({
    required String title,
    required String value,
    bool? isPositive,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Color valueColor = colorScheme.onSurface;
    if (isPositive != null) {
      valueColor = isPositive ? Colors.green : Colors.red;
    }

    return Column(
      children: [
        Text(
          title,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  // Build Quick Automations
  Widget _buildQuickAutomations() {
    final colorScheme = Theme.of(context).colorScheme;

    return _useCompactMode
        ? _buildCompactQuickAutomations()
        : Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Attiva scenario',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildQuickScenarioButton(
                        icon: Icons.home,
                        label: 'Casa',
                        onTap: () {},
                        isActive: true,
                      ),
                      _buildQuickScenarioButton(
                        icon: Icons.nightlight,
                        label: 'Notte',
                        onTap: () {},
                      ),
                      _buildQuickScenarioButton(
                        icon: Icons.movie,
                        label: 'Cinema',
                        onTap: () {},
                      ),
                      _buildQuickScenarioButton(
                        icon: Icons.restaurant,
                        label: 'Cena',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Automatismi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 3; // Vai alla tab automazioni
                          });
                          _pageController.jumpToPage(3);
                        },
                        child: const Text('Gestisci'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildAutomationSwitchTile(
                    title: 'Luci automatiche sera',
                    subtitle: 'Le luci si accendono al tramonto',
                    value: true,
                    onChanged: (value) {},
                  ),
                  _buildAutomationSwitchTile(
                    title: 'Temperatura notte',
                    subtitle: 'Riduzione temperatura alle 23:00',
                    value: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          );
  }

  // Versione compatta di automazioni rapide
  Widget _buildCompactQuickAutomations() {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildQuickScenarioCard(
                icon: Icons.home,
                label: 'Casa',
                onTap: () {},
                isActive: true,
              ),
              _buildQuickScenarioCard(
                icon: Icons.nightlight,
                label: 'Notte',
                onTap: () {},
              ),
              _buildQuickScenarioCard(
                icon: Icons.movie,
                label: 'Cinema',
                onTap: () {},
              ),
              _buildQuickScenarioCard(
                icon: Icons.restaurant,
                label: 'Cena',
                onTap: () {},
              ),
              _buildQuickScenarioCard(
                icon: Icons.flight_takeoff,
                label: 'Vacanza',
                onTap: _toggleVacationMode,
                isActive: _showVacationMode,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Quick Scenario Button
  Widget _buildQuickScenarioButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color:
                  isActive ? colorScheme.primary : colorScheme.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive
                  ? colorScheme.onPrimary
                  : colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? colorScheme.primary : colorScheme.onSurface,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // Quick Scenario Card
  Widget _buildQuickScenarioCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(right: 12),
      color: isActive ? colorScheme.primaryContainer : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 100,
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
                size: 30,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: isActive
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurface,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Automazione SwitchTile
  Widget _buildAutomationSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
    );
  }

  // Format notification time
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

  // Format location time
  String _formatLocationTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minuti fa';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ore fa';
    } else {
      return DateFormat('dd/MM, HH:mm').format(time);
    }
  }

  // Build Section Header
  Widget _buildSectionHeader(String title) {
    final textTheme = Theme.of(context).textTheme;

    return Text(
      title,
      style: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Build Status Card
  Widget _buildStatusCard({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 36,
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build Device List
  Widget _buildDeviceList() {
    // Mock dispositivi
    final devices = [
      {
        'name': 'Termostato Soggiorno',
        'type': 'Temperatura',
        'status': 'Online',
        'value': '${_temperature.toStringAsFixed(1)}°C',
        'icon': Icons.thermostat,
        'color': Colors.orange,
      },
      {
        'name': 'Sensore Porta Ingresso',
        'type': 'Sicurezza',
        'status': 'Online',
        'value': 'Chiuso',
        'icon': Icons.door_front_door,
        'color': Colors.blue,
      },
      {
        'name': 'Smart Light Cucina',
        'type': 'Illuminazione',
        'status': 'Online',
        'value': 'Acceso',
        'icon': Icons.lightbulb,
        'color': Colors.amber,
      },
    ];

    return Column(
      children: devices.map((device) {
        return _buildDeviceItem(device);
      }).toList(),
    );
  }

  // Build Device Card
  Widget _buildDeviceItem(Map<String, dynamic> device) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: (device['color'] as Color).withOpacity(0.2),
                child: Icon(
                  device['icon'] as IconData,
                  color: device['color'] as Color,
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${device['type']} • ${device['status']}',
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              // Animazione pulsatile per i dispositivi attivi
              if (device['status'] == 'Online' && device['value'] == 'Acceso')
                FadeTransition(
                  opacity: Tween<double>(begin: 0.6, end: 1.0)
                      .animate(_pulseController),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    device['value'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  // Piccolo switch per i dispositivi che possono essere controllati
                  if (device['type'] == 'Illuminazione')
                    Switch(
                      value: device['value'] == 'Acceso',
                      onChanged: (value) {},
                    )
                  else
                    Text(
                      'Aggiornato ora',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build Devices Tab
  Widget _buildDevicesTab() {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        // Search and Filter Bar
        Card(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Icon(
                  Icons.search,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cerca dispositivi...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                  tooltip: 'Filtra',
                ),
              ],
            ),
          ),
        ),

        // Device Categories Tabs
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tutti'),
            Tab(text: 'Online'),
            Tab(text: 'Offline'),
            Tab(text: 'Preferiti'),
          ],
          isScrollable: true,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),

        // Devices List
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // All Devices
              _buildDevicesGridView(_MockData.devices),
              // Online Devices
              _buildDevicesGridView(_MockData.onlineDevices),
              // Offline Devices
              _buildDevicesGridView(_MockData.offlineDevices),
              // Favorite Devices (Mock data - just the first 2 devices)
              _buildDevicesGridView(
                  [_MockData.devices[0], _MockData.devices[2]]),
            ],
          ),
        ),
      ],
    );
  }

  // Build devices in a grid view layout
  Widget _buildDevicesGridView(List<Map<String, dynamic>> devices) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: devices.isEmpty
          ? _buildEmptyDevicesView()
          : _useCompactMode
              ? _buildCompactDevicesGrid(devices)
              : _buildFullDevicesGrid(devices),
    );
  }

  // Empty view when no devices in a category
  Widget _buildEmptyDevicesView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.devices_other,
            size: 64,
            color:
                Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'Nessun dispositivo trovato',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Aggiungi dispositivi o cambia i filtri',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Aggiungi Dispositivo'),
          ),
        ],
      ),
    );
  }

  // Build compact devices grid
  Widget _buildCompactDevicesGrid(List<Map<String, dynamic>> devices) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return _buildCompactDeviceCard(device);
      },
    );
  }

  // Compact device card
  Widget _buildCompactDeviceCard(Map<String, dynamic> device) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool isOnline = device['status'] == 'Online';

    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: (device['color'] as Color).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      device['icon'] as IconData,
                      color: device['color'] as Color,
                      size: 30,
                    ),
                  ),
                  // Indicatore di stato
                  if (isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).cardColor,
                            width: 2,
                          ),
                        ),
                      ),
                    )
                  else
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).cardColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                device['name'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '${device['type']}',
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isOnline
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  device['value'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isOnline ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build full devices grid
  Widget _buildFullDevicesGrid(List<Map<String, dynamic>> devices) {
    return ListView.builder(
      itemCount: devices.length,
      itemBuilder: (context, index) => _buildFullDeviceCard(devices[index]),
    );
  }

  // Full device card
  Widget _buildFullDeviceCard(Map<String, dynamic> device) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Determine status color
    Color statusColor;
    switch (device['status']) {
      case 'Online':
        statusColor = Colors.green;
        break;
      case 'Offline':
        statusColor = Colors.red;
        break;
      case 'Standby':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.settings,
              label: 'Configura',
            ),
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Rimuovi',
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            // Mostra dettaglio dispositivo
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => _buildDeviceDetailSheet(device),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor:
                          (device['color'] as Color).withOpacity(0.2),
                      child: Icon(
                        device['icon'] as IconData,
                        color: device['color'] as Color,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            device['name'] as String,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${device['status']} • ${device['type']}',
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          device['value'] as String,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        device['status'] != 'Offline'
                            ? _buildBatteryIndicator(device['battery'] as int)
                            : Text(
                                'Ultimo: ${_formatLastSeen(device['lastUpdate'] as DateTime)}',
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),

                // Show details if there's history data
                if (device['history'] is List &&
                    (device['history'] as List).isNotEmpty)
                  Column(
                    children: [
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 60,
                        child: _buildDeviceHistoryChart(device),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build Device History Chart
  Widget _buildDeviceHistoryChart(Map<String, dynamic> device) {
    final colorScheme = Theme.of(context).colorScheme;

    // Temperature or humidity data
    if (device['type'] == 'Temperatura' || device['type'] == 'Umidità') {
      final history = device['history'] as List<double>;
      return LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(history.length, (index) {
                return FlSpot(index.toDouble(), history[index]);
              }),
              isCurved: true,
              curveSmoothness: 0.2,
              color: device['color'] as Color,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: (device['color'] as Color).withOpacity(0.2),
              ),
            ),
          ],
        ),
      );
    }

    // Binary data (on/off)
    if (device['history'] is List<int>) {
      final history = device['history'] as List<int>;
      return Row(
        children: List.generate(
          history.length,
          (index) => Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: index == 0 ? 0 : 2,
                right: index == history.length - 1 ? 0 : 2,
              ),
              color: history[index] == 1
                  ? (device['color'] as Color)
                  : colorScheme.surfaceVariant,
              height: 20,
            ),
          ),
        ),
      );
    }

    // Default empty chart
    return const Center(
      child: Text('Nessun dato storico disponibile'),
    );
  }

  // Device detail bottom sheet
  Widget _buildDeviceDetailSheet(Map<String, dynamic> device) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool isOnline = device['status'] == 'Online';

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.onSurfaceVariant.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Header
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          (device['color'] as Color).withOpacity(0.2),
                      child: Icon(
                        device['icon'] as IconData,
                        color: device['color'] as Color,
                        size: 30,
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            device['type'] as String,
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isOnline
                            ? Colors.green.withOpacity(0.2)
                            : Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        device['status'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isOnline ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Value and Controls
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Stato attuale',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Displayed value and controls depend on device type
                        if (device['type'] == 'Temperatura')
                          _buildTemperatureControl(device)
                        else if (device['type'] == 'Illuminazione')
                          _buildLightControl(device)
                        else if (device['type'] == 'Sicurezza')
                          _buildSecurityControl(device)
                        else if (device['type'] == 'Umidità')
                          _buildHumidityInfo(device)
                        else
                          Center(
                            child: Text(
                              device['value'] as String,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Activity and History
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Attività recenti',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (device['history'] is List &&
                            (device['history'] as List).isNotEmpty)
                          SizedBox(
                            height: 180,
                            child: _buildDetailedHistoryChart(device),
                          )
                        else
                          const Center(
                            child: Text('Nessun dato storico disponibile'),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Device Information
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Informazioni dispositivo',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow('Modello', 'Smart Home v2'),
                        _buildInfoRow('ID Dispositivo', device['id'] as String),
                        _buildInfoRow('Stanza', 'Soggiorno'),
                        _buildInfoRow(
                            'Ultimo aggiornamento',
                            _formatFullDateTime(
                                device['lastUpdate'] as DateTime)),
                        _buildInfoRow(
                            'Livello batteria', '${device['battery']}%'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.settings),
                        label: const Text('Configura'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Chiudi'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }

  // Info row for device details
  Widget _buildInfoRow(String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Temperature control
  Widget _buildTemperatureControl(Map<String, dynamic> device) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.thermostat,
              color: device['color'] as Color,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              device['value'] as String,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Temperatura target: ${_targetTemperature.toStringAsFixed(1)}°C',
          style: TextStyle(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _targetTemperature = math.max(16, _targetTemperature - 0.5);
                });
              },
              icon: const Icon(Icons.remove),
            ),
            Expanded(
              child: Slider(
                value: _targetTemperature,
                min: 16,
                max: 28,
                divisions: 24,
                label: _targetTemperature.toStringAsFixed(1),
                onChanged: (value) {
                  setState(() {
                    _targetTemperature = value;
                  });
                },
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _targetTemperature = math.min(28, _targetTemperature + 0.5);
                });
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTemperaturePreset('Auto', 22.0),
            _buildTemperaturePreset('Comfort', 24.0),
            _buildTemperaturePreset('Eco', 20.0),
            _buildTemperaturePreset('Notte', 18.0),
          ],
        ),
      ],
    );
  }

  // Temperature preset button
  Widget _buildTemperaturePreset(String label, double temperature) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = (temperature - _targetTemperature).abs() < 0.1;

    return InkWell(
      onTap: () {
        setState(() {
          _targetTemperature = temperature;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected
                ? colorScheme.onPrimary
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  // Light control
  Widget _buildLightControl(Map<String, dynamic> device) {
    final bool isOn = device['value'] == 'Acceso';

    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: isOn ? 100 : 80,
                height: isOn ? 100 : 80,
                decoration: BoxDecoration(
                  color: isOn
                      ? Colors.amber.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isOn ? 60 : 40,
                height: isOn ? 60 : 40,
                decoration: BoxDecoration(
                  color: isOn ? Colors.amber : Colors.grey,
                  shape: BoxShape.circle,
                  boxShadow: isOn
                      ? [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 10,
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  isOn ? Icons.lightbulb : Icons.lightbulb_outline,
                  color: isOn ? Colors.white : Colors.black54,
                  size: isOn ? 30 : 24,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Spento'),
            const SizedBox(width: 12),
            Switch(
              value: isOn,
              onChanged: (value) {},
            ),
            const SizedBox(width: 12),
            const Text('Acceso'),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Luminosità',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Slider(
          value: 0.7,
          onChanged: (value) {},
        ),
        const SizedBox(height: 16),
        const Text(
          'Colore',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildColorPreset(Colors.white),
            _buildColorPreset(Colors.amber.shade200),
            _buildColorPreset(Colors.blue.shade200),
            _buildColorPreset(Colors.purple.shade200),
            _buildColorPreset(Colors.red.shade200),
          ],
        ),
      ],
    );
  }

  // Color preset button
  Widget _buildColorPreset(Color color) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }

  // Security control
  Widget _buildSecurityControl(Map<String, dynamic> device) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool isOpen = device['value'] == 'Aperto';

    return Column(
      children: [
        Icon(
          isOpen ? Icons.door_front_door : Icons.lock,
          size: 60,
          color: isOpen ? Colors.red : Colors.green,
        ),
        const SizedBox(height: 16),
        Text(
          isOpen ? 'Porta Aperta' : 'Porta Chiusa',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Ultima modifica: ${_formatFullDateTime(device['lastUpdate'] as DateTime)}',
          style: TextStyle(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        if (device['type'] == 'Sicurezza' &&
            device['name'].toString().contains('Porta'))
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.lock_open),
                  label: const Text('Sblocca'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.amber,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.lock),
                  label: const Text('Blocca'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  // Humidity info
  Widget _buildHumidityInfo(Map<String, dynamic> device) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: CircularProgressIndicator(
                value:
                    int.parse(device['value'].toString().replaceAll('%', '')) /
                        100,
                strokeWidth: 10,
                backgroundColor: Colors.blue.withOpacity(0.2),
                color: Colors.blue,
              ),
            ),
            Column(
              children: [
                Text(
                  device['value'] as String,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('Umidità'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildHumidityLevel('Bassa', '0-30%', false),
            _buildHumidityLevel('Media', '30-60%', false),
            _buildHumidityLevel('Alta', '60-100%', true),
          ],
        ),
      ],
    );
  }

  // Humidity level indicator
  Widget _buildHumidityLevel(String label, String range, bool isActive) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          width: 60,
          height: 30,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          range,
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // Detailed history chart
  Widget _buildDetailedHistoryChart(Map<String, dynamic> device) {
    final colorScheme = Theme.of(context).colorScheme;

    // Temperature or humidity data
    if (device['type'] == 'Temperatura' || device['type'] == 'Umidità') {
      final history = device['history'] as List<double>;
      return LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: colorScheme.outline.withOpacity(0.2),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 5,
                getTitlesWidget: (value, meta) {
                  if (value % 5 != 0) return const SizedBox();
                  return Text(
                    '${value.toInt()} min',
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(0),
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  );
                },
                reservedSize: 30,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(history.length, (index) {
                return FlSpot(index.toDouble(), history[index]);
              }),
              isCurved: true,
              curveSmoothness: 0.2,
              color: device['color'] as Color,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: (device['color'] as Color).withOpacity(0.2),
              ),
            ),
          ],
          minY: device['type'] == 'Temperatura' ? 20 : 50,
          maxY: device['type'] == 'Temperatura' ? 25 : 80,
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              // tooltipBgColor: colorScheme
              // .surfaceVariant, // Corretto da tooltipBackgroundColor
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((touchedSpot) {
                  return LineTooltipItem(
                    '${touchedSpot.y.toStringAsFixed(1)}${device['type'] == 'Temperatura' ? '°C' : '%'}',
                    TextStyle(color: colorScheme.onSurfaceVariant),
                  );
                }).toList();
              },
            ),
            handleBuiltInTouches: true,
          ),
        ),
      );
    }

    // Default empty chart
    return const Center(
      child: Text('Grafico non disponibile per questo dispositivo'),
    );
  }

  // Build Battery Indicator
  Widget _buildBatteryIndicator(int percentage) {
    final colorScheme = Theme.of(context).colorScheme;

    Color batteryColor;
    if (percentage > 60) {
      batteryColor = Colors.green;
    } else if (percentage > 20) {
      batteryColor = Colors.orange;
    } else {
      batteryColor = Colors.red;
    }

    return Row(
      children: [
        Icon(
          percentage <= 20
              ? Icons.battery_alert
              : percentage <= 30
                  ? Icons.battery_1_bar
                  : percentage <= 50
                      ? Icons.battery_2_bar
                      : percentage <= 80
                          ? Icons.battery_3_bar
                          : Icons.battery_full,
          size: 14,
          color: batteryColor,
        ),
        const SizedBox(width: 4),
        Text(
          '$percentage%',
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // Format full date time
  String _formatFullDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  // Format last seen time
  String _formatLastSeen(DateTime lastUpdate) {
    final now = DateTime.now();
    final difference = now.difference(lastUpdate);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m fa';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h fa';
    } else {
      return '${difference.inDays}g fa';
    }
  }

  // Build Analytics Tab
  Widget _buildAnalyticsTab() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analisi & Statistiche',
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Panoramica del consumo energetico e delle tendenze',
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Daily Energy Usage
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Consumo Energetico Giornaliero',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatToday(),
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: _buildHourlyEnergyChart(),
                  ),
                  const SizedBox(height: 16),
                  _buildAnalyticsSummary(),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Usage Patterns
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Modelli di Utilizzo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildUsagePatternsList(),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Device Energy Distribution
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Distribuzione Energetica',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: _buildEnergyDistributionChart(),
                  ),
                  const SizedBox(height: 16),
                  _buildEnergyDistributionLegend(),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Energy Savings
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Risparmio Energetico',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildWeeklySavingsChart(),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    'Consigli per il Risparmio',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSavingsTipsList(),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // Format today's date
  String _formatToday() {
    return DateFormat('EEEE, d MMMM yyyy', 'it_IT').format(DateTime.now());
  }

  // Hourly energy chart
  Widget _buildHourlyEnergyChart() {
    final colorScheme = Theme.of(context).colorScheme;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 5,
        minY: 0,
        groupsSpace: 12,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            // tooltipBgColor: colorScheme.surfaceVariant, // Corretto da tooltipBackgroundColor
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${group.x.toInt()}:00\n',
                TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '${rod.toY.toStringAsFixed(1)} kWh',
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                // Showing only even hours for clarity
                if (value.toInt() % 4 != 0) return const SizedBox();
                return Text(
                  '${value.toInt()}:00',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
                );
              },
              reservedSize: 28,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()} kWh',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
                );
              },
              reservedSize: 40,
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: colorScheme.outline.withOpacity(0.2),
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(24, (index) {
          // Different color for current hour
          final now = DateTime.now();
          final isCurrentHour = index == now.hour;

          // Generate consumption data with peaks in morning and evening
          double value;
          if (index >= 6 && index <= 9) {
            // Morning peak
            value = 2.0 + (1.5 * math.Random(index).nextDouble());
          } else if (index >= 17 && index <= 22) {
            // Evening peak
            value = 2.5 + (2.0 * math.Random(index).nextDouble());
          } else if (index >= 0 && index <= 5) {
            // Night low
            value = 0.2 + (0.5 * math.Random(index).nextDouble());
          } else {
            // Regular day
            value = 0.8 + (1.2 * math.Random(index).nextDouble());
          }

          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: value,
                color: isCurrentHour
                    ? colorScheme.primary
                    : colorScheme.primary.withOpacity(0.7),
                width: 16,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // Analytics summary
  Widget _buildAnalyticsSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildAnalyticItem(
          icon: Icons.trending_up,
          label: 'Picco',
          value: '4.2 kWh',
          info: '19:00',
        ),
        _buildAnalyticItem(
          icon: Icons.trending_down,
          label: 'Minimo',
          value: '0.3 kWh',
          info: '03:00',
        ),
        _buildAnalyticItem(
          icon: Icons.bar_chart,
          label: 'Media',
          value: '1.8 kWh',
          info: 'per ora',
        ),
        _buildAnalyticItem(
          icon: Icons.calculate,
          label: 'Totale',
          value: '18.5 kWh',
          info: 'oggi',
        ),
      ],
    );
  }

  // Analytics item
  Widget _buildAnalyticItem({
    required IconData icon,
    required String label,
    required String value,
    required String info,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Icon(icon, color: colorScheme.primary, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          info,
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // Usage patterns list
  Widget _buildUsagePatternsList() {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: _usagePatterns.map((pattern) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  pattern['day'].toString().substring(0, 3),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(pattern['pattern'] as String),
              ),
              Icon(
                Icons.info_outline,
                color: colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Energy distribution chart
  Widget _buildEnergyDistributionChart() {
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            value: 35,
            title: '35%',
            color: Colors.blue,
            radius: 60,
            titleStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            value: 25,
            title: '25%',
            color: Colors.orange,
            radius: 60,
            titleStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            value: 20,
            title: '20%',
            color: Colors.green,
            radius: 60,
            titleStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            value: 15,
            title: '15%',
            color: Colors.purple,
            radius: 60,
            titleStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            value: 5,
            title: '5%',
            color: Colors.grey,
            radius: 60,
            titleStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Energy distribution legend
  Widget _buildEnergyDistributionLegend() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              _buildLegendItem(
                color: Colors.blue,
                text: 'Riscaldamento',
              ),
              _buildLegendItem(
                color: Colors.orange,
                text: 'Elettrodomestici',
              ),
              _buildLegendItem(
                color: Colors.grey,
                text: 'Altro',
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              _buildLegendItem(
                color: Colors.green,
                text: 'Illuminazione',
              ),
              _buildLegendItem(
                color: Colors.purple,
                text: 'Intrattenimento',
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Legend item
  Widget _buildLegendItem({
    required Color color,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  // Weekly savings chart
  Widget _buildWeeklySavingsChart() {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 180,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 12,
          minY: 0,
          groupsSpace: 12,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              // tooltipBgColor: colorScheme.surfaceVariant, // Corretto da tooltipBackgroundColor
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${_getWeekday(group.x.toInt())}\n',
                  TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'Risparmio: ${rod.toY.toStringAsFixed(1)}%',
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    _getWeekdayShort(value.toInt()),
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  );
                },
                reservedSize: 28,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}%',
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  );
                },
                reservedSize: 40,
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 3,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: colorScheme.outline.withOpacity(0.2),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(7, (index) {
            // Create a list from the weekly savings map
            final day = _getWeekday(index);
            final value = _weeklyEnergySavings[day] ?? 0.0;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: value,
                  color: Colors.green.withOpacity(0.7),
                  width: 16,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // Savings tips list
  Widget _buildSavingsTipsList() {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        for (var tip in _energySavingTips)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.eco,
                  size: 16,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    tip['title'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  tip['savings'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // Build Automation Tab
  Widget _buildAutomationTab() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Automazioni',
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Gestisci le tue regole automatiche',
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Quick Actions
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Azioni Rapide',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Nuova Azione'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildQuickAutomationButton(
                        icon: Icons.home,
                        label: 'Tutto Acceso',
                        onTap: () {},
                      ),
                      _buildQuickAutomationButton(
                        icon: Icons.power_off,
                        label: 'Tutto Spento',
                        onTap: () {},
                      ),
                      _buildQuickAutomationButton(
                        icon: Icons.movie,
                        label: 'Modalità Cinema',
                        onTap: () {},
                      ),
                      _buildQuickAutomationButton(
                        icon: Icons.flight_takeoff,
                        label: 'Modalità Vacanza',
                        onTap: _toggleVacationMode,
                        isActive: _showVacationMode,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Active Automations
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Regole Attive',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _MockData.automations.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) => _buildAutomationItem(
                      _MockData.automations[index],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Create New Automation
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Crea Nuova Automazione',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Select Trigger
                  const Text(
                    'Se (condizione):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildTriggerChip(
                        icon: Icons.access_time,
                        label: 'Orario',
                      ),
                      _buildTriggerChip(
                        icon: Icons.device_thermostat,
                        label: 'Temperatura',
                      ),
                      _buildTriggerChip(
                        icon: Icons.motion_photos_on,
                        label: 'Movimento',
                      ),
                      _buildTriggerChip(
                        icon: Icons.water_drop,
                        label: 'Umidità',
                      ),
                      _buildTriggerChip(
                        icon: Icons.location_on,
                        label: 'Posizione',
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Select Action
                  const Text(
                    'Allora (azione):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildTriggerChip(
                        icon: Icons.lightbulb,
                        label: 'Luci',
                      ),
                      _buildTriggerChip(
                        icon: Icons.thermostat,
                        label: 'Termostato',
                      ),
                      _buildTriggerChip(
                        icon: Icons.notifications,
                        label: 'Notifica',
                      ),
                      _buildTriggerChip(
                        icon: Icons.power,
                        label: 'Presa',
                      ),
                      _buildTriggerChip(
                        icon: Icons.run_circle,
                        label: 'Scenario',
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Crea Automazione'),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Automation Templates
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Template Predefiniti',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildAutomationTemplateList(),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // Automation template list
  Widget _buildAutomationTemplateList() {
    final colorScheme = Theme.of(context).colorScheme;

    final templates = [
      {
        'name': 'Luci al tramonto',
        'description': 'Accendi le luci quando il sole tramonta',
        'icon': Icons.wb_twilight,
      },
      {
        'name': 'Riscaldamento intelligente',
        'description': 'Regola temperatura in base alla presenza',
        'icon': Icons.thermostat,
      },
      {
        'name': 'Modalità notte',
        'description': 'Spegni i dispositivi non essenziali di notte',
        'icon': Icons.nightlight,
      },
      {
        'name': 'Rilevamento perdite',
        'description': 'Notifica se viene rilevata una perdita d\'acqua',
        'icon': Icons.opacity,
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: templates.length,
      itemBuilder: (context, index) {
        final template = templates[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          color: colorScheme.surfaceVariant.withOpacity(0.5),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: colorScheme.primary.withOpacity(0.2),
              child: Icon(
                template['icon'] as IconData,
                color: colorScheme.primary,
              ),
            ),
            title: Text(
              template['name'] as String,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(template['description'] as String),
            trailing: OutlinedButton(
              onPressed: () {},
              child: const Text('Usa'),
            ),
          ),
        );
      },
    );
  }

  // Quick automation button
  Widget _buildQuickAutomationButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color:
                  isActive ? colorScheme.primary : colorScheme.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive
                  ? colorScheme.onPrimary
                  : colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? colorScheme.primary : colorScheme.onSurface,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // Build Automation Item
  Widget _buildAutomationItem(Map<String, dynamic> automation) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Modifica',
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Elimina',
          ),
        ],
      ),
      child: SwitchListTile(
        title: Text(
          automation['name'] as String,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(automation['description'] as String),
        secondary: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(
            automation['icon'] as IconData,
            color: colorScheme.primary,
          ),
        ),
        value: automation['active'] as bool,
        onChanged: (value) {
          setState(() {
            automation['active'] = value;
          });
        },
      ),
    );
  }

  // Build Trigger Chip
  Widget _buildTriggerChip({
    required IconData icon,
    required String label,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return FilterChip(
      selected: false,
      showCheckmark: false,
      avatar: Icon(
        icon,
        size: 18,
        color: colorScheme.primary,
      ),
      label: Text(label),
      onSelected: (selected) {},
    );
  }
}
