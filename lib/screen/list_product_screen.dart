import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_3/screen/loading_screen.dart';
import 'package:prueba_3/services/producto_service_2.dart';
import 'package:prueba_3/theme/my_theme.dart';
import 'package:prueba_3/widgets/example_product_list_rest.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    if (productService.isLoading) return const LoadingScreen();

    final filteredProducts = productService.products.where((product) {
      return product.nombre.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Productos'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 400,
              height: 45,
              child: TextField(
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  hintText: 'Buscar productos...',
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
              ),
            ),
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];
          return ListTile(
            leading: const Icon(
              Icons.inventory,
              color: MyTheme.primary,
            ),
            title: Text(product.nombre),
            subtitle: Text('${product.descripcion} - \$${product.precio}'),
            trailing: Text('Stock: ${product.stock}'),
            onTap: () {
              Navigator.pushNamed(context, 'detail',
                  arguments: product); // Asegúrate de que la ruta sea 'detail'
            },
          );
        },
        separatorBuilder: (_, __) => const Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          productService.SelectProduct = ExampleProductListRest(
              id: '',
              descripcion: '',
              nombre: '',
              precio: 0,
              stock: 0); // Reset SelectProduct
          Navigator.pushNamed(context, 'edit');
        },
      ),
    );
  }
}
