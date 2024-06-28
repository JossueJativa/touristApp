import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turismapp/controller/api.dart';

Future<List<Map<String, dynamic>>> getCategories() async {
  try {
    final response = await http.get(Uri.parse(API_url_categories));
    final List<dynamic> data = jsonDecode(response.body);

    // Convertir la lista de categorías en una lista de mapas con 'id' y 'name'
    return data.map((category) => {
      'id': category['id'],
      'name': category['name']
    }).toList();
  } catch (e) {
    return [];
  }
}
