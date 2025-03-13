import 'package:flutter/material.dart';

/// Un widget generico draggable che può contenere qualsiasi tipo di widget
class DraggableWidget<T extends Object> extends StatelessWidget {
  /// Il widget da renderizzare
  final Widget child;

  /// I dati associati a questo widget (tipo, id, configurazione, ecc.)
  final T data;

  /// Callback chiamata quando il drag inizia
  final VoidCallback? onDragStarted;

  /// Callback chiamata quando il drag termina
  final Function(DraggableDetails)? onDragEnd;

  /// L'opacità del widget durante il trascinamento
  final double feedbackOpacity;

  /// Determina se mostrare un placeholder quando il widget viene trascinato
  final bool showChildWhenDragging;

  const DraggableWidget({
    Key? key,
    required this.child,
    required this.data,
    this.onDragStarted,
    this.onDragEnd,
    this.feedbackOpacity = 0.7,
    this.showChildWhenDragging = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<T>(
      // I dati che verranno passati al DragTarget
      data: data,

      // Il widget mostrato durante il trascinamento
      feedback: Material(
        elevation: 4.0,
        color: Colors.transparent,
        child: Opacity(opacity: feedbackOpacity, child: child),
      ),

      // Il widget mostrato nella posizione originale durante il trascinamento
      childWhenDragging:
          showChildWhenDragging
              ? Opacity(opacity: 0.3, child: child)
              : Container(),

      // Il widget nella posizione originale
      child: child,

      // Callback
      onDragStarted: onDragStarted,
      onDragEnd: onDragEnd,
    );
  }
}

/// Widget che può accettare elementi trascinati
class DashboardDropTarget<T extends Object> extends StatelessWidget {
  /// Funzione che costruisce il widget mostrato quando non ci sono elementi
  final Widget Function(BuildContext, List<T?>, List<dynamic>) builder;

  /// Funzione chiamata quando un elemento viene accettato
  final Function(T) onAccept;

  /// Funzione che determina se un elemento può essere accettato
  final bool Function(T?)? onWillAccept;

  const DashboardDropTarget({
    Key? key,
    required this.builder,
    required this.onAccept,
    this.onWillAccept,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<T>(
      builder: builder,
      onAccept: onAccept,
      onWillAccept: onWillAccept,
    );
  }
}

/// Esempio di tipo di widget per il dashboard
class DashboardWidgetData {
  final String type;
  final String id;
  final Map<String, dynamic> properties;

  DashboardWidgetData({
    required this.type,
    required this.id,
    this.properties = const {},
  });
}

/// Esempio di uso dei widget
class DashboardExample extends StatefulWidget {
  const DashboardExample({Key? key}) : super(key: key);

