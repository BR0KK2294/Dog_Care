import 'package:dog_care1/src/services/shared_preferences.dart';

class _UserRepository {
  Future<String> getToken() async {
    return await sharedPref.getToken();
  }
}

final repositoryUser = _UserRepository();
