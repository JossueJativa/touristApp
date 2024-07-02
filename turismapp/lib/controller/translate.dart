import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turismapp/controller/api.dart';

Future<String> translate(String text, String from_lagn, String to_lang) async {
  try {
    final response = await http.post(
      Uri.parse(API_url_translate),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'text': text,
        'from': from_lagn,
        'to': to_lang,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)[0]['new_text'];
    } else {
      return 'Error';
    }
  } catch (e) {
    return 'Error';
  }
}