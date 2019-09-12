import '../repositories/dog_repository.dart';
import '../models/dog.dart';

class _HomeBloc {
  Future<bool> removeDog(int id) async {
    return await repositoryDog.delete(id);
  }

  Future<List<Dog>> getAllDogs() async {
    return await repositoryDog.selectAll();
  }
}

final homeBloc = _HomeBloc();
