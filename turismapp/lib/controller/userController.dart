import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
        Uri.parse(API_url_user),
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

Future<bool> logout() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final refresh = prefs.getString('refresh');

  try {
    final response = await http.post(
      Uri.parse(API_url_logout),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: jsonEncode(<String, String>{
        'refresh': refresh!,
      }),
    );

    if (response.statusCode == 200) {
      prefs.remove('refresh');
      prefs.remove('user_info');
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> saveMobileToken(String token, int userId) async {
  try {
    final response = await http.get(
      Uri.parse(API_url_notifications_get + userId.toString()),
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
    'user_id': userId,
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

Future<Map<String, dynamic>> getUserInfo(int userId) async {
  try {
    final response = await http.get(
      Uri.parse("$API_url_user$userId/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
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