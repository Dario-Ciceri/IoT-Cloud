import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iot_cloud_client/iot_cloud_client.dart';
import 'package:iot_cloud_flutter/src/core/constants/constants.dart';
import 'package:iot_cloud_flutter/src/core/widgets/loading_indicator.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/presentation/bloc/iot_device_bloc.dart';

//! N.B.: stateful solo per init e dispose, gestire lo stato con bloc.
class IotDeviceListWidget extends StatefulWidget {
  const IotDeviceListWidget({super.key});

  @override
  State<IotDeviceListWidget> createState() => _IotDeviceListWidgetState();
}

class _IotDeviceListWidgetState extends State<IotDeviceListWidget> {
  @override
  void initState() {
    super.initState();
    context.read<IotDeviceBloc>().add(IotDeviceEvent.list());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IotDeviceBloc, IotDeviceBlocState>(
      listener: (context, state) {
        switch (state.status) {
          case IotDeviceBlocStatus.initial:
            break;
          case IotDeviceBlocStatus.loading:
            break;
          case IotDeviceBlocStatus.success:
            break;
          case IotDeviceBlocStatus.failure:
            ScaffoldMessenger.maybeOf(context)?.showMaterialBanner(
              MaterialBanner(
                content: Text(state.errorMessage),
                actions: [Icon(Icons.close)],
              ),
            );
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case IotDeviceBlocStatus.initial:
            return LoadingIndicator(message: "Avvio in corso...");
          case IotDeviceBlocStatus.loading:
            return Stack(
              children: [
                IotDeviceGridView(iotDevices: state.iotDevices),
                LinearProgressIndicator(),
              ],
            );
          case IotDeviceBlocStatus.success:
            if (state.iotDevices.isEmpty) {
              return NoIotDevicesFound();
            }
            return IotDeviceGridView(iotDevices: state.iotDevices);
          case IotDeviceBlocStatus.failure:
            if (state.iotDevices.isEmpty) {
              return NoIotDevicesFound();
            }
            return IotDeviceGridView(iotDevices: state.iotDevices);
        }
      },
    );
  }
}

class NoIotDevicesFound extends StatelessWidget {
  const NoIotDevicesFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Nessun dispositivo IoT trovato!"));
  }
}

class IotDeviceGridView extends StatelessWidget {
  const IotDeviceGridView({super.key, required this.iotDevices});

  final List<IotDevice> iotDevices;

  @override
  Widget build(BuildContext context) {
    // Calcola il numero di colonne in base alla larghezza dello schermo
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = (width ~/ 300).clamp(1, 5);

    return MasonryGridView.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      padding: const EdgeInsets.all(8),
      itemCount: iotDevices.length,
      itemBuilder: (context, index) {
        final iotDevice = iotDevices[index];
        return DeviceCard(iotDevice: iotDevice);
      },
    );
  }
}

class DeviceCard extends StatelessWidget {
  const DeviceCard({super.key, required this.iotDevice});

  final IotDevice iotDevice;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determina il colore dello stato
    late final Color statusColor;

    switch (iotDevice.state?.status) {
      case null:
        statusColor = Colors.grey;
      case IotDeviceStatus.Online:
        statusColor = Colors.green;
      case IotDeviceStatus.Offline:
        statusColor = Colors.red;
      case IotDeviceStatus.Error:
        statusColor = Colors.orange;
    }

    // Determina il percorso per l'immagine
    late final String boardIconPath;

    switch (iotDevice.type) {
      case IotDeviceType.ArduinoR4WiFi:
        boardIconPath = arduinoIconPath;
      case IotDeviceType.ESP32:
        boardIconPath = espressifIconPath;
      case IotDeviceType.RaspberryPi:
        boardIconPath = raspberryPiIconPath;
      case IotDeviceType.STM32:
        boardIconPath = stm32IconPath;
    }

    return Card(
      elevation: 2,
      // Per assicurarsi che l'etichetta non oltrepassi i bordi
      clipBehavior: Clip.antiAlias,
      child: Container(
        // Rimosso il padding top per l'etichetta
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              color: theme.colorScheme.primaryContainer,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        iotDevice.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      IconButton(
                        onPressed: () {
                          //todo
                        },
                        icon: Icon(Icons.refresh_rounded),
                      ),
                    ],
                  ),
                  if (iotDevice.state?.heartBeat != null)
                    Text(
                      "Ultimo aggiornamento: ${_formatDateTime(iotDevice.state!.heartBeat)}",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    )
                  else
                    Text(
                      "Ultimo aggiornamento: ?",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Contenuto principale
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // info
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(boardIconPath, width: 35, height: 35),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${iotDevice.type} - Firmware: v${iotDevice.fwVersion}",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                            Text(
                              "Seriale: ${iotDevice.serialId}",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                            Text(
                              "Numero moduli associati: ${iotDevice.attachedModules?.length ?? '?'}",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),

                  // Messaggio di errore se lo stato è Error
                  if (iotDevice.state?.status == IotDeviceStatus.Error)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.orange),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber,
                            color: Colors.orange,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              iotDevice.state?.errorMessage ??
                                  "Errore nel dispositivo",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.orange.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  Divider(
                    height: 16,
                    color: colorScheme.onSurface.withValues(alpha: 0.1),
                  ),

                  // Stats row
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildStat(
                        context,
                        'CPU',
                        '${iotDevice.state?.cpuLoad ?? '?'}%',
                      ),
                      _buildStat(
                        context,
                        'Temp',
                        '${iotDevice.state?.temp ?? '?'}°C',
                      ),
                      _buildStat(
                        context,
                        'Mem',
                        '${iotDevice.state?.mem ?? '?'} MB',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // Formatta la data in un formato leggibile
  // Todo usare intl + dateformat
  String _formatDateTime(DateTime dateTime) {
    dateTime = dateTime.toLocal();
    return "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}
