import '../functions.dart';
import '../repositories/dog_repository.dart';
import '../models/dog.dart';
import 'package:flutter/widgets.dart';

class _NewDogBloc {
  // Respuestas formulario
  int idDog;
  TextEditingController nombreCtrl;
  String raza;
  TextEditingController edadCtrl;
  TextEditingController descCtrl;
  TextEditingController duenoCtrl;
  TextEditingController fonoCtrl;

  initState() {
    nombreCtrl = TextEditingController();
    edadCtrl = TextEditingController();
    descCtrl = TextEditingController();
    duenoCtrl = TextEditingController();
    fonoCtrl = TextEditingController();
  }

  Future<bool> saveDog() async {
    Dog newDog = repositoryDog.create(
        id: idDog,
        nombre: nombreCtrl.text,
        raza: raza,
        edad: isNumeric(edadCtrl.text) ? int.parse(edadCtrl.text) : null,
        desc: descCtrl.text,
        dueno: duenoCtrl.text,
        fonoDueno: isNumeric(fonoCtrl.text) ? int.parse(fonoCtrl.text) : null);
    if (newDog == null) return false;

    await repositoryDog.save(newDog);

    clean();
    return true;
  }

  clean() {
    idDog = null;
    nombreCtrl = null;
    raza = null;
    edadCtrl = null;
    descCtrl = null;
    duenoCtrl = null;
    fonoCtrl = null;
  }
}

final newDogBloc = _NewDogBloc();
