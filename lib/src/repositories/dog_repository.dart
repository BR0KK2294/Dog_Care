import '../models/dog.dart';
import '../services/database/table_names.dart';
import '../services/database/database_provider.dart';

class _DogRepository {
  //obtiene todos los perros de la BD
  Future<List<Dog>> selectAll() async {
    final queryResponse = await db.selectAll(dog_name);

    final arrayDogs = queryResponse.isNotEmpty
        ? queryResponse.map((d) => Dog.fromJsonDB(d)).toList()
        : List<Dog>();

    return arrayDogs;
  }

  //obtiene 1 perro de la BD
  Future<Dog> select(int id) async {
    final mapResponse = await db.select(id, dog_name);
    if (mapResponse == null) {
      print("Perro no existe en la BD");
      return null;
    }

    return Dog.fromJsonDB(mapResponse);
  }

  //borrar 1 perro de la BD
  Future<bool> delete(int id) async {
    final mapResponse = await db.delete(id, dog_name);
    if (mapResponse == null) {
      print("Perro no existe en la BD");
      return false;
    }
    return true;
  }

  //guardar un perro en la BD
  save(Dog dog) async {
    await db.exist(dog.id, dog_name)
        ? await db.update(dog.toJsonDB(), dog_name)
        : await db.insert(dog.toJsonDB(), dog_name);
  }

  Dog create(
      {int id,
      String nombre,
      String raza,
      int edad,
      String desc,
      String dueno,
      int fonoDueno}) {
    Dog newDog = Dog(
        id: id,
        nombre: nombre,
        raza: raza,
        edad: edad,
        desc: desc,
        dueno: dueno,
        fonoDueno: fonoDueno);

    return _validate(newDog) ? newDog : null;
  }

  bool _validate(Dog dog) {
    if (dog.nombre == null || dog.nombre.isEmpty) return false;

    if (dog.raza == null) return false;

    if (dog.edad == null || dog.edad <= 0) return false;

    if (dog.desc == null || dog.desc.isEmpty) return false;

    if (dog.dueno == null || dog.dueno.isEmpty) return false;

    if (dog.fonoDueno == null || dog.fonoDueno.toString().length < 8)
      return false;

    return true;
  }
}

final repositoryDog = _DogRepository();
