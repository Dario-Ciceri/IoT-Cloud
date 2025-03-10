import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart';

final GetIt sl = GetIt.instance;

@InjectableInit()
void configureDependencies({Environment? enviroment}) {
  WidgetsFlutterBinding.ensureInitialized();
  sl.init(environment: enviroment?.name);
}

T resolve<T extends Object>() => sl<T>();
