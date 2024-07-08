import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turismapp/controller/api.dart';

Future<bool> payment(
  double total,
  int user_id,
  String first_name,
  String last_name,
  String email,
  String location,
  String phone,

  List<Map<String, dynamic>> cartItems,
) async {
  try {
    final date = DateTime.now();
    // AAAA-MM-DD
    final response = await http.post(
      Uri.parse(API_url_bill),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'date': date.toString(),
        'total': total,
        'user_id': user_id,
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'location': location,
        'phone': phone,
      }),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['bill'];
      print(data);
      final id_header = data['id'];

      for (var item in cartItems) {
        final response = await http.post(
          Uri.parse(API_url_bill_detail),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'bill_id': id_header,
            'product_id': item['id'],
            'quantity': item['quantity'],
          }),
        );
        if (response.statusCode != 201) {
          return false;
        }
      }
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}