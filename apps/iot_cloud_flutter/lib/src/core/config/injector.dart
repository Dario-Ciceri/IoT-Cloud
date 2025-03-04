import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart'; // Sarà generato automaticamente

final GetIt sl = GetIt.instance;

@InjectableInit()
void configureDependencies({String? enviroment}) {
  sl.init(
    environment: enviroment,
  );
}

T resolve<T extends Object>() => sl<T>();
