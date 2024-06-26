import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:turismapp/controller/api.dart';

Future<Map<String, dynamic>> login(String username, String password) async {
  try {
    final response = await http.post(
      Uri.parse(API_url_login),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data);
      return data;
    } else {
      final Map<String, dynamic> data = json.decode(response.body);
      return {"error": data["message"]};
    }
  } catch (e) {
    print(e);
    return {"error": e};
  }
}

Future<Map<String, dynamic>> register(String username, String email, String password, String confirmPassword) async {
  if (password != confirmPassword) {
    return {"error": "Passwords do not match"};
  } else {
    final body = jsonEncode(<String, String>{
      'username': username,
      'password': password,
      'email': email,
    });

    try {
      final response = await http.post(
        Uri.parse(API_url_register),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        final Map<String, dynamic> data = json.decode(response.body);
        return {"error": data["message"]};
      }
    } catch (e) {
      print(e);
      return {"error": e};
    }
  }
}

Future<bool> saveMobileToken(String token, int user_id) async {
  // Ver si el token ya está guardado
  try {
    final response = await http.get(
      Uri.parse(API_url_notifications_get + user_id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data["code_phone"] == token) {
        return true;
      }
    }
  } catch (e) {
    print(e);
  }

  final body = jsonEncode(<String, dynamic>{
    'code_phone': token,
    'user_id': user_id,
  });

  try {
    final response = await http.post(
      Uri.parse(API_url_notifications_save),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}