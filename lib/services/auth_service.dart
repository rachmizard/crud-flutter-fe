import 'dart:convert';

import 'package:frontend/models/token_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/request_adapter_service.dart';

class AuthService extends RequestAdapterService {
  Future<TokenModel> login(String email, String password) async {
    try {
      final response = await super.sendPostRequest(
        '/api/auth/signin',
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode != 200) {
        Map<String, dynamic> error = json.decode(response.body);

        String errorMessage = error['message'];

        return Future.error(errorMessage);
      }

      return TokenModel.fromJson(json.decode(response.body));
    } catch (e) {
      print("error: $e");
      throw Exception('AuthService:login ${e.toString()}');
    }
  }

  Future<TokenModel> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await super.sendPostRequest(
        '/api/auth/signup',
        body: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode != 200) {
        Map<String, dynamic> error = json.decode(response.body);

        String errorMessage = error['message'];

        return Future.error(errorMessage);
      }

      return TokenModel.fromJson(json.decode(response.body));
    } catch (e) {
      print("error: $e");
      throw Exception('AuthService:login ${e.toString()}');
    }
  }

  Future<UserModel> getProfile(String token) async {
    try {
      final response = await super.sendPostRequest('/api/auth/me', headers: {
        'Authorization': token,
      });

      if (response.statusCode != 200) {
        Map<String, dynamic> error = json.decode(response.body);

        String errorMessage = error['message'];

        return Future.error(errorMessage);
      }

      var data = jsonDecode(response.body);

      return UserModel.fromJson(data["user"]);
    } catch (e) {
      print("error: $e");
      throw Exception('AuthService:getProfile ${e.toString()}');
    }
  }
}
