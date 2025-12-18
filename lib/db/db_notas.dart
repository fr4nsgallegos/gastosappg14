import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbNotas {
  Database? myNotasDatabase;

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory);
    String pathDatabase = join(directory.path, 'NotasDB.db');
    return openDatabase(
      pathDatabase,
      version: 1,
      onCreate: (Database db, int version) {
        db.execute("""CREATE TABLE NOTAS (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT,
            contenido TEXT
        )""");
      },
    );
  }

  // INSERTAR
  Future<void> insertNota(String titulo, String contenido) async {
    final db = await initDatabase();
    db.insert("NOTAS", {"titulo": titulo, "contenido": contenido});
  }

  // OBTENER REGISTROS
  Future<List<Map<String, dynamic>>> obtenerNotas() async {
    final db = await initDatabase();
    // return db.rawQuery("SELECT * FROM NOTAS");
    // return db.rawQuery(
    //   "SELECT titulo, contenido FROM NOTAS WHERE titulo = 'Tarea1'",
    // );
    return db.query(
      "NOTAS",
      where: "titulo = 'Tarea2'",
      columns: ["id,contenido"],
    );
  }

  // ACTUALIZAR
  Future<void> actualizarNota(int id, String nuevoContenido) async {
    final db = await initDatabase();
    await db.update(
      "NOTAS",
      {"contenido": nuevoContenido},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // ELIMINAR
  Future<void> eliminarNota(int id) async {
    final db = await initDatabase();
    await db.delete("NOTAS", where: "id=?", whereArgs: [id]);
  }
}
