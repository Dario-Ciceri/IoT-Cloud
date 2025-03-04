import 'package:flutter/material.dart';
import 'package:iot_cloud_flutter/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:provider/provider.dart';

import 'package:iot_cloud_flutter/src/core/config/config.dart';
import 'package:iot_cloud_flutter/src/core/constants/constants.dart';
import 'package:iot_cloud_flutter/src/core/routes/router.dart';

import 'src/core/theme/theme.dart';

void main() {
  configureDependencies(enviroment: environment);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: IotCloudApp(
        appRouter: resolve<AppRouter>(),
      ),
    ),
  );
}

class IotCloudApp extends StatelessWidget {
  const IotCloudApp({
    super.key,
    required this.appRouter,
  });
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
      theme: lightTheme, // Importa questi temi dal tuo file di tema
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
    );
  }
}
