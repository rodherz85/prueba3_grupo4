import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_3/providers/product_form_provider.dart';
import 'package:prueba_3/screen/edit_product_screen.dart';
import 'package:prueba_3/screen/list_product_screen.dart';
import 'package:prueba_3/screen/product_detail_screen.dart';
import 'package:prueba_3/services/auth_service.dart';
import 'package:prueba_3/services/producto_service_2.dart';
import 'package:prueba_3/theme/my_theme.dart';
import 'package:prueba_3/widgets/example_product_list_rest.dart';
import 'package:prueba_3/screen/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductService()),
        ChangeNotifierProvider(create: (_) => AuthService())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD Firestore',
      theme: MyTheme.myTheme,
      initialRoute: 'login',
      routes: {
        'login': (_) => LoginScreen(),
        'home': (_) => ListProductScreen(),
        'edit': (context) {
          final productService =
              Provider.of<ProductService>(context, listen: false);
          final product = productService.SelectProduct ??
              ExampleProductListRest(
                  id: '', descripcion: '', nombre: '', precio: 0, stock: 0);
          return ChangeNotifierProvider(
            create: (_) => ProductFormProvider(product),
            child: ProductFormScreen(),
          );
        },
        'detail': (context) =>
            ProductDetailScreen(), // Registrar la ruta para la pantalla de detalles
      },
    );
  }
}
