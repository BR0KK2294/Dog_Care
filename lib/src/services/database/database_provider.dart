import 'database_config.dart';

class DatabaseProvider {
  final dbReference = DatabaseConfig.db;

  deleteAllData() async {
    await DatabaseConfig.deleteDB();
  }

  Future<Map<String, dynamic>> select(int id, String nameTable) async {
    /// Retorna un elemento de la BD
    /// según tipo de tabla ingresada
    print("id: $id $nameTable");
    if (id == null) return null;
    if (id <= 0) return null;

    final db = await dbReference.database;
    var res = await db.rawQuery("SELECT * FROM $nameTable WHERE id = $id");
    print(res);
    return res.isNotEmpty ? res.first : null;
  }

  Future<List> selectAll(String nameTable) async {
    /// Retorna todos los elementos de la BD
    /// segun tipo de tabla ingresada
    print("select all " + nameTable);
    final db = await dbReference.database;
    var list = await db.rawQuery("SELECT * FROM $nameTable ORDER BY id DESC");

    print("response DB: " + list.toString());
    return list;
  }

  Future<Map<String, dynamic>> selectFromIdAPI(
      int idApi, String nameTable) async {
    /// Retorna un elemento de la BD
    /// según tipo de tabla ingresada
    print("id: $idApi $nameTable");
    if (idApi == null) return null;
    if (idApi <= 0) return null;

    final db = await dbReference.database;
    var res =
        await db.rawQuery("SELECT * FROM $nameTable WHERE id_api = $idApi");
    print(res);
    return res.isNotEmpty ? res.first : null;
  }

  Future<List> selectAllActualMonth(String nameTable) async {
    /// Retorna todos los elementos de la BD
    /// segun tipo de tabla ingresada
    /// que sean del mes acutal
    print("select all " + nameTable);
    String nameVar = "created_date";

    final db = await dbReference.database;
    var list = await db.rawQuery(
        "SELECT * FROM $nameTable WHERE $nameVar > date('now', 'start of month')");

    print("response DB: " + list.toString());
    return list;
  }

  Future<List> selectNoSyncroData(String nameTable) async {
    /// Retorna todos los datos que no estan sincronizados
    /// Los que pueden ser: Finding, Evidence, CheckList
    final db = await dbReference.database;
    print("select all $nameTable no syncro");
    final list = await db
        .rawQuery("SELECT * FROM $nameTable WHERE syncro = 0 ORDER BY id DESC");

    print("response DB: " + list.toString());
    return list;
  }

  Future<Map<String, dynamic>> selectLast(String nameTable) async {
    /// Retorna un elemento de la BD
    /// según tipo de tabla ingresada
    final id = await _getLastId(nameTable);
    print("id: $id $nameTable");
    if (id == null) return null;
    if (id <= 0) return null;

    final db = await dbReference.database;
    var res = await db.query(nameTable, where: "id = ?", whereArgs: [id]);

    return res.isNotEmpty ? res.first : null;
  }

  Future<int> insert(Map<String, dynamic> data, String nameTable) async {
    /// Inserta un elemento en la BD
    final db = await dbReference.database;
    print("insert init");

    await db.insert(nameTable, data);
    final id = await _getLastId(nameTable) ?? 0;

    print("insert response " + id.toString());
    return id;
  }

  Future<int> update(Map<String, dynamic> data, String nameTable) async {
    // Modifica un elemento de la BD
    final db = await dbReference.database;
    var res;

    res = await db
        .update(nameTable, data, where: "id = ?", whereArgs: [data["id"]]);

    return res;
  }

  Future<int> delete(int id, String nameTable) async {
    /// Elimina un elemento de la BD
    if (id <= 0) return null;

    final db = await dbReference.database;
    var result = await db.delete(nameTable, where: "id = ?", whereArgs: [id]);

    return result;
  }

  Future<int> deleteAll(String nameTable) async {
    /// Elimina todos los elementos de la tabla recibida
    final db = await dbReference.database;
    var result = await db.delete(nameTable);

    return result;
  }

  Future<bool> exist(int id, String nameTable, {int idApi}) async {
    /// retorna True o False si el elemento existe en la BD

    if (id == null || id <= 0) {
      if (idApi != null) {
        final db = await dbReference.database;
        final resultApi =
            await db.query(nameTable, where: "id_api = ?", whereArgs: [idApi]);

        return resultApi.isNotEmpty;
      } else
        return false;
    }

    final db = await dbReference.database;
    final result = await db.query(nameTable, where: "id = ?", whereArgs: [id]);

    return result.isNotEmpty;
  }

  Future<int> existSyncro(int id, String nameTable) async {
    /// Retorna:
    /// 0 si no existe
    /// 1 si existe pero no esta sincronizado
    /// 2 si existe y esta sincronizado
    if (id == null) return 0;
    if (id <= 0) return 0;

    final db = await dbReference.database;
    var result = await db.query(nameTable, where: "id = ?", whereArgs: [id]);

    if (result.isNotEmpty) {
      final syncro = result.first["syncro"];
      if (syncro == 1)
        return 2;
      else
        return 1;
    }

    return 0;
  }

  //###################################################
  //###################################################

  Future<int> _getLastId(String nameTable) async {
    final db = await dbReference.database;

    final id = await db.rawQuery("SELECT MAX(id) as id FROM $nameTable");
    return id.isNotEmpty ? id.first["id"] : null;
  }
}

final db = DatabaseProvider();
