import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'package:iot_cloud_flutter/src/core/routes/router.gr.dart';
import 'package:iot_cloud_flutter/src/core/widgets/app_drawer.dart';
import 'package:iot_cloud_flutter/src/features/dashboard/presentation/widgets/draggable_widget.dart';

// Models and utilities
// -----------------------------------------

/// Data model for widget
class WidgetData {
  final String type;
  final String id;
  Map<String, dynamic> properties;
  double x;
  double y;
  double width;
  double height;

  WidgetData({
    required this.type,
    required this.id,
    this.properties = const {},
    this.x = 0.0,
    this.y = 0.0,
    this.width = 150.0,
    this.height = 120.0,
  });

  /// Returns the rectangle occupied by the widget
  Rect get rect => Rect.fromLTWH(x, y, width, height);

  /// Checks if this widget overlaps with another
  bool overlaps(WidgetData other) {
    return rect.overlaps(other.rect);
  }

  /// Creates a clone with a new ID
  WidgetData cloneWithNewId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return WidgetData(
      type: type,
      id: '${type}_$timestamp',
      properties: Map<String, dynamic>.from(properties),
      x: x,
      y: y,
      width: width,
      height: height,
    );
  }
}

/// Utility to calculate widget dimensions
class WidgetSizeCalculator {
  // Size cache
  static final Map<String, Size> _cachedSizes = {};

  /// Default widget sizes
  static final Map<String, Size> defaultSizes = {
    'switch': Size(100, 80),
    'temperature': Size(140, 100),
    'dimmer': Size(140, 140),
    'pushbutton': Size(100, 100),
    'slider': Size(220, 120),
    'stepper': Size(140, 80),
    'timepicker': Size(200, 140),
    'messenger': Size(240, 160),
    'color': Size(160, 160),
    'coloredlight': Size(160, 180),
    'value': Size(100, 80),
    'status': Size(100, 80),
    'gauge': Size(160, 120),
    'percentage': Size(120, 120),
    'led': Size(80, 80),
    'map': Size(240, 180),
    'advancedmap': Size(240, 180),
    'chart': Size(280, 180),
    'advancedchart': Size(280, 200),
    'scheduler': Size(200, 160),
    'stickynote': Size(180, 120),
    'valueselector': Size(200, 100),
    'valuedropdown': Size(160, 80),
    'image': Size(160, 160),
  };

  /// Get a widget's size, using cached measurement if available
  static Future<Size> getWidgetSize(
    BuildContext context,
    String widgetType,
    Widget Function() widgetBuilder, {
    double gridSize = 20.0,
  }) async {
    // Use cached size if available
    if (_cachedSizes.containsKey(widgetType)) {
      return _cachedSizes[widgetType]!;
    }

    // Fallback to default size
    final defaultSize = defaultSizes[widgetType] ?? Size(140, 120);

    try {
      // Use a timeout to prevent hanging
      final result = await Future.any([
        _measureWidget(context, widgetType, widgetBuilder),
        Future.delayed(Duration(milliseconds: 300), () => defaultSize),
      ]);

      _cachedSizes[widgetType] = result;
      return result;
    } catch (e) {
      debugPrint('Error measuring widget: $e');
      return defaultSize;
    }
  }

  /// Actual measurement logic
  static Future<Size> _measureWidget(
    BuildContext context,
    String widgetType,
    Widget Function() widgetBuilder,
  ) async {
    // Implementation omitted for brevity - would measure actual widget dimensions
    return defaultSizes[widgetType] ?? Size(140, 120);
  }
}

// Widget Components
// -----------------------------------------

/// Preview widget for the palette
class WidgetPreview extends StatelessWidget {
  final Widget child;
  final String label;

  const WidgetPreview({super.key, required this.child, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[700]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SizedBox(
        width: 120,
        height: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with title
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.drag_indicator,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Widget content
            Expanded(child: Center(child: child)),
          ],
        ),
      ),
    );
  }
}

