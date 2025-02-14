import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static late final SharedPreferences _prefs;
  static const String _tokenKey = 'auth_token';

  String? get token => getToken();

  static bool initialized = false;

  // Make constructor take SharedPreferences instance
  TokenManager._();

  static final TokenManager _instance = TokenManager._();

  static Future<TokenManager> getInstance() async {
    if (initialized == false) {
      _prefs = await SharedPreferences.getInstance();
      initialized = true;
    }
    return _instance;
  }

  // Token management methods
  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    await _prefs.remove(_tokenKey);
  }
}
