import 'package:flutter/foundation.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStore with ChangeNotifier, DiagnosticableTreeMixin {
  final authService = AuthService();

  bool _isAuthenticated = false;
  String? _token;

  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;

  AuthStore() {
    getAuthSharedPrefs();
  }

  getAuthSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    _token = prefs.getString('token');

    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await authService.login(email, password);

      _isAuthenticated = true;
      _token = response.token;

      setTokenSharedPrefs("token");
      setIsAuthenticatedSharedPrefs(true);
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String name}) async {
    try {
      _isAuthenticated = true;
      _token = 'token';

      setTokenSharedPrefs('token');
      setIsAuthenticatedSharedPrefs(true);

      notifyListeners();
    } catch (e) {
      throw UnimplementedError("Error: $e");
    }
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _token = null;

    removeTokenSharedPrefs();
    setIsAuthenticatedSharedPrefs(true);

    notifyListeners();
  }

  removeTokenSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('token');
  }

  setTokenSharedPrefs(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('token', token);
  }

  setIsAuthenticatedSharedPrefs(bool authenticated) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isAuthenticated', authenticated);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(StringProperty('token', token, ifEmpty: 'null', showName: true));
    properties.add(FlagProperty('isAuthenticated',
        value: isAuthenticated,
        ifTrue: 'Authenticated',
        ifFalse: 'Not Authenticated'));
  }
}
