import 'package:sqflite/sqflite.dart';

import '../table_names.dart';

class _Migration001 {
  execute(Database db) async {
    await db.execute(
        "CREATE TABLE $dog_name (id INTEGER PRIMARY KEY, nombre VARCHAR, raza VARCHAR, edad INTEGER, desc VARCHAR, dueno VARCHAR, fono_dueno INTEGER)");
  }
}

final migration001 = _Migration001();
