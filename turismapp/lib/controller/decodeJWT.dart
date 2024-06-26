import 'package:jwt_decoder/jwt_decoder.dart';

Map<String, dynamic> decodeJWT(String token) {
  try {
    final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken;
  } catch (e) {
    return {"error": e};
  }
}