import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turismapp/controller/api.dart';

Future<List<Map<String, dynamic>>> getProductsByCategory(int id) async {
  try {
    final response = await http.get(Uri.parse(API_url_categories_product + id.toString()));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((product) => {
        'id': product['id'],
        'name': product['name'],
        'price': product['price'],
        'image': product['image']
      }).toList();
    } else {
      // Si la respuesta no tiene éxito, devuelve una lista vacía
      return [];
    }
  } catch (e) {
    // En caso de error, devuelve una lista vacía
    return [];
  }
}


Future<List> getProduct(int id) async {
  try {
    final response = await http.get(Uri.parse('$API_url_products/${id.toString()}'));
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((product) => {
      'id': product['id'],
      'name': product['name'],
      'description': product['description'],
      'price': product['price'],
      'image': product['image']
    }).toList();
  } catch (e) {
    return [];
  }
}