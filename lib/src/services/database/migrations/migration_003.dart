import 'package:sqflite/sqflite.dart';

import '../table_names.dart';

class _Migration003 {
  execute(Database db) async {
    await db.execute(
        "INSERT INTO $dog_name VALUES (1,'Fido','Pastor Ingles',3,'Es totalmente sociable','Luis Collao',67945241)");
    await db.execute(
        "INSERT INTO $dog_name VALUES (2,'Copernico','Salchicha',2,'Perro travieso pero adorable','Javiera Iglesias',85243823)");
    await db.execute(
        "INSERT INTO $dog_name VALUES (3,'Sasha','Pastor aleman',4,'Perrita inteligente y obediente','Francisco Cuadra',80903519)");
    await db.execute(
        "INSERT INTO $dog_name VALUES (4,'Bruno','Bulldog',3,'Jugueton y amigable pese a su seria apariencia','Luis Collao',67945241)");
    await db.execute(
        "INSERT INTO $dog_name VALUES (5,'Reina','Pudul',1,'la regalona de la familia','Pablo Espinoza',93706162)");
  }
}

final migration003 = _Migration003();
