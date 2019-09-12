import 'package:sqflite/sqflite.dart';

import '../table_names.dart';

class _Migration002 {
  execute(Database db) async {
    await db.execute(
        "CREATE TABLE $user_name (id INTEGER PRIMARY KEY, usuario VARCHAR, contrasena VARCHAR)");
  }
}

final migration002 = _Migration002();
