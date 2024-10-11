import 'package:flutter/material.dart';
import 'package:prueba_3/screen/register_user_screen.dart';
import '../screen/screen.dart';

class AppRoutes {
  static const initialRoute = 'login';
  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext contex) => const LoginScreen(),
    'add_user': (BuildContext contex) => const RegisterUserScreen(),
    'error': (BuildContext contex) => const ErrorScreen(),
  };

  static Route<dynamic> onGenerationRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const ErrorScreen());
  }
}
