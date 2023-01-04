import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileStore with ChangeNotifier {
  final authService = AuthService();

  UserModel? _user;

  UserModel? get user => _user;

  ProfileStore() {
    getProfileStoreFromSharedPref();
  }

  Future<void> getProfileStoreFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      await getProfile(token);
    }
  }

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  Future<UserModel> getProfile(String token) async {
    try {
      final user = await authService.getProfile(token);
      this.user = user;

      return user;
    } catch (e) {
      print("error: $e");
      throw Exception('ProfileStore:getProfile ${e.toString()}');
    }
  }
}