// Dashboard Screen Implementation
// -----------------------------------------

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Dashboard widgets and state
  final List<WidgetData> dashboardWidgets = [];
  final Map<String, dynamic> _controllers = {};

  // Widget interaction state
  WidgetData? draggingWidget;
  WidgetData? resizingWidget;
  Offset? ghostPosition;
  bool isValidPosition = true;

  // Layout management
  final GlobalKey _dashboardKey = GlobalKey();
  Size _dashboardSize = Size.zero;
  double _maxDashboardHeight = 1000;
  final ScrollController _scrollController = ScrollController();
  final double gridSize = 20.0;

  // Resize state
  Offset? _resizeStartPoint;
  Size? _originalSize;
  bool _isValidResize = true;

  // Widget measurement
  final Map<String, Size> _minimumWidgetSizes = {};
  bool _measurementsReady = false;

  // Demo state values
  final Random random = Random();
  // Switch
  bool switchValue = true;
  // Push Button
  bool pushButtonValue = false;
  // Temperature
  double temperatureValue = 23.5;
  // Dimmer
  double dimmerValue = 0.5;
  bool lightIsOn = false;
  // Slider
  double sliderValue = 50.0;
  // Stepper
  int stepperValue = 5;
  // Time Picker
  DateTime timepickerValue = DateTime.now();
  // Messenger
  List<String> messengerMessages = ["Ciao, come posso aiutarti?"];
  // Color
  Color colorValue = Colors.red;
  // LED
  bool ledValue = true;
  // Map
  LatLng locationValue = LatLng(45.464664, 9.188540); // Milan
  // Gauge
  double gaugeValue = 45.0;
  // Percentage
  double percentageValue = 75.0;
  // Chart data
  final List<double> chartData = [23, 26, 25, 24, 22, 26, 28, 30, 29, 22];
  // Advanced chart data
  final List<List<double>> advancedChartData = [
    [23, 26, 25, 24, 22],
    [26, 28, 30, 29, 22],
  ];
  // Scheduler
  bool schedulerActive = false;
  String schedulerTime = "08:00";
  List<String> schedulerDays = ["Lun", "Mer", "Ven"];
  // Sticky Note
  String stickyNoteValue = "Appunti importanti";
  // Value Selector
  int valueSelectorValue = 1;
  List<String> valueSelectorOptions = ["Opzione 1", "Opzione 2", "Opzione 3"];
  // Value Dropdown
  String valueDropdownValue = "Opzione 1";
  List<String> valueDropdownOptions = ["Opzione 1", "Opzione 2", "Opzione 3"];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureAllWidgets();
    });
  }

  @override
  void dispose() {
    // Dispose all controllers
    _controllers.forEach((_, controller) {
      if (controller is TextEditingController) {
        controller.dispose();
      } else if (controller is ScrollController) {
        controller.dispose();
      }
    });
    _scrollController.dispose();
    super.dispose();
  }

  // Widget measurement
  // -----------------------------------------

  /// Measure all widget types for precise sizing
  Future<void> _measureAllWidgets() async {
    await Future.delayed(Duration.zero);

    // Measure each widget type
    await Future.wait(
      WidgetSizeCalculator.defaultSizes.keys.map(
        (type) => _measureWidgetSize(type),
      ),
    );

    setState(() {
      _measurementsReady = true;
    });
  }

  /// Measure a single widget type
  Future<void> _measureWidgetSize(String widgetType) async {
    Widget Function() widgetBuilder;

    // Widget builder based on type
    switch (widgetType) {
      case 'switch':
        widgetBuilder = () => Switch(value: false, onChanged: (_) {});
        break;
      case 'temperature':
        widgetBuilder =
            () => _buildTemperatureIndicator(
              temperature: 23.5,
              minTemp: 0,
              maxTemp: 40,
            );
        break;
      case 'dimmer':
        widgetBuilder =
            () => _buildDimmerIndicator(
              value: 0.5,
              isOn: true,
              onValueChanged: (_) {},
              onToggle: (_) {},
            );
        break;
      case 'pushbutton':
        widgetBuilder =
            () => _buildPushButton(isPressed: false, onChanged: (_) {});
        break;
      case 'slider':
        widgetBuilder =
            () => _buildSlider(value: 50, min: 0, max: 100, onChanged: (_) {});
        break;
      // Add other widget builders
      default:
        return;
    }

    // Get the widget size
    final size = await WidgetSizeCalculator.getWidgetSize(
      context,
      widgetType,
      widgetBuilder,
      gridSize: gridSize,
    );

    _minimumWidgetSizes[widgetType] = size;
  }

  /// Get the minimum size for a widget type
  Size _getMinimumWidgetSize(String widgetType) {
    // Use measured size if available
    if (_minimumWidgetSizes.containsKey(widgetType)) {
      return _minimumWidgetSizes[widgetType]!;
    }

    // Otherwise use default
    return WidgetSizeCalculator.defaultSizes[widgetType] ?? Size(140, 120);
  }

  // Layout utilities
  // -----------------------------------------

  /// Snap a value to the grid
  double _snapToGrid(double value) {
    return (value / gridSize).round() * gridSize;
  }

  /// Calculate the maximum dashboard height
  void _calculateMaxDashboardHeight() {
    if (dashboardWidgets.isEmpty) {
      _maxDashboardHeight = max(_dashboardSize.height, 1000);
      return;
    }

    // Find the lowest widget
    double lowestPoint = 0;
    for (var widget in dashboardWidgets) {
      final bottomY = widget.y + widget.height;
      if (bottomY > lowestPoint) {
        lowestPoint = bottomY;
      }
    }

    // Add space below the lowest widget
    _maxDashboardHeight = max(lowestPoint + 200, _dashboardSize.height);
  }

  /// Check if a rectangle overlaps with any widget
  bool _checkForOverlap(Rect rect, {String? excludeId}) {
    for (var widget in dashboardWidgets) {
      if (excludeId != null && widget.id == excludeId) {
        continue;
      }

      if (widget.rect.overlaps(rect)) {
        return true;
      }
    }
    return false;
  }

  /// Find a valid position for a widget
  Offset _findValidPosition(
    double x,
    double y,
    double width,
    double height, {
    String? excludeId,
  }) {
    // Try with snap to grid first
    final snappedX = _snapToGrid(max(0, x));
    final snappedY = _snapToGrid(max(0, y));

    // Check if valid
    final rect = Rect.fromLTWH(snappedX, snappedY, width, height);
    if (!_checkForOverlap(rect, excludeId: excludeId)) {
      return Offset(snappedX, snappedY);
    }

    // Search in spiral pattern
    const directions = [
      [0, -1],
      [1, -1],
      [1, 0],
      [1, 1],
      [0, 1],
      [-1, 1],
      [-1, 0],
      [-1, -1],
    ];

    int distance = 1;
    const maxDistance = 20;

    while (distance <= maxDistance) {
      for (var dir in directions) {
        final newX = max(0, snappedX + dir[0] * distance * gridSize);
        final newY = max(0, snappedY + dir[1] * distance * gridSize);

        // Check horizontal limits
        if (newX + width > _dashboardSize.width) {
          continue;
        }

        final newRect = Rect.fromLTWH(
          newX.toDouble(),
          newY.toDouble(),
          width,
          height,
        );

        if (!_checkForOverlap(newRect, excludeId: excludeId)) {
          return Offset(newX.toDouble(), newY.toDouble());
        }
      }
      distance++;
    }

    // If no valid position, place at bottom
    double maxY = 0;
    for (var widget in dashboardWidgets) {
      maxY = max(maxY, widget.y + widget.height);
    }

    return Offset(_snapToGrid(x), _snapToGrid(maxY + gridSize));
  }

  // Widget simulators
  // -----------------------------------------

  /// Simulate temperature updates for a widget
  void _simulateTemperatureUpdates(WidgetData widget) {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      setState(() {
        final index = dashboardWidgets.indexWhere((w) => w.id == widget.id);
        if (index == -1) return;

        final currentTemp = widget.properties['temperature'] as double;
        final newTemp = currentTemp + (random.nextDouble() - 0.5);

        dashboardWidgets[index].properties['temperature'] = newTemp;
      });

      _simulateTemperatureUpdates(widget);
    });
  }

  // Main build method
  // -----------------------------------------

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while measuring
    if (!_measurementsReady) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          backgroundColor: const Color(0xFF26212E),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                "Calibrazione dei widget in corso...",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    // Main dashboard layout
    return Scaffold(
      appBar: AppBar(
        title: const Text("IoT Cloud Dashboard"),
        backgroundColor: const Color(0xFF26212E),
      ),
      drawer: AppDrawer(
        menuItems: [
          AppDrawerItem(
            title: "Dashboard",
            icon: Icons.dashboard,
            routeInfo: const DashboardRoute(),
          ),
          AppDrawerItem(
            title: "Dispositivi",
            icon: Icons.devices,
            routeInfo: const IotDeviceRoute(),
          ),
        ],
        header: AppDrawerHeader(
          userName: "Utente IoT",
          userEmail: "user@example.com",
        ),
      ),
      body: Column(
        children: [
          // Widget palette
          _buildWidgetPalette(),

          // Dashboard area with grid
          Expanded(child: _buildDashboardArea()),
        ],
      ),
    );
  }

  // UI Components
  // -----------------------------------------

  /// Build the widget palette
  Widget _buildWidgetPalette() {
    return Container(
      height: 110,
      color: const Color(0xFF1A1A1A),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Text(
            "Widget:",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),

          // Scrollable palette
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                // 1. Switch widget
                _buildDraggablePaletteItem(
                  type: 'switch',
                  label: 'Interruttore',
                  properties: {
                    'value': switchValue,
                    'label': 'Interruttore',
                    'deviceId': 'dev001',
                  },
                  previewChild: Switch(
                    value: switchValue,
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                      });
                    },
                  ),
                ),

                // 2. Push Button widget
                _buildDraggablePaletteItem(
                  type: 'pushbutton',
                  label: 'Pulsante',
                  properties: {
                    'value': pushButtonValue,
                    'label': 'Pulsante',
                    'deviceId': 'btn001',
                  },
                  previewChild: _buildPushButton(
                    isPressed: pushButtonValue,
                    onChanged: (value) {
                      setState(() {
                        pushButtonValue = value;
                      });
                    },
                  ),
                ),

                // 3. Temperature widget
                _buildDraggablePaletteItem(
                  type: 'temperature',
                  label: 'Temperatura',
                  properties: {
                    'temperature': temperatureValue,
                    'label': 'Temperatura',
                    'deviceId': 'temp001',
                    'minTemp': 0.0,
                    'maxTemp': 40.0,
                  },
                  previewChild: _buildTemperatureIndicator(
                    temperature: temperatureValue,
                    minTemp: 0,
                    maxTemp: 40,
                  ),
                ),

                // 4. Slider widget
                _buildDraggablePaletteItem(
                  type: 'slider',
                  label: 'Slider',
                  properties: {
                    'value': sliderValue,
                    'label': 'Slider',
                    'deviceId': 'slide001',
                    'min': 0.0,
                    'max': 100.0,
                  },
                  previewChild: Icon(Icons.tune, color: Colors.white, size: 24),
                ),

                // 5. Stepper widget
                _buildDraggablePaletteItem(
                  type: 'stepper',
                  label: 'Stepper',
                  properties: {
                    'value': stepperValue,
                    'label': 'Stepper',
                    'deviceId': 'step001',
                    'min': 0,
                    'max': 10,
                  },
                  previewChild: Icon(
                    Icons.exposure,
                    color: Colors.white,
                    size: 24,
                  ),
                ),

                // 6. Dimmer widget
                _buildDraggablePaletteItem(
                  type: 'dimmer',
                  label: 'Dimmer',
                  properties: {
                    'value': dimmerValue,
                    'isOn': lightIsOn,
                    'label': 'Dimmer',
                    'deviceId': 'light001',
                  },
                  previewChild: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          lightIsOn
                              ? Colors.amber.withOpacity(dimmerValue)
                              : Colors.grey[800],
                    ),
                    child: Icon(Icons.lightbulb, color: Colors.white, size: 24),
                  ),
                ),

                // 7. Time Picker widget
                _buildDraggablePaletteItem(
                  type: 'timepicker',
                  label: 'Ora',
                  properties: {
                    'dateTime': timepickerValue.millisecondsSinceEpoch,
                    'label': 'Ora',
                    'deviceId': 'time001',
                  },
                  previewChild: Icon(
                    Icons.access_time,
                    color: Colors.white,
                    size: 24,
                  ),
                ),

                // 8. Messenger widget
                _buildDraggablePaletteItem(
                  type: 'messenger',
                  label: 'Messaggio',
                  properties: {
                    'messages': messengerMessages,
                    'label': 'Messaggio',
                    'deviceId': 'msg001',
                  },
                  previewChild: Icon(
                    Icons.message,
                    color: Colors.white,
                    size: 24,
                  ),
                ),

                // 9. Color widget
                _buildDraggablePaletteItem(
                  type: 'color',
                  label: 'Colore',
                  properties: {
                    'color': colorValue.value,
                    'label': 'Colore',
                    'deviceId': 'col001',
                  },
                  previewChild: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                ),

                // 10. Colored Light widget
                _buildDraggablePaletteItem(
                  type: 'coloredlight',
                  label: 'Luce Colorata',
                  properties: {
                    'color': Colors.blue.value,
                    'isOn': true,
                    'label': 'Luce Colorata',
                    'deviceId': 'clight001',
                  },
                  previewChild: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Icon(Icons.lightbulb, color: Colors.white, size: 20),
                  ),
                ),

                // 11. Value widget
                _buildDraggablePaletteItem(
                  type: 'value',
                  label: 'Valore',
                  properties: {
                    'value': "42",
                    'label': 'Valore',
                    'deviceId': 'val001',
                  },
                  previewChild: _buildValueDisplay(value: "42"),
                ),

                // 12. Status widget
                _buildDraggablePaletteItem(
                  type: 'status',
                  label: 'Stato',
                  properties: {
                    'isActive': true,
                    'label': 'Stato',
                    'deviceId': 'stat001',
                  },
                  previewChild: _buildStatusIndicator(isActive: true),
                ),

                // 13. Gauge widget
                _buildDraggablePaletteItem(
                  type: 'gauge',
                  label: 'Gauge',
                  properties: {
                    'value': gaugeValue,
                    'min': 0.0,
                    'max': 100.0,
                    'label': 'Gauge',
                    'deviceId': 'gauge001',
                  },
                  previewChild: Icon(
                    Icons.speed,
                    color: Colors.white,
                    size: 24,
                  ),
                ),

                // 14. Percentage widget
                _buildDraggablePaletteItem(
                  type: 'percentage',
                  label: 'Percentuale',
                  properties: {
                    'value': percentageValue,
                    'label': 'Percentuale',
                    'deviceId': 'perc001',
                  },
                  previewChild: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue, width: 3),
                    ),
                    child: Center(
                      child: Text(
                        "%",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                // 15. LED widget
                _buildDraggablePaletteItem(
                  type: 'led',
                  label: 'LED',
                  properties: {
                    'isOn': ledValue,
                    'label': 'LED',
                    'deviceId': 'led001',
                  },
                  previewChild: _buildLedIndicator(isOn: ledValue),
                ),

                // 16. Map widget
                _buildDraggablePaletteItem(
                  type: 'map',
                  label: 'Mappa',
                  properties: {
                    'latitude': locationValue.latitude,
                    'longitude': locationValue.longitude,
                    'label': 'Mappa',
                    'deviceId': 'map001',
                  },
                  previewChild: Icon(Icons.map, color: Colors.white, size: 24),
                ),

                // 17. Advanced Map widget
                _buildDraggablePaletteItem(
                  type: 'advancedmap',
                  label: 'Mappa Avanzata',
                  properties: {
                    'locations': [
                      {
                        'latitude': locationValue.latitude,
                        'longitude': locationValue.longitude,
                        'timestamp': DateTime.now().millisecondsSinceEpoch,
                      },
                      {
                        'latitude': locationValue.latitude + 0.001,
                        'longitude': locationValue.longitude + 0.001,
                        'timestamp':
                            DateTime.now().millisecondsSinceEpoch + 60000,
                      },
                    ],
                    'label': 'Mappa Avanzata',
                    'deviceId': 'admap001',
                  },
                  previewChild: Icon(
                    Icons.location_history,
                    color: Colors.white,
                    size: 24,
                  ),
                ),

                // 18. Chart widget
                _buildDraggablePaletteItem(
                  type: 'chart',
                  label: 'Grafico',
                  properties: {
                    'data': chartData,
                    'label': 'Grafico',
                    'deviceId': 'chart001',
                  },
                  previewChild: Icon(
                    Icons.show_chart,
                    color: Colors.white,
                    size: 24,
                  ),
                ),

                // 19. Advanced Chart widget
                _buildDraggablePaletteItem(
                  type: 'advancedchart',
                  label: 'Grafico Avanzato',
                  properties: {
                    'dataSeries': advancedChartData,
                    'labels': ["Serie 1", "Serie 2"],
                    'label': 'Grafico Avanzato',
                    'deviceId': 'adchart001',
                  },
                  previewChild: Icon(
                    Icons.stacked_line_chart,
                    color: Colors.white,
                    size: 24,
                  ),
                ),

                // 20. Scheduler widget
                _buildDraggablePaletteItem(
                  type: 'scheduler',
                  label: 'Pianificazione',
                  properties: {
                    'isActive': schedulerActive,
                    'scheduleTime': schedulerTime,
                    'scheduleDays': schedulerDays,
                    'label': 'Pianificazione',
                    'deviceId': 'sched001',
                  },
                  previewChild: Icon(
                    Icons.schedule,
                    color: Colors.white,
                    size: 24,
                  ),
                ),

                // 21. Sticky Note widget
                _buildDraggablePaletteItem(
                  type: 'stickynote',
                  label: 'Nota',
                  properties: {'content': stickyNoteValue, 'label': 'Nota'},
                  previewChild: Icon(
                    Icons.sticky_note_2,
                    color: Colors.white,
                    size: 24,
                  ),
                ),

                // 22. Value Selector widget
                _buildDraggablePaletteItem(
                  type: 'valueselector',
                  label: 'Selettore',
                  properties: {
                    'options': valueSelectorOptions,
                    'selectedIndex': valueSelectorValue,
                    'label': 'Selettore',
                    'deviceId': 'select001',
                  },
                  previewChild: Icon(
                    Icons.touch_app,
                    color: Colors.white,
                    size: 24,
                  ),
                ),

                // 23. Value Dropdown widget
                _buildDraggablePaletteItem(
                  type: 'valuedropdown',
                  label: 'Menu a tendina',
                  properties: {
                    'options': valueDropdownOptions,
                    'selectedValue': valueDropdownValue,
                    'label': 'Menu a tendina',
                    'deviceId': 'dropdown001',
                  },
                  previewChild: Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.white,
                    size: 24,
                  ),
                ),

                // 24. Image widget
                _buildDraggablePaletteItem(
                  type: 'image',
                  label: 'Immagine',
                  properties: {
                    'imageUrl': 'https://www.example.com/image.jpg',
                    'label': 'Immagine',
                  },
                  previewChild: Icon(
                    Icons.image,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build the dashboard area with grid
  Widget _buildDashboardArea() {
    return LayoutBuilder(
      builder: (context, constraints) {
        _dashboardSize = Size(constraints.maxWidth, constraints.maxHeight);
        _calculateMaxDashboardHeight();

        return Stack(
          children: [
            // Background grid
            CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: GridPainter(gridSize: gridSize),
            ),

            // Scrollable dashboard
            SingleChildScrollView(
              controller: _scrollController,
              child: Stack(
                key: _dashboardKey,
                children: [
                  // Size container
                  SizedBox(
                    width: _dashboardSize.width,
                    height: _maxDashboardHeight,
                  ),

                  // Placed widgets
                  ...dashboardWidgets.map(
                    (widget) => _buildDashboardWidget(widget),
                  ),

                  // Ghost widget during drag
                  if (draggingWidget != null && ghostPosition != null)
                    Positioned(
                      left: ghostPosition!.dx,
                      top: ghostPosition!.dy,
                      child: Container(
                        width: draggingWidget!.width,
                        height: draggingWidget!.height,
                        decoration: BoxDecoration(
                          color:
                              isValidPosition
                                  ? Colors.blue.withOpacity(0.3)
                                  : Colors.red.withOpacity(0.3),
                          border: Border.all(
                            width: 2,
                            color: isValidPosition ? Colors.blue : Colors.red,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(
                            isValidPosition ? Icons.add_circle : Icons.block,
                            color: isValidPosition ? Colors.blue : Colors.red,
                            size: 24,
                          ),
                        ),
                      ),
                    ),

                  // Drop area for new widgets
                  Positioned.fill(
                    child: DragTarget<WidgetData>(
                      builder: (context, candidateData, rejectedData) {
                        return dashboardWidgets.isEmpty &&
                                draggingWidget == null
                            ? Center(
                              child: Text(
                                'Trascina qui i widget dalla palette',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 16,
                                ),
                              ),
                            )
                            : const SizedBox.expand();
                      },
                      onWillAcceptWithDetails: (data) => true,
                      onAcceptWithDetails:
                          (details) => _handleDragAccept(details),
                      onMove: (details) => _handleDragMove(details),
                      onLeave: (_) {
                        setState(() {
                          draggingWidget = null;
                          ghostPosition = null;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  /// Build a draggable palette item
  Widget _buildDraggablePaletteItem({
    required String type,
    required String label,
    required Map<String, dynamic> properties,
    required Widget previewChild,
  }) {
    // Get widget size
    final size = _getMinimumWidgetSize(type);

    return DraggableWidget<WidgetData>(
      data: WidgetData(
        type: type,
        id: '${type}_template',
        properties: properties,
        width: size.width,
        height: size.height,
      ),
      child: WidgetPreview(label: label, child: previewChild),
      onDragStarted: () {
        debugPrint('Drag $type started');
      },
      onDragEnd: (details) {
        debugPrint('Drag $type ended');
      },
    );
  }

  /// Build a widget in the dashboard
  Widget _buildDashboardWidget(WidgetData widget) {
    return Positioned(
      key: ValueKey(widget.id),
      left: widget.x,
      top: widget.y,
      child: GestureDetector(
        // Handle dragging
        onPanStart: (_) {
          setState(() {
            draggingWidget = widget;
            ghostPosition = Offset(widget.x, widget.y);
            isValidPosition = true;
          });
        },
        onPanUpdate: (details) => _handleWidgetDrag(widget, details),
        onPanEnd: (_) => _handleWidgetDragEnd(widget),

        child: Stack(
          children: [
            // Widget container
            Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color:
                      resizingWidget?.id == widget.id
                          ? (_isValidResize ? Colors.blue : Colors.red)
                          : Colors.grey[700]!,
                  width: resizingWidget?.id == widget.id ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header with handle and close button
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.drag_indicator,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  widget.properties['label'] ?? 'Widget',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              dashboardWidgets.removeWhere(
                                (w) => w.id == widget.id,
                              );
                              _calculateMaxDashboardHeight();
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Widget content
                  Expanded(child: Center(child: _buildWidgetContent(widget))),
                ],
              ),
            ),

            // Resize handle
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onPanStart: (details) => _handleResizeStart(widget, details),
                onPanUpdate: (details) => _handleResizeUpdate(widget, details),
                onPanEnd: (_) => _handleResizeEnd(),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color:
                        resizingWidget?.id == widget.id
                            ? (_isValidResize ? Colors.blue : Colors.red)
                            : Colors.grey[700],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(7),
                    ),
                  ),
                  child: const Icon(
                    Icons.drag_handle,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Event handlers
  // -----------------------------------------

  /// Handle widget drag acceptance
  void _handleDragAccept(DragTargetDetails<WidgetData> details) {
    final renderBox =
        _dashboardKey.currentContext!.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(details.offset);

    // Clone the widget
    final newWidget = details.data.cloneWithNewId();

    // Apply minimum size
    final minSize = _getMinimumWidgetSize(newWidget.type);
    newWidget.width = max(newWidget.width, minSize.width);
    newWidget.height = max(newWidget.height, minSize.height);

    // Position at drop location
    newWidget.x = localPosition.dx - (newWidget.width / 2);
    newWidget.y = localPosition.dy - (newWidget.height / 2);

    // Find valid position
    final validPosition = _findValidPosition(
      newWidget.x,
      newWidget.y,
      newWidget.width,
      newWidget.height,
    );

    newWidget.x = validPosition.dx;
    newWidget.y = validPosition.dy;

    // Simulate temperature updates for temperature widgets
    if (newWidget.type == 'temperature') {
      newWidget.properties['temperature'] =
          temperatureValue + (random.nextDouble() * 6 - 3);
      _simulateTemperatureUpdates(newWidget);
    }

    setState(() {
      dashboardWidgets.add(newWidget);
      _calculateMaxDashboardHeight();
      draggingWidget = null;
      ghostPosition = null;
    });
  }

  /// Handle widget drag move
  void _handleDragMove(DragTargetDetails<WidgetData> details) {
    final renderBox =
        _dashboardKey.currentContext!.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(details.offset);

    setState(() {
      // Store dragging widget
      if (draggingWidget == null) {
        draggingWidget = details.data.cloneWithNewId();

        // Apply minimum size
        final minSize = _getMinimumWidgetSize(draggingWidget!.type);
        draggingWidget!.width = max(draggingWidget!.width, minSize.width);
        draggingWidget!.height = max(draggingWidget!.height, minSize.height);
      }

      // Calculate widget position
      final widgetX = localPosition.dx - (draggingWidget!.width / 2);
      final widgetY = localPosition.dy - (draggingWidget!.height / 2);

      // Check if position is valid
      final rect = Rect.fromLTWH(
        _snapToGrid(max(0, widgetX)),
        _snapToGrid(max(0, widgetY)),
        draggingWidget!.width,
        draggingWidget!.height,
      );

      isValidPosition = !_checkForOverlap(rect);

      if (isValidPosition) {
        // Use snapped position
        ghostPosition = Offset(
          _snapToGrid(max(0, widgetX)),
          _snapToGrid(max(0, widgetY)),
        );
      } else {
        ghostPosition ??= _findValidPosition(
          widgetX,
          widgetY,
          draggingWidget!.width,
          draggingWidget!.height,
        );
      }
    });
  }

  /// Handle widget dragging
  void _handleWidgetDrag(WidgetData widget, DragUpdateDetails details) {
    if (resizingWidget != null) return;

    final newX = max(0, widget.x + details.delta.dx);
    final newY = max(0, widget.y + details.delta.dy);

    setState(() {
      widget.x = newX.toDouble();
      widget.y = newY.toDouble();

      // Check if new position is valid
      final snappedX = _snapToGrid(newX.toDouble());
      final snappedY = _snapToGrid(newY.toDouble());
      final rect = Rect.fromLTWH(
        snappedX,
        snappedY,
        widget.width,
        widget.height,
      );

      isValidPosition = !_checkForOverlap(rect, excludeId: widget.id);

      // Update ghost position
      if (isValidPosition) {
        ghostPosition = Offset(snappedX, snappedY);
      }
    });
  }

  /// Handle widget drag end
  void _handleWidgetDragEnd(WidgetData widget) {
    if (resizingWidget != null) return;

    if (ghostPosition != null) {
      setState(() {
        widget.x = ghostPosition!.dx;
        widget.y = ghostPosition!.dy;

        draggingWidget = null;
        ghostPosition = null;

        _calculateMaxDashboardHeight();
      });
    }
  }

  /// Handle resize start
  void _handleResizeStart(WidgetData widget, DragStartDetails details) {
    setState(() {
      resizingWidget = widget;
      _resizeStartPoint = details.globalPosition;
      _originalSize = Size(widget.width, widget.height);
      _isValidResize = true;
    });
  }

  /// Handle resize update
  void _handleResizeUpdate(WidgetData widget, DragUpdateDetails details) {
    if (resizingWidget?.id != widget.id) return;

    final delta = details.globalPosition - _resizeStartPoint!;

    // Get minimum size
    final minSize = _getMinimumWidgetSize(widget.type);

    // Calculate new dimensions with snap
    final newWidth = max(
      minSize.width,
      _snapToGrid(_originalSize!.width + delta.dx),
    );
    final newHeight = max(
      minSize.height,
      _snapToGrid(_originalSize!.height + delta.dy),
    );

    // Limit to screen width
    final limitedWidth = min(
      newWidth.toDouble(),
      _dashboardSize.width - widget.x,
    );

    // Check for overlap
    final newRect = Rect.fromLTWH(
      widget.x,
      widget.y,
      limitedWidth,
      newHeight.toDouble(),
    );

    // Check if new size causes overlap
    bool wouldOverlap = false;
    if (limitedWidth > widget.width || newHeight > widget.height) {
      wouldOverlap = _checkForOverlap(newRect, excludeId: widget.id);
    }

    setState(() {
      // Update resize validity
      _isValidResize = !wouldOverlap;

      // Apply new dimensions if valid
      if (!wouldOverlap) {
        widget.width = limitedWidth;
        widget.height = newHeight.toDouble();
      }
    });
  }

  /// Handle resize end
  void _handleResizeEnd() {
    setState(() {
      resizingWidget = null;
      _resizeStartPoint = null;
      _originalSize = null;
      _isValidResize = true;
      _calculateMaxDashboardHeight();
    });
  }

  // Widget content builders
  // -----------------------------------------

  /// Build widget content based on type
  Widget _buildWidgetContent(WidgetData data) {
    switch (data.type) {
      case 'switch':
        return Switch(
          value: data.properties['value'] ?? false,
          onChanged: (value) {
            setState(() {
              data.properties['value'] = value;
              final deviceId = data.properties['deviceId'];
              debugPrint('Dispositivo $deviceId impostato a $value');
            });
          },
          activeColor: Colors.greenAccent,
        );

      case 'temperature':
        return _buildTemperatureIndicator(
          temperature: data.properties['temperature'] ?? 20.0,
          minTemp: data.properties['minTemp'] ?? 0.0,
          maxTemp: data.properties['maxTemp'] ?? 40.0,
        );

      case 'dimmer':
        return _buildDimmerIndicator(
          value: data.properties['value'] ?? 0.5,
          isOn: data.properties['isOn'] ?? false,
          onValueChanged: (value) {
            setState(() {
              data.properties['value'] = value;
              data.properties['isOn'] = true;
            });
          },
          onToggle: (isOn) {
            setState(() {
              data.properties['isOn'] = isOn;
            });
          },
        );

      case 'pushbutton':
        return _buildPushButton(
          isPressed: data.properties['value'] ?? false,
          onChanged: (value) {
            setState(() {
              data.properties['value'] = value;
            });
          },
        );

      case 'slider':
        return _buildSlider(
          value: data.properties['value'] ?? 50.0,
          min: data.properties['min'] ?? 0.0,
          max: data.properties['max'] ?? 100.0,
          onChanged: (value) {
            setState(() {
              data.properties['value'] = value;
            });
          },
        );

      case 'stepper':
        return _buildStepper(
          value: data.properties['value'] ?? 5,
          min: data.properties['min'] ?? 0,
          max: data.properties['max'] ?? 10,
          onIncrement: () {
            setState(() {
              if (data.properties['value'] < data.properties['max']) {
                data.properties['value']++;
              }
            });
          },
          onDecrement: () {
            setState(() {
              if (data.properties['value'] > data.properties['min']) {
                data.properties['value']--;
              }
            });
          },
        );

      case 'timepicker':
        return _buildTimePicker(
          dateTime:
              data.properties['dateTime'] != null
                  ? DateTime.fromMillisecondsSinceEpoch(
                    data.properties['dateTime'],
                  )
                  : DateTime.now(),
          onChanged: (dateTime) {
            setState(() {
              data.properties['dateTime'] = dateTime.millisecondsSinceEpoch;
            });
          },
        );

      case 'messenger':
        return _buildMessenger(
          messages: data.properties['messages'] ?? [],
          widgetId: data.id,
          onSend: (message) {
            setState(() {
              if (data.properties['messages'] == null) {
                data.properties['messages'] = [];
              }
              data.properties['messages'].add(message);
            });
          },
          onClear: () {
            setState(() {
              data.properties['messages'] = [];
            });
          },
        );

      case 'color':
        return _buildColorPicker(
          color:
              data.properties['color'] != null
                  ? Color(data.properties['color'])
                  : Colors.red,
          onChanged: (color) {
            setState(() {
              data.properties['color'] = color.value;
            });
          },
        );

      case 'coloredlight':
        return _buildColoredLight(
          color:
              data.properties['color'] != null
                  ? Color(data.properties['color'])
                  : Colors.blue,
          isOn: data.properties['isOn'] ?? false,
          onColorChanged: (color) {
            setState(() {
              data.properties['color'] = color.value;
            });
          },
          onToggle: (isOn) {
            setState(() {
              data.properties['isOn'] = isOn;
            });
          },
        );

      case 'value':
        return _buildValueDisplay(
          value: data.properties['value']?.toString() ?? "0",
        );

      case 'status':
        return _buildStatusIndicator(
          isActive: data.properties['isActive'] ?? false,
        );

      case 'gauge':
        return _buildGauge(
          value: data.properties['value'] ?? 0.0,
          min: data.properties['min'] ?? 0.0,
          max: data.properties['max'] ?? 100.0,
        );

      case 'percentage':
        return _buildPercentage(value: data.properties['value'] ?? 0.0);

      case 'led':
        return _buildLedIndicator(isOn: data.properties['isOn'] ?? false);

      case 'map':
        return _buildMap(
          location: LatLng(
            data.properties['latitude'] ?? 45.464664,
            data.properties['longitude'] ?? 9.188540,
          ),
        );

      case 'advancedmap':
        List<LatLng> locations = [];
        if (data.properties['locations'] != null) {
          for (var loc in data.properties['locations']) {
            locations.add(LatLng(loc['latitude'], loc['longitude']));
          }
        }
        return _buildAdvancedMap(
          locations:
              locations.isEmpty ? [LatLng(45.464664, 9.188540)] : locations,
        );

      case 'chart':
        return _buildChart(
          data: List<double>.from(data.properties['data'] ?? [0.0, 0.0, 0.0]),
        );

      case 'advancedchart':
        return _buildAdvancedChart(
          dataSeries:
              data.properties['dataSeries'] ??
              [
                [0.0],
                [0.0],
              ],
          labels: data.properties['labels'] ?? ["Serie 1", "Serie 2"],
        );

      case 'scheduler':
        return _buildScheduler(
          isActive: data.properties['isActive'] ?? false,
          scheduleTime: data.properties['scheduleTime'] ?? "08:00",
          scheduleDays: List<String>.from(
            data.properties['scheduleDays'] ?? ["Lun", "Mer", "Ven"],
          ),
          onToggle: (isActive) {
            setState(() {
              data.properties['isActive'] = isActive;
            });
          },
        );

      case 'stickynote':
        return _buildStickyNote(
          content: data.properties['content'] ?? "Nota",
          onEdit: (content) {
            setState(() {
              data.properties['content'] = content;
            });
          },
        );

      case 'valueselector':
        return _buildValueSelector(
          options: List<String>.from(
            data.properties['options'] ??
                ["Opzione 1", "Opzione 2", "Opzione 3"],
          ),
          selectedIndex: data.properties['selectedIndex'] ?? 0,
          onSelect: (index) {
            setState(() {
              data.properties['selectedIndex'] = index;
            });
          },
        );

      case 'valuedropdown':
        return _buildValueDropdown(
          options: List<String>.from(
            data.properties['options'] ??
                ["Opzione 1", "Opzione 2", "Opzione 3"],
          ),
          selectedValue: data.properties['selectedValue'] ?? "Opzione 1",
          onChanged: (value) {
            setState(() {
              data.properties['selectedValue'] = value;
            });
          },
        );

      case 'image':
        return _buildImageWidget(imageUrl: data.properties['imageUrl']);

      default:
        return const Text(
          'Tipo sconosciuto',
          style: TextStyle(color: Colors.white),
        );
    }
  }

  // Widget implementation
  // -----------------------------------------

  /// Build temperature indicator
  Widget _buildTemperatureIndicator({
    required double temperature,
    required double minTemp,
    required double maxTemp,
  }) {
    // Calculate color based on temperature
    final normalizedTemp = ((temperature - minTemp) / (maxTemp - minTemp))
        .clamp(0.0, 1.0);
    final color =
        Color.lerp(Colors.blue, Colors.red, normalizedTemp) ?? Colors.blue;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Temperature display
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.thermostat, color: color, size: 20),
            const SizedBox(width: 4),
            Text(
              '${temperature.toStringAsFixed(1)}°C',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Temperature bar
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.grey[700],
          ),
          child: FractionallySizedBox(
            widthFactor: normalizedTemp,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.red],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build dimmer indicator
  Widget _buildDimmerIndicator({
    required double value,
    required bool isOn,
    required Function(double) onValueChanged,
    required Function(bool) onToggle,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 4),
        // Light bulb
        GestureDetector(
          onTap: () => onToggle(!isOn),
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isOn ? Colors.amber.withOpacity(value) : Colors.grey[800],
              border: Border.all(color: Colors.grey[600]!, width: 1),
            ),
            child: Center(
              child: Icon(
                Icons.lightbulb,
                size: 24,
                color: isOn ? Colors.white : Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),

        // Slider
        Container(
          width: 100,
          height: 20,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: SliderTheme(
            data: SliderThemeData(
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
              trackHeight: 3,
              activeTrackColor: isOn ? Colors.amber : Colors.grey,
              inactiveTrackColor: Colors.grey[700],
              thumbColor: Colors.white,
              overlayColor: Colors.amber.withOpacity(0.2),
            ),
            child: Slider(
              value: value,
              onChanged: onValueChanged,
              min: 0.0,
              max: 1.0,
            ),
          ),
        ),

        // Percentage
        Text(
          "${(value * 100).round()}%",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// Build push button
  Widget _buildPushButton({
    required bool isPressed,
    required Function(bool) onChanged,
  }) {
    return GestureDetector(
      onTapDown: (_) => onChanged(true),
      onTapUp: (_) => onChanged(false),
      onTapCancel: () => onChanged(false),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isPressed ? Colors.greenAccent : Colors.grey[800],
          border: Border.all(color: Colors.grey[600]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: isPressed ? 1 : 5,
              offset: isPressed ? const Offset(0, 1) : const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Icon(Icons.touch_app, color: Colors.white, size: 24),
        ),
      ),
    );
  }

  /// Build slider
  Widget _buildSlider({
    required double value,
    required double min,
    required double max,
    required Function(double) onChanged,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Value display
        Text(
          value.toStringAsFixed(1),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14, // Reduced from 16
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4), // Reduced from 8
        // Slider
        SliderTheme(
          data: SliderThemeData(
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6), // Reduced
            trackHeight: 3, // Reduced
            activeTrackColor: Colors.blue,
            inactiveTrackColor: Colors.grey[700],
            thumbColor: Colors.white,
            overlayColor: Colors.blue.withOpacity(0.2),
          ),
          child: Slider(value: value, min: min, max: max, onChanged: onChanged),
        ),
      ],
    );
  }

  /// Build stepper
  Widget _buildStepper({
    required int value,
    required int min,
    required int max,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Decrement button
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[800],
            border: Border.all(color: Colors.grey[600]!, width: 1),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.remove, color: Colors.white, size: 16),
            onPressed: value > min ? onDecrement : null,
          ),
        ),
        // Value
        Container(
          width: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '$value',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Increment button
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[800],
            border: Border.all(color: Colors.grey[600]!, width: 1),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.add, color: Colors.white, size: 16),
            onPressed: value < max ? onIncrement : null,
          ),
        ),
      ],
    );
  }

  /// Build time picker
  Widget _buildTimePicker({
    required DateTime dateTime,
    required Function(DateTime) onChanged,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Time display
        Text(
          '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4), // Reduced
        // Date
        Text(
          '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}',
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 4), // Reduced
        // Select button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () async {
            final TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(dateTime),
            );
            if (pickedTime != null) {
              final newDateTime = DateTime(
                dateTime.year,
                dateTime.month,
                dateTime.day,
                pickedTime.hour,
                pickedTime.minute,
              );
              onChanged(newDateTime);
            }
          },
          child: Text('Seleziona'),
        ),
      ],
    );
  }

  /// Build messenger
  Widget _buildMessenger({
    required List<String> messages,
    required Function(String) onSend,
    required Function() onClear,
    String? widgetId,
  }) {
    // Create controller ID and get/create controller
    final controllerId =
        'messenger_${widgetId ?? DateTime.now().millisecondsSinceEpoch}';
    if (!_controllers.containsKey(controllerId)) {
      _controllers[controllerId] = TextEditingController();
    }
    final controller = _controllers[controllerId] as TextEditingController;

    return SizedBox(
      height: 160,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Messages area
          Container(
            height: 95, // Fixed height
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                messages.isEmpty
                    ? Center(
                      child: Text(
                        'Nessun messaggio',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    )
                    : ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              messages[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: InkWell(
                    onTap: onClear,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.clear, size: 14, color: Colors.white70),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Input area
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      controller: controller,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      decoration: InputDecoration(
                        hintText: 'Messaggio...',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.white, size: 16),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      onSend(controller.text);
                      controller.clear();
                    }
                  },
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints.tightFor(width: 32),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build color picker
  Widget _buildColorPicker({
    required Color color,
    required Function(Color) onChanged,
  }) {
    final List<Color> presetColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.teal,
    ];

    return SizedBox(
      height: 120,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Selected color
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
          const SizedBox(height: 10),
          // Color grid
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children:
                presetColors.map((presetColor) {
                  return GestureDetector(
                    onTap: () => onChanged(presetColor),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: presetColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              presetColor == color
                                  ? Colors.white
                                  : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  /// Build colored light
  Widget _buildColoredLight({
    required Color color,
    required bool isOn,
    required Function(Color) onColorChanged,
    required Function(bool) onToggle,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Colored light
        GestureDetector(
          onTap: () => onToggle(!isOn),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isOn ? color : Colors.grey[800],
              border: Border.all(color: Colors.grey[600]!, width: 1),
            ),
            child: Center(
              child: Icon(
                Icons.lightbulb,
                color: isOn ? Colors.white : Colors.white.withOpacity(0.5),
                size: 30,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Status
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isOn ? Colors.green : Colors.grey[700],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            isOn ? 'ON' : 'OFF',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        // Color selector
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _colorDot(Colors.red, color, onColorChanged),
            _colorDot(Colors.green, color, onColorChanged),
            _colorDot(Colors.blue, color, onColorChanged),
            _colorDot(Colors.yellow, color, onColorChanged),
          ],
        ),
      ],
    );
  }

  /// Helper for color dot
  Widget _colorDot(
    Color dotColor,
    Color selectedColor,
    Function(Color) onColorChanged,
  ) {
    return GestureDetector(
      onTap: () => onColorChanged(dotColor),
      child: Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: dotColor,
          shape: BoxShape.circle,
          border: Border.all(
            color:
                dotColor.value == selectedColor.value
                    ? Colors.white
                    : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  /// Build value display
  Widget _buildValueDisplay({required String value}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Build status indicator
  Widget _buildStatusIndicator({required bool isActive}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.green : Colors.red,
        boxShadow: [
          BoxShadow(
            color: (isActive ? Colors.green : Colors.red).withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          isActive ? Icons.check : Icons.close,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  /// Build gauge
  Widget _buildGauge({
    required double value,
    required double min,
    required double max,
  }) {
    final double percentage = ((value - min) / (max - min)).clamp(0.0, 1.0);
    final double angle = (percentage * 180);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Gauge
        SizedBox(
          width: 100,
          height: 60,
          child: CustomPaint(painter: GaugePainter(angle: angle)),
        ),
        const SizedBox(height: 4),
        // Value
        Text(
          value.toStringAsFixed(1),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// Build percentage
  Widget _buildPercentage({required double value}) {
    final Color progressColor =
        value < 25
            ? Colors.red
            : value < 50
            ? Colors.orange
            : value < 75
            ? Colors.yellow
            : Colors.green;

    return SizedBox(
      height: 90,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Percentage circle
          SizedBox(
            width: 70,
            height: 70,
            child: Stack(
              children: [
                // Background
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[800],
                  ),
                ),
                // Progress
                Center(
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(
                      value: value / 100,
                      strokeWidth: 8,
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                      backgroundColor: Colors.grey[700],
                    ),
                  ),
                ),
                // Value
                Center(
                  child: Text(
                    '${value.round()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build LED indicator
  Widget _buildLedIndicator({required bool isOn}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isOn ? Colors.green : Colors.grey[800],
        boxShadow:
            isOn
                ? [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.6),
                    blurRadius: 12,
                    spreadRadius: 4,
                  ),
                ]
                : null,
      ),
      child: Center(
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isOn ? Colors.greenAccent : Colors.grey[700],
            border: Border.all(
              color: isOn ? Colors.green[300]! : Colors.grey[600]!,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  /// Build map
  Widget _buildMap({required LatLng location}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // Map placeholder
          Center(child: Icon(Icons.map, size: 60, color: Colors.grey[600])),
          // Location marker
          Center(child: Icon(Icons.location_on, size: 30, color: Colors.red)),
          // Coordinates
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build advanced map
  Widget _buildAdvancedMap({required List<LatLng> locations}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // Map placeholder
          Center(child: Icon(Icons.map, size: 60, color: Colors.grey[600])),
          // Location markers
          ...locations.map(
            (loc) => Center(
              child: Icon(Icons.location_on, size: 30, color: Colors.red),
            ),
          ),
          // Path line (simulated)
          if (locations.length > 1)
            CustomPaint(size: Size.infinite, painter: PathPainter(locations)),
          // Controls
          Positioned(
            top: 8,
            right: 8,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: Colors.black),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.remove, color: Colors.black),
                ),
              ],
            ),
          ),
          // Info
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${locations.length} punti tracciati',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build chart
  Widget _buildChart({required List<double> data}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Chart
          SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  data.map((value) {
                    final double height = (value / 100) * 80;
                    return Container(
                      width: 12,
                      height: height.clamp(4, 80),
                      color: Colors.blue,
                    );
                  }).toList(),
            ),
          ),
          const SizedBox(height: 4),
          // Labels
          Text(
            'Min: ${data.reduce(min).toStringAsFixed(1)} | Max: ${data.reduce(max).toStringAsFixed(1)}',
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }

  /// Build advanced chart
  Widget _buildAdvancedChart({
    required List<List<dynamic>> dataSeries,
    required List<String> labels,
  }) {
    final List<Color> seriesColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
    ];

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Chart
          SizedBox(
            height: 130,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(dataSeries.length.clamp(0, 5), (
                    seriesIndex,
                  ) {
                    if (dataSeries[seriesIndex].length <= index) {
                      return const SizedBox.shrink();
                    }
                    final value = dataSeries[seriesIndex][index];
                    final double height = (value / 100) * 60;
                    return Container(
                      width: 8,
                      height: height.clamp(4, 60),
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      color: seriesColors[seriesIndex % seriesColors.length],
                    );
                  }),
                );
              }),
            ),
          ),
          const SizedBox(height: 4),
          // Legend
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              labels.length.clamp(0, 5),
              (index) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.only(right: 4),
                    color: seriesColors[index % seriesColors.length],
                  ),
                  Text(
                    labels[index],
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build scheduler
  Widget _buildScheduler({
    required bool isActive,
    required String scheduleTime,
    required List<String> scheduleDays,
    required Function(bool) onToggle,
  }) {
    return Container(
      height: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Stato:',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              GestureDetector(
                onTap: () => onToggle(!isActive),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green : Colors.grey[700],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isActive ? 'Attivo' : 'Inattivo',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Orario:',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                scheduleTime,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          // Days
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Giorni:',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                scheduleDays.join(', '),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 5),
          // Edit button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 4),
              ),
              onPressed: () {},
              child: Text('Modifica'),
            ),
          ),
        ],
      ),
    );
  }

  /// Build sticky note
  Widget _buildStickyNote({
    required String content,
    required Function(String) onEdit,
  }) {
    return GestureDetector(
      onTap: () {
        // Show edit dialog
        showDialog(
          context: context,
          builder: (context) {
            final controller = TextEditingController(text: content);
            return AlertDialog(
              title: Text('Modifica nota'),
              content: TextField(
                controller: controller,
                decoration: InputDecoration(hintText: 'Inserisci il testo...'),
                maxLines: 5,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Annulla'),
                ),
                TextButton(
                  onPressed: () {
                    onEdit(controller.text);
                    Navigator.pop(context);
                  },
                  child: Text('Salva'),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.yellow[700],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Text(
          content,
          style: TextStyle(color: Colors.black87, fontSize: 14),
        ),
      ),
    );
  }

  /// Build value selector
  Widget _buildValueSelector({
    required List<String> options,
    required int selectedIndex,
    required Function(int) onSelect,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Selected value display
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            options[selectedIndex],
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Option buttons
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              options.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedIndex == index ? Colors.blue : Colors.grey[700],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () => onSelect(index),
                  child: Text(options[index], style: TextStyle(fontSize: 12)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build value dropdown
  Widget _buildValueDropdown({
    required List<String> options,
    required String selectedValue,
    required Function(String) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        underline: Container(height: 0),
        dropdownColor: Colors.grey[800],
        onChanged: (String? newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
        items:
            options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
      ),
    );
  }

  /// Build image widget
  Widget _buildImageWidget({String? imageUrl}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.image, size: 40, color: Colors.grey[400]),
                const SizedBox(height: 8),
                Text(
                  imageUrl != null ? 'Immagine' : 'Immagine non disponibile',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ),
          ),
          if (imageUrl != null)
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh, size: 12, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      'Auto',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Utility Painters
// -----------------------------------------

/// Grid painter
class GridPainter extends CustomPainter {
  final double gridSize;

  GridPainter({required this.gridSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.1)
          ..strokeWidth = 0.5;

    // Vertical lines
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Gauge painter
class GaugePainter extends CustomPainter {
  final double angle;

  GaugePainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = min(size.width / 2, size.height);

    // Background arc
    final backgroundPaint =
        Paint()
          ..color = Colors.grey[700]!
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi,
      false,
      backgroundPaint,
    );

    // Progress arc
    final progressPaint =
        Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      (angle * pi / 180),
      false,
      progressPaint,
    );

    // Border
    final borderPaint =
        Paint()
          ..color = Colors.white.withOpacity(0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi,
      false,
      borderPaint,
    );

    // Indicator
    final indicatorPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    final radians = pi + (angle * pi / 180);
    final indicatorX = center.dx + radius * cos(radians);
    final indicatorY = center.dy + radius * sin(radians);

    canvas.drawCircle(Offset(indicatorX, indicatorY), 5, indicatorPaint);
  }

  @override
  bool shouldRepaint(covariant GaugePainter oldDelegate) {
    return oldDelegate.angle != angle;
  }
}

/// Path painter for advanced map
class PathPainter extends CustomPainter {
  final List<LatLng> points;

  PathPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final paint =
        Paint()
          ..color = Colors.blue
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    final path =
        ui.Path(); // Use ui.Path explicitly to avoid conflict with latlong2.Path

    // This is a very simplified approach - in a real app we would
    // properly project the coordinates onto the map view
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Create a simple path through the center
    path.moveTo(centerX - 40, centerY - 30);
    path.lineTo(centerX, centerY);
    path.lineTo(centerX + 40, centerY + 30);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
