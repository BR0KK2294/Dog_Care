import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final _toke = 'token';
  final prefs = SharedPreferences.getInstance();

  setToken(String newtoken) async {
    final sp = await prefs;
    print("token saved");
  }

  Future<String> getToken() async {
    final sp = await prefs;
    return sp.getString(_toke) ?? '';
  }

  //Elimina todos los sharedPreferences
  cleanData() async {
    final sp = await prefs;
    sp.clear();
  }
}

final sharedPref = SharedPref();
