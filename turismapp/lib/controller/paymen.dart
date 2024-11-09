import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turismapp/controller/api.dart';

Future<bool> payment(
  double total,
  int userId,
  String firstName,
  String lastName,
  String email,
  String location,
  String phone,
  List<Map<String, dynamic>> cartItems,
) async {
  String message = '''
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="UTF-8">
    <title>Gracias por su compra</title>
    <style>
      body {
        font-family: Arial, sans-serif;
      }
      h1, h2 {
        color: #333;
      }
      ul {
        list-style-type: none;
        padding: 0;
      }
      li {
        padding: 5px 0;
      }
    </style>
  </head>
  <body>
    <h1>Gracias por su compra</h1>
    <p>Detalles de la compra:</p>
    <p><strong>Total:</strong> $total</p>
    <p><strong>Nombre:</strong> $firstName $lastName</p>
    <p><strong>Email:</strong> $email</p>
    <p><strong>Ubicación:</strong> $location</p>
    <p><strong>Teléfono:</strong> $phone</p>
    <h2>Productos</h2>
    <ul>
  ''';

  try {
    final date = DateTime.now();
    // Formato AAAA-MM-DD
    final response = await http.post(
      Uri.parse(API_url_bill),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'date': date.toString(),
        'total': total,
        'user_id': userId,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'location': location,
        'phone': phone,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['bill'];
      final idHeader = data['id'];

      for (var item in cartItems) {
        await http.post(
          Uri.parse(API_url_bill_detail),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'bill_id': idHeader,
            'product_id': item['id'],
            'quantity': item['quantity'],
          }),
        );

        message += '''
        <li>${item['name']} - ${item['quantity']}</li>
        ''';
      }

      message += '''
      </ul>
      </body>
      </html>
      ''';

      try {
        await http.post(
          Uri.parse(API_url_email),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'email': email,
            'subject': 'Compra realizada',
            'message': message,
          }),
        );
      } catch (e) {
        return false;
      }
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}