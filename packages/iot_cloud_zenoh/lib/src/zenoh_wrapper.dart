import 'dart:ffi' as ffi;

// Definizioni corrette dei tipi per Zenoh C API
typedef Z_Open_C = ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void> config);
typedef Z_Open_Dart =
    ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void> config);

class ZenohLib {
  late ffi.DynamicLibrary _zenohLib;
  late Z_Open_Dart _zOpen;

  ZenohLib() {
    try {
      _zenohLib = ffi.DynamicLibrary.open('/usr/local/lib/zenoh/libzenohc.so');
      print('Zenoh library loaded successfully');

      // Carica la funzione corretta z_open
      _zOpen =
          _zenohLib
              .lookup<ffi.NativeFunction<Z_Open_C>>('z_open')
              .asFunction<Z_Open_Dart>();

      print('Zenoh functions loaded successfully');
    } catch (e) {
      print('Failed to load Zenoh library: $e');
    }
  }

  // Wrapper per z_open
  ffi.Pointer<ffi.Void> openSession(ffi.Pointer<ffi.Void> config) {
    return _zOpen(config);
  }
}
