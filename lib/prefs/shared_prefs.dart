import 'package:shared_preferences/shared_preferences.dart';

enum prefkey {
  logged,
  name,
  email,
  id,
  password,
}

class SharedPrefController {
  static final SharedPrefController _instance =
      SharedPrefController._internal();
  late SharedPreferences _sharedPreferences;

  SharedPrefController._internal();

  factory SharedPrefController() {
    return _instance;
  }

  Future<void> initSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required String name, required String email}) async {
    await _sharedPreferences.setBool(prefkey.logged.toString(), true);
    await _sharedPreferences.setString(prefkey.name.toString(), name);
    await _sharedPreferences.setString(prefkey.email.toString(), email);
  }

  Future<void> savePassword({required String password}) async {
    await _sharedPreferences.setString(prefkey.password.toString(), password);
  }

  Future<void> saveId({
    required String id,
  }) async {
    await _sharedPreferences.setString(prefkey.id.toString(), id);
  }

  String get getId => _sharedPreferences.getString(prefkey.id.toString()) ?? "";

  Future<void> saveLogin() async {
    await _sharedPreferences.setBool(prefkey.logged.toString(), true);
  }

  bool get logged =>
      _sharedPreferences.getBool(prefkey.logged.toString()) ?? false;

  String get name =>
      _sharedPreferences.getString(prefkey.name.toString()) ?? 'no name';

  String get email =>
      _sharedPreferences.getString(prefkey.email.toString()) ?? 'no email';

  String get password =>
      _sharedPreferences.getString(prefkey.password.toString()) ?? '';

  Future<bool> logout() async {
    await _sharedPreferences.remove(prefkey.name.toString());
    await _sharedPreferences.remove(prefkey.email.toString());
    return await _sharedPreferences.setBool(prefkey.logged.toString(), false);
  }
}
