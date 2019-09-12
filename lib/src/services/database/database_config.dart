import 'dart:async';
import 'dart:io' show Directory;

import 'migrations/migration_001.dart';
import 'migrations/migration_002.dart';
import 'migrations/migration_003.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:sqflite/sqflite.dart';

class DatabaseConfig {
  //singleton
  DatabaseConfig._();
  static final db = DatabaseConfig._();

  //Database Instance
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  static deleteDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "cacheDB.db");
    _database?.close();
    deleteDatabase(path);
    _database = null;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "cacheDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await migration001.execute(db);
      await migration002.execute(db);
      await migration003.execute(db);
    });
  }
}
