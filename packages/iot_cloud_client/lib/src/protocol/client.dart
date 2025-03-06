/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:iot_cloud_client/src/protocol/io_module/io_module.dart' as _i3;
import 'package:iot_cloud_client/src/protocol/iot_device/iot_device.dart'
    as _i4;
import 'package:iot_cloud_client/src/protocol/platformio/platformio_status.dart'
    as _i5;
import 'package:iot_cloud_client/src/protocol/platformio/platformio_project.dart'
    as _i6;
import 'package:iot_cloud_client/src/protocol/platformio/platformio_build_result.dart'
    as _i7;
import 'package:iot_cloud_client/src/protocol/platformio/platformio_board.dart'
    as _i8;
import 'package:iot_cloud_client/src/protocol/platformio/platformio_device.dart'
    as _i9;
import 'package:iot_cloud_client/src/protocol/platformio/platformio_library.dart'
    as _i10;
import 'package:iot_cloud_client/src/protocol/platformio/platformio_platform.dart'
    as _i11;
import 'package:iot_cloud_client/src/protocol/platformio/platformio_file.dart'
    as _i12;
import 'protocol.dart' as _i13;

/// {@category Endpoint}
class EndpointIoModule extends _i1.EndpointRef {
  EndpointIoModule(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'ioModule';

  _i2.Future<bool> insert(_i3.IoModule ioModule) =>
      caller.callServerEndpoint<bool>(
        'ioModule',
        'insert',
        {'ioModule': ioModule},
      );

  _i2.Future<bool> attach(
    _i4.IotDevice iotDevice,
    _i3.IoModule ioModule,
  ) =>
      caller.callServerEndpoint<bool>(
        'ioModule',
        'attach',
        {
          'iotDevice': iotDevice,
          'ioModule': ioModule,
        },
      );
}

/// {@category Endpoint}
class EndpointIotDevice extends _i1.EndpointRef {
  EndpointIotDevice(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'iotDevice';

  _i2.Future<bool> register(_i4.IotDevice iotDevice) =>
      caller.callServerEndpoint<bool>(
        'iotDevice',
        'register',
        {'iotDevice': iotDevice},
      );
}

/// {@category Endpoint}
class EndpointPlatformio extends _i1.EndpointRef {
  EndpointPlatformio(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'platformio';

  _i2.Future<_i5.PlatformioStatus> checkPlatformIO() =>
      caller.callServerEndpoint<_i5.PlatformioStatus>(
        'platformio',
        'checkPlatformIO',
        {},
      );

  _i2.Future<bool> initProject(
    String path,
    String board,
    String framework,
    String name,
    String? description,
  ) =>
      caller.callServerEndpoint<bool>(
        'platformio',
        'initProject',
        {
          'path': path,
          'board': board,
          'framework': framework,
          'name': name,
          'description': description,
        },
      );

  _i2.Future<List<_i6.PlatformioProject>> listProjects() =>
      caller.callServerEndpoint<List<_i6.PlatformioProject>>(
        'platformio',
        'listProjects',
        {},
      );

  _i2.Future<_i6.PlatformioProject?> getProject(int id) =>
      caller.callServerEndpoint<_i6.PlatformioProject?>(
        'platformio',
        'getProject',
        {'id': id},
      );

  _i2.Future<bool> deleteProject(int id) => caller.callServerEndpoint<bool>(
        'platformio',
        'deleteProject',
        {'id': id},
      );

  _i2.Future<_i7.PlatformioBuildResult> buildProject(
          _i6.PlatformioProject project) =>
      caller.callServerEndpoint<_i7.PlatformioBuildResult>(
        'platformio',
        'buildProject',
        {'project': project},
      );

  _i2.Future<_i7.PlatformioBuildResult> uploadProject(
    _i6.PlatformioProject project,
    String? port,
  ) =>
      caller.callServerEndpoint<_i7.PlatformioBuildResult>(
        'platformio',
        'uploadProject',
        {
          'project': project,
          'port': port,
        },
      );

  _i2.Future<_i7.PlatformioBuildResult> uploadProjectOTA(
    _i6.PlatformioProject project,
    String ipAddress,
    int port,
  ) =>
      caller.callServerEndpoint<_i7.PlatformioBuildResult>(
        'platformio',
        'uploadProjectOTA',
        {
          'project': project,
          'ipAddress': ipAddress,
          'port': port,
        },
      );

  _i2.Future<List<_i8.PlatformioBoard>> listBoards() =>
      caller.callServerEndpoint<List<_i8.PlatformioBoard>>(
        'platformio',
        'listBoards',
        {},
      );

  _i2.Future<List<_i8.PlatformioBoard>> searchBoards(String query) =>
      caller.callServerEndpoint<List<_i8.PlatformioBoard>>(
        'platformio',
        'searchBoards',
        {'query': query},
      );

  _i2.Future<List<_i9.PlatformioDevice>> listDevices() =>
      caller.callServerEndpoint<List<_i9.PlatformioDevice>>(
        'platformio',
        'listDevices',
        {},
      );

  _i2.Future<bool> installLibrary(
    _i6.PlatformioProject project,
    String library,
  ) =>
      caller.callServerEndpoint<bool>(
        'platformio',
        'installLibrary',
        {
          'project': project,
          'library': library,
        },
      );

  _i2.Future<List<_i10.PlatformioLibrary>> searchLibraries(String query) =>
      caller.callServerEndpoint<List<_i10.PlatformioLibrary>>(
        'platformio',
        'searchLibraries',
        {'query': query},
      );

  _i2.Future<bool> updateLibraryIndex() => caller.callServerEndpoint<bool>(
        'platformio',
        'updateLibraryIndex',
        {},
      );

  _i2.Future<String?> readProjectFile(String path) =>
      caller.callServerEndpoint<String?>(
        'platformio',
        'readProjectFile',
        {'path': path},
      );

  _i2.Future<bool> writeProjectFile(
    String path,
    String content,
  ) =>
      caller.callServerEndpoint<bool>(
        'platformio',
        'writeProjectFile',
        {
          'path': path,
          'content': content,
        },
      );

  _i2.Future<List<String>> listProjectFiles(String projectPath) =>
      caller.callServerEndpoint<List<String>>(
        'platformio',
        'listProjectFiles',
        {'projectPath': projectPath},
      );

  _i2.Future<List<_i11.PlatformioPlatform>> listPlatforms() =>
      caller.callServerEndpoint<List<_i11.PlatformioPlatform>>(
        'platformio',
        'listPlatforms',
        {},
      );

  _i2.Future<bool> installPlatform(String platform) =>
      caller.callServerEndpoint<bool>(
        'platformio',
        'installPlatform',
        {'platform': platform},
      );

  _i2.Future<bool> updatePlatforms() => caller.callServerEndpoint<bool>(
        'platformio',
        'updatePlatforms',
        {},
      );

  _i2.Future<List<_i6.PlatformioProject>> syncProjects() =>
      caller.callServerEndpoint<List<_i6.PlatformioProject>>(
        'platformio',
        'syncProjects',
        {},
      );

  _i2.Future<Map<String, String>> executeDockerCommand(String command) =>
      caller.callServerEndpoint<Map<String, String>>(
        'platformio',
        'executeDockerCommand',
        {'command': command},
      );
}

/// {@category Endpoint}
class EndpointPlatformioFile extends _i1.EndpointRef {
  EndpointPlatformioFile(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'platformioFile';

  _i2.Future<List<_i12.PlatformioFile>> listFiles(String directoryPath) =>
      caller.callServerEndpoint<List<_i12.PlatformioFile>>(
        'platformioFile',
        'listFiles',
        {'directoryPath': directoryPath},
      );

  _i2.Future<String?> readFile(String filePath) =>
      caller.callServerEndpoint<String?>(
        'platformioFile',
        'readFile',
        {'filePath': filePath},
      );

  _i2.Future<bool> writeFile(
    String filePath,
    String content,
  ) =>
      caller.callServerEndpoint<bool>(
        'platformioFile',
        'writeFile',
        {
          'filePath': filePath,
          'content': content,
        },
      );

  _i2.Future<bool> createDirectory(String directoryPath) =>
      caller.callServerEndpoint<bool>(
        'platformioFile',
        'createDirectory',
        {'directoryPath': directoryPath},
      );

  _i2.Future<bool> deleteFileOrDirectory(
    String path,
    bool recursive,
  ) =>
      caller.callServerEndpoint<bool>(
        'platformioFile',
        'deleteFileOrDirectory',
        {
          'path': path,
          'recursive': recursive,
        },
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i13.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    ioModule = EndpointIoModule(this);
    iotDevice = EndpointIotDevice(this);
    platformio = EndpointPlatformio(this);
    platformioFile = EndpointPlatformioFile(this);
  }

  late final EndpointIoModule ioModule;

  late final EndpointIotDevice iotDevice;

  late final EndpointPlatformio platformio;

  late final EndpointPlatformioFile platformioFile;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'ioModule': ioModule,
        'iotDevice': iotDevice,
        'platformio': platformio,
        'platformioFile': platformioFile,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
