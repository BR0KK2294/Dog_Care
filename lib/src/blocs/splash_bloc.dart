import 'package:dog_care1/src/repositories/user_repository.dart';

class SplashBloc {
  Future<bool> isLogged() async {
    final token = repositoryUser.getToken();
    if (token == '') {
      return false;
    }
    return true;
  }
}

final splashBloc = SplashBloc();
