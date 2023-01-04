import 'dart:convert';

import 'package:frontend/models/token_model.dart';
import 'package:frontend/services/request_adapter_service.dart';

class AuthService extends RequestAdapterService {
  Future<TokenModel> login(String email, String password) async {
    try {
      final response = await super.sendPostRequest(
        '/api/auth/signin',
        {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode != 200) {
        Map<String, dynamic> error = json.decode(response.body);

        String errorMessage = error['message'];

        return Future.error(errorMessage);
      }

      return TokenModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      print("error: $e");
      throw Exception('AuthService:login ${e.toString()}');
    }
  }
}
