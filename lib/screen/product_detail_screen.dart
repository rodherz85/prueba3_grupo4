import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_3/providers/product_form_provider.dart';
import 'package:prueba_3/screen/edit_product_screen.dart';
import 'package:prueba_3/services/producto_service_2.dart';
import 'package:prueba_3/theme/my_theme.dart';
import 'package:prueba_3/widgets/example_product_list_rest.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product =
        ModalRoute.of(context)!.settings.arguments as ExampleProductListRest;
    final productService = Provider.of<ProductService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Producto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete,
                color: Colors.black), // Cambia a rojo para probar
            onPressed: () async {
              await productService.deleteProduct(product, context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  'home',
                  (Route<dynamic> route) =>
                      false); // Regresar a la lista de productos
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${product.nombre}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Descripción: ${product.descripcion}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Precio: \$${product.precio}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Stock: ${product.stock}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  productService.SelectProduct = product;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (_) => ProductFormProvider(product),
                          child: ProductFormScreen(),
                        ),
                      ));
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(MyTheme.primary),
                ),
                child: const Text(
                  'Editar Producto',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
