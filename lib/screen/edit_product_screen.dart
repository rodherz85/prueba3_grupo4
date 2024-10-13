import 'package:flutter/material.dart';
import 'package:prueba_3/providers/product_form_provider.dart';

import 'package:provider/provider.dart';
import 'package:prueba_3/services/producto_service_2.dart';
import 'package:prueba_3/theme/my_theme.dart';

class ProductFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final productFormProvider = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Crear/Editar Producto'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: productFormProvider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              _buildTextField(
                label: 'Nombre',
                initialValue: productFormProvider.product.nombre,
                onChanged: (value) =>
                    productFormProvider.updateProduct(nombre: value),
              ),
              _buildTextField(
                label: 'Descripción',
                initialValue: productFormProvider.product.descripcion,
                onChanged: (value) =>
                    productFormProvider.updateProduct(descripcion: value),
              ),
              _buildTextField(
                label: 'Precio',
                initialValue: productFormProvider.product.precio.toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) => productFormProvider.updateProduct(
                    precio: value.isEmpty ? 0 : int.parse(value)),
              ),
              _buildTextField(
                label: 'Stock',
                initialValue: productFormProvider.product.stock.toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) => productFormProvider.updateProduct(
                    stock: value.isEmpty ? 0 : int.parse(value)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (!productFormProvider.isValidForm()) return;
                  await productService
                      .editOrCreateProduct(productFormProvider.product);
                  await productService
                      .loadProducts(); // Actualizar la lista de productos
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      'home', (Route<dynamic> route) => false);
                },
                style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll<Color>(MyTheme.primary),
                ),
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio';
          }
          if (keyboardType == TextInputType.number &&
              int.tryParse(value) == null) {
            return 'Ingrese un número válido';
          }
          return null;
        },
      ),
    );
  }
}
