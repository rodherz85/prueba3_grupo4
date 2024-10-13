import 'package:flutter/material.dart';
import 'package:prueba_3/screen/edit_product_screen.dart';
import 'package:prueba_3/screen/list_product_screen.dart';
import 'package:prueba_3/screen/product_detail_screen.dart';
import 'package:prueba_3/screen/register_user_screen.dart';
import '../screen/screen.dart';

class AppRoutes {
  static const initialRoute = 'login';
  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext contex) => const LoginScreen(),
    'add_user': (BuildContext contex) => const RegisterUserScreen(),
    'error': (BuildContext contex) => const ErrorScreen(),
    'list_products': (BuildContext context) => const ListProductScreen(),
    'edit': (BuildContext context) => ProductFormScreen(),
    'detail': (BuildContext context) => ProductDetailScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const ErrorScreen());
  }
}
