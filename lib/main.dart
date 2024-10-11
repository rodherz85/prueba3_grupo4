import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_3/routes/app_routes.dart';
import 'package:prueba_3/services/auth_service.dart';
import 'package:prueba_3/theme/my_theme.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ejemplo Prueba 3',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerationRoute,
      theme: MyTheme.myTheme,
    );
  }
}
