// To parse this JSON data, do
//
//     final exampleProductListRest = exampleProductListRestFromJson(jsonString);
class Listado {
  final List<ExampleProductListRest> listadoProductos;

  Listado({required this.listadoProductos});

  factory Listado.fromJson(Map<String, dynamic> json) {
    final List<dynamic> productosJson = json['documents'] as List<dynamic>;

    return Listado(
      listadoProductos: productosJson.map((producto) {
        final data = producto['fields'];
        return ExampleProductListRest.fromMap({
          'id': producto['name'].split('/').last, //
          'descripcion': data['descripcion']['stringValue'],
          'nombre': data['nombre']['stringValue'],
          'precio': int.parse(data['precio']['integerValue']),
          'stock': int.parse(data['stock']['integerValue']),
        });
      }).toList(),
    );
  }
}

class ExampleProductListRest {
  final String id;
  final String descripcion;
  final String nombre;
  final int precio;
  final int stock;

  ExampleProductListRest({
    required this.id,
    required this.descripcion,
    required this.nombre,
    required this.precio,
    required this.stock,
  });

  ExampleProductListRest copiarProducto({
    String? id,
    String? descripcion,
    String? nombre,
    int? precio,
    int? stock,
  }) {
    return ExampleProductListRest(
      id: id ??
          this.id, // Usa el nuevo id si se proporciona, de lo contrario, usa el actual
      descripcion: descripcion ?? this.descripcion,
      nombre: nombre ?? this.nombre,
      precio: precio ?? this.precio,
      stock: stock ?? this.stock,
    );
  }

  factory ExampleProductListRest.fromMap(Map<String, dynamic> json) {
    return ExampleProductListRest(
      id: json['id'] ?? '',
      descripcion: json['descripcion'] ?? '',
      nombre: json['nombre'] ?? '',
      precio: int.parse(
          json['precio']?.toString() ?? '0'), // Manejo de posibles null
      stock: int.parse(
          json['stock']?.toString() ?? '0'), // Manejo de posibles null
    );
  }
}
