import 'package:flutter/material.dart';
import 'package:prueba_3/widgets/example_product_list_rest.dart'; // Modelo del producto

class ProductFormProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ExampleProductListRest product;

  ProductFormProvider(this.product);

  void updateProduct(
      {String? nombre, String? descripcion, int? precio, int? stock}) {
    product = product.copiarProducto(
      nombre: nombre ?? product.nombre,
      descripcion: descripcion ?? product.descripcion,
      precio: precio ?? product.precio,
      stock: stock ?? product.stock,
    );
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
