/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/example_endpoint.dart' as _i2;
import '../endpoints/io_module_endpoint.dart' as _i3;
import '../endpoints/iot_device_endpoint.dart' as _i4;
import '../endpoints/platformio_endpoint.dart' as _i5;
import '../endpoints/platformio_file_endpoint.dart' as _i6;
import '../endpoints/url_shortener_endpoint.dart' as _i7;
import 'package:iot_cloud_server/src/generated/io_module/io_module.dart' as _i8;
import 'package:iot_cloud_server/src/generated/iot_device/iot_device.dart'
    as _i9;
import 'package:iot_cloud_server/src/generated/platformio/platformio_project.dart'
    as _i10;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'example': _i2.ExampleEndpoint()
        ..initialize(
          server,
          'example',
          null,
        ),
      'ioModule': _i3.IoModuleEndpoint()
        ..initialize(
          server,
          'ioModule',
          null,
        ),
      'iotDevice': _i4.IotDeviceEndpoint()
        ..initialize(
          server,
          'iotDevice',
          null,
        ),
      'platformio': _i5.PlatformioEndpoint()
        ..initialize(
          server,
          'platformio',
          null,
        ),
      'platformioFile': _i6.PlatformioFileEndpoint()
        ..initialize(
          server,
          'platformioFile',
          null,
        ),
      'urlShortener': _i7.UrlShortenerEndpoint()
        ..initialize(
          server,
          'urlShortener',
          null,
        ),
    };
    connectors['example'] = _i1.EndpointConnector(
      name: 'example',
      endpoint: endpoints['example']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['example'] as _i2.ExampleEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    connectors['ioModule'] = _i1.EndpointConnector(
      name: 'ioModule',
      endpoint: endpoints['ioModule']!,
      methodConnectors: {
        'insert': _i1.MethodConnector(
          name: 'insert',
          params: {
            'ioModule': _i1.ParameterDescription(
              name: 'ioModule',
              type: _i1.getType<_i8.IoModule>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ioModule'] as _i3.IoModuleEndpoint).insert(
            session,
            params['ioModule'],
          ),
        ),
        'attach': _i1.MethodConnector(
          name: 'attach',
          params: {
            'iotDevice': _i1.ParameterDescription(
              name: 'iotDevice',
              type: _i1.getType<_i9.IotDevice>(),
              nullable: false,
            ),
            'ioModule': _i1.ParameterDescription(
              name: 'ioModule',
              type: _i1.getType<_i8.IoModule>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ioModule'] as _i3.IoModuleEndpoint).attach(
            session,
            params['iotDevice'],
            params['ioModule'],
          ),
        ),
      },
    );
    connectors['iotDevice'] = _i1.EndpointConnector(
      name: 'iotDevice',
      endpoint: endpoints['iotDevice']!,
      methodConnectors: {
        'register': _i1.MethodConnector(
          name: 'register',
          params: {
            'iotDevice': _i1.ParameterDescription(
              name: 'iotDevice',
              type: _i1.getType<_i9.IotDevice>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['iotDevice'] as _i4.IotDeviceEndpoint).register(
            session,
            params['iotDevice'],
          ),
        )
      },
    );
    connectors['platformio'] = _i1.EndpointConnector(
      name: 'platformio',
      endpoint: endpoints['platformio']!,
      methodConnectors: {
        'checkPlatformIO': _i1.MethodConnector(
          name: 'checkPlatformIO',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint)
                  .checkPlatformIO(session),
        ),
        'initProject': _i1.MethodConnector(
          name: 'initProject',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'board': _i1.ParameterDescription(
              name: 'board',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'framework': _i1.ParameterDescription(
              name: 'framework',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint).initProject(
            session,
            params['path'],
            params['board'],
            params['framework'],
            params['name'],
            params['description'],
          ),
        ),
        'listProjects': _i1.MethodConnector(
          name: 'listProjects',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint)
                  .listProjects(session),
        ),
        'getProject': _i1.MethodConnector(
          name: 'getProject',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint).getProject(
            session,
            params['id'],
          ),
        ),
        'deleteProject': _i1.MethodConnector(
          name: 'deleteProject',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint).deleteProject(
            session,
            params['id'],
          ),
        ),
        'buildProject': _i1.MethodConnector(
          name: 'buildProject',
          params: {
            'project': _i1.ParameterDescription(
              name: 'project',
              type: _i1.getType<_i10.PlatformioProject>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint).buildProject(
            session,
            params['project'],
          ),
        ),
        'uploadProject': _i1.MethodConnector(
          name: 'uploadProject',
          params: {
            'project': _i1.ParameterDescription(
              name: 'project',
              type: _i1.getType<_i10.PlatformioProject>(),
              nullable: false,
            ),
            'port': _i1.ParameterDescription(
              name: 'port',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint).uploadProject(
            session,
            params['project'],
            params['port'],
          ),
        ),
        'uploadProjectOTA': _i1.MethodConnector(
          name: 'uploadProjectOTA',
          params: {
            'project': _i1.ParameterDescription(
              name: 'project',
              type: _i1.getType<_i10.PlatformioProject>(),
              nullable: false,
            ),
            'ipAddress': _i1.ParameterDescription(
              name: 'ipAddress',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'port': _i1.ParameterDescription(
              name: 'port',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint)
                  .uploadProjectOTA(
            session,
            params['project'],
            params['ipAddress'],
            params['port'],
          ),
        ),
        'listBoards': _i1.MethodConnector(
          name: 'listBoards',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint)
                  .listBoards(session),
        ),
        'searchBoards': _i1.MethodConnector(
          name: 'searchBoards',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint).searchBoards(
            session,
            params['query'],
          ),
        ),
        'listDevices': _i1.MethodConnector(
          name: 'listDevices',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint)
                  .listDevices(session),
        ),
        'installLibrary': _i1.MethodConnector(
          name: 'installLibrary',
          params: {
            'project': _i1.ParameterDescription(
              name: 'project',
              type: _i1.getType<_i10.PlatformioProject>(),
              nullable: false,
            ),
            'library': _i1.ParameterDescription(
              name: 'library',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint)
                  .installLibrary(
            session,
            params['project'],
            params['library'],
          ),
        ),
        'searchLibraries': _i1.MethodConnector(
          name: 'searchLibraries',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint)
                  .searchLibraries(
            session,
            params['query'],
          ),
        ),
        'updateLibraryIndex': _i1.MethodConnector(
          name: 'updateLibraryIndex',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint)
                  .updateLibraryIndex(session),
        ),
        'readProjectFile': _i1.MethodConnector(
          name: 'readProjectFile',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint)
                  .readProjectFile(
            session,
            params['path'],
          ),
        ),
        'writeProjectFile': _i1.MethodConnector(
          name: 'writeProjectFile',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint)
                  .writeProjectFile(
            session,
            params['path'],
            params['content'],
          ),
        ),
        'listProjectFiles': _i1.MethodConnector(
          name: 'listProjectFiles',
          params: {
            'projectPath': _i1.ParameterDescription(
              name: 'projectPath',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint)
                  .listProjectFiles(
            session,
            params['projectPath'],
          ),
        ),
        'listPlatforms': _i1.MethodConnector(
          name: 'listPlatforms',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint)
                  .listPlatforms(session),
        ),
        'installPlatform': _i1.MethodConnector(
          name: 'installPlatform',
          params: {
            'platform': _i1.ParameterDescription(
              name: 'platform',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint)
                  .installPlatform(
            session,
            params['platform'],
          ),
        ),
        'updatePlatforms': _i1.MethodConnector(
          name: 'updatePlatforms',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint)
                  .updatePlatforms(session),
        ),
        'syncProjects': _i1.MethodConnector(
          name: 'syncProjects',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint)
                  .syncProjects(session),
        ),
        'executeDockerCommand': _i1.MethodConnector(
          name: 'executeDockerCommand',
          params: {
            'command': _i1.ParameterDescription(
              name: 'command',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformio'] as _i5.PlatformioEndpoint)
                  .executeDockerCommand(
            session,
            params['command'],
          ),
        ),
      },
    );
    connectors['platformioFile'] = _i1.EndpointConnector(
      name: 'platformioFile',
      endpoint: endpoints['platformioFile']!,
      methodConnectors: {
        'listFiles': _i1.MethodConnector(
          name: 'listFiles',
          params: {
            'directoryPath': _i1.ParameterDescription(
              name: 'directoryPath',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformioFile'] as _i6.PlatformioFileEndpoint)
                  .listFiles(
            session,
            params['directoryPath'],
          ),
        ),
        'readFile': _i1.MethodConnector(
          name: 'readFile',
          params: {
            'filePath': _i1.ParameterDescription(
              name: 'filePath',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformioFile'] as _i6.PlatformioFileEndpoint)
                  .readFile(
            session,
            params['filePath'],
          ),
        ),
        'writeFile': _i1.MethodConnector(
          name: 'writeFile',
          params: {
            'filePath': _i1.ParameterDescription(
              name: 'filePath',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformioFile'] as _i6.PlatformioFileEndpoint)
                  .writeFile(
            session,
            params['filePath'],
            params['content'],
          ),
        ),
        'createDirectory': _i1.MethodConnector(
          name: 'createDirectory',
          params: {
            'directoryPath': _i1.ParameterDescription(
              name: 'directoryPath',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformioFile'] as _i6.PlatformioFileEndpoint)
                  .createDirectory(
            session,
            params['directoryPath'],
          ),
        ),
        'deleteFileOrDirectory': _i1.MethodConnector(
          name: 'deleteFileOrDirectory',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'recursive': _i1.ParameterDescription(
              name: 'recursive',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['platformioFile'] as _i6.PlatformioFileEndpoint)
                  .deleteFileOrDirectory(
            session,
            params['path'],
            params['recursive'],
          ),
        ),
      },
    );
    connectors['urlShortener'] = _i1.EndpointConnector(
      name: 'urlShortener',
      endpoint: endpoints['urlShortener']!,
      methodConnectors: {
        'createShortUrl': _i1.MethodConnector(
          name: 'createShortUrl',
          params: {
            'longUrl': _i1.ParameterDescription(
              name: 'longUrl',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['urlShortener'] as _i7.UrlShortenerEndpoint)
                  .createShortUrl(
            session,
            params['longUrl'],
          ),
        )
      },
    );
  }
}