  @override
  State<DashboardExample> createState() => _DashboardExampleState();
}

class _DashboardExampleState extends State<DashboardExample> {
  final List<DashboardWidgetData> dashboardWidgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Builder')),
      body: Row(
        children: [
          // Palette di widget disponibili
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[200],
              child: ListView(
                children: [
                  // Switch widget
                  DraggableWidget<DashboardWidgetData>(
                    data: DashboardWidgetData(type: 'switch', id: 'new_switch'),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text('Switch'),
                            Switch(value: true, onChanged: (value) {}),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Slider widget
                  DraggableWidget<DashboardWidgetData>(
                    data: DashboardWidgetData(type: 'slider', id: 'new_slider'),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text('Slider'),
                            Slider(value: 0.5, onChanged: (value) {}),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // TextField widget
                  DraggableWidget<DashboardWidgetData>(
                    data: DashboardWidgetData(
                      type: 'textfield',
                      id: 'new_textfield',
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text('Text Field'),
                            TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter text',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Button widget
                  DraggableWidget<DashboardWidgetData>(
                    data: DashboardWidgetData(type: 'button', id: 'new_button'),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text('Button'),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Click Me'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Chart widget (placeholder)
                  DraggableWidget<DashboardWidgetData>(
                    data: DashboardWidgetData(type: 'chart', id: 'new_chart'),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text('Chart'),
                            Container(
                              height: 100,
                              color: Colors.blue[100],
                              child: const Center(
                                child: Text('Chart Placeholder'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Area del dashboard
          Expanded(
            flex: 3,
            child: DashboardDropTarget<DashboardWidgetData>(
              builder: (context, candidateData, rejectedData) {
                return Container(
                  color: Colors.grey[100],
                  child:
                      dashboardWidgets.isEmpty
                          ? const Center(child: Text('Trascina i widget qui'))
                          : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.5,
                                ),
                            itemCount: dashboardWidgets.length,
                            itemBuilder: (context, index) {
                              final widgetData = dashboardWidgets[index];
                              return _buildDashboardWidget(widgetData);
                            },
                          ),
                );
              },
              onAccept: (data) {
                setState(() {
                  // Crea un nuovo id unico per il widget aggiunto
                  final newWidget = DashboardWidgetData(
                    type: data.type,
                    id: '${data.type}_${DateTime.now().millisecondsSinceEpoch}',
                    properties: Map<String, dynamic>.from(data.properties),
                  );
                  dashboardWidgets.add(newWidget);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardWidget(DashboardWidgetData data) {
    Widget widget;

    // Costruisce il widget in base al tipo
    switch (data.type) {
      case 'switch':
        widget = Switch(
          value: data.properties['value'] ?? true,
          onChanged: (value) {
            setState(() {
              final index = dashboardWidgets.indexWhere((w) => w.id == data.id);
              if (index != -1) {
                dashboardWidgets[index].properties['value'] = value;
              }
            });
          },
        );
        break;
      case 'slider':
        widget = Slider(
          value: data.properties['value'] ?? 0.5,
          onChanged: (value) {
            setState(() {
              final index = dashboardWidgets.indexWhere((w) => w.id == data.id);
              if (index != -1) {
                dashboardWidgets[index].properties['value'] = value;
              }
            });
          },
        );
        break;
      case 'textfield':
        widget = TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter text',
          ),
          onChanged: (value) {
            setState(() {
              final index = dashboardWidgets.indexWhere((w) => w.id == data.id);
              if (index != -1) {
                dashboardWidgets[index].properties['text'] = value;
              }
            });
          },
        );
        break;
      case 'button':
        widget = ElevatedButton(
          onPressed: () {
            // Azione del pulsante
          },
          child: Text(data.properties['text'] ?? 'Click Me'),
        );
        break;
      case 'chart':
        widget = Container(
          height: 100,
          color: Colors.blue[100],
          child: const Center(child: Text('Chart Placeholder')),
        );
        break;
      default:
        widget = const Text('Widget non supportato');
    }

    // Avvolge il widget in un card draggable per consentire il riposizionamento
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${data.type.substring(0, 1).toUpperCase()}${data.type.substring(1)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20),
                  onPressed: () {
                    setState(() {
                      dashboardWidgets.removeWhere((w) => w.id == data.id);
                    });
                  },
                ),
              ],
            ),
            const Divider(),
            Expanded(child: Center(child: widget)),
          ],
        ),
      ),
    );
  }
}

/// Un widget factory che può creare widget in base al tipo
class WidgetFactory {
  static Widget createWidget(
    String type,
    Map<String, dynamic> properties,
    Function(Map<String, dynamic>) onPropertiesChanged,
  ) {
    switch (type) {
      case 'switch':
        return Switch(
          value: properties['value'] ?? false,
          onChanged: (value) {
            properties['value'] = value;
            onPropertiesChanged(properties);
          },
        );
      case 'slider':
        return Slider(
          value: properties['value'] ?? 0.5,
          min: properties['min'] ?? 0.0,
          max: properties['max'] ?? 1.0,
          onChanged: (value) {
            properties['value'] = value;
            onPropertiesChanged(properties);
          },
        );
      case 'textfield':
        return TextField(
          controller: TextEditingController(text: properties['text']),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: properties['hint'] ?? 'Enter text',
          ),
          onChanged: (value) {
            properties['text'] = value;
            onPropertiesChanged(properties);
          },
        );
      // Aggiungi altri tipi di widget qui
      default:
        return Text('Widget tipo "$type" non supportato');
    }
  }
}
