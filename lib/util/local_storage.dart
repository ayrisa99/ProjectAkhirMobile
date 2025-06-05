import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _userBoxName = 'usersBox';
  static const String _sessionBoxName = 'sessionBox';

  static const String _sessionKey = 'session';
  static const String _usernameKey = 'username';

  String selectedCurrency = 'IDR';
  double currencyRate = 1.0; // default: 1 untuk IDR

  double convertPrice(double price) {
    return price * currencyRate;
  }

  // ===== USER =====

  // Register user simpan username dan password (plain text, bisa dikembangkan hashing)
  static Future<void> register(String username,String email, String password, String profile) async {
    var userBox = Hive.box(_userBoxName);
    await userBox.put(username, password);

    // Menyimpan data di SharedPreferences juga
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('profile', profile);
  }

  // Cek apakah user sudah terdaftar
  static Future<bool> isUserRegistered(String username) async {
    var userBox = Hive.box(_userBoxName);
    return userBox.containsKey(username);
  }

  // Validasi login user dan password
  static Future<bool> validateLogin(String username, String password) async {
    var userBox = Hive.box(_userBoxName);
    final storedPassword = userBox.get(username);
    return storedPassword != null && storedPassword == password;
  }

  // ===== SESSION =====

  // Simpan status login dan username
  static Future<void> login(String username) async {
    var sessionBox = Hive.box(_sessionBoxName);
    await sessionBox.put(_sessionKey, true);
    await sessionBox.put(_usernameKey, username);
  }

  // Hapus status login
  static Future<void> logout() async {
    var sessionBox = Hive.box(_sessionBoxName);
    await sessionBox.put(_sessionKey, false);
    await sessionBox.delete(_usernameKey);
  }

  // Cek apakah user sedang login
  static Future<bool> checkSession() async {
    var sessionBox = Hive.box(_sessionBoxName);
    return sessionBox.get(_sessionKey, defaultValue: false);
  }

  // Ambil username dari session
  static Future<String?> getUsername() async {
    var sessionBox = Hive.box(_sessionBoxName);
    return sessionBox.get(_usernameKey);
  }
  
}
