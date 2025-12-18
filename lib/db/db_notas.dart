import 'dart:io';

import 'package:gastosappg14/models/nota_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// DB NOTAS CON SINGLETON
class DbNotas {
  // costructor privado: nadie puede hacer DbNotas()
  DbNotas._internal();

  // Instancia única (objeto único)
  static final DbNotas instance = DbNotas._internal();

  // Referencia a la BD (se crea una sola vez )
  static Database? _myNotasDatabase;

  // Getter: asegura inicializar SOLO aún no existe
  Future<Database> get database async {
    if (_myNotasDatabase != null) return _myNotasDatabase!;
    _myNotasDatabase = await _initDatabase();
    return _myNotasDatabase!;
  }

  // Inicialización real de la BD (privada)
  Future<Database> _initDatabase() async {
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
  Future<int> insertNota(String titulo, String contenido) async {
    final db = await database;
    int res = await db.insert("NOTAS", {
      "titulo": titulo,
      "contenido": contenido,
    });
    return res;
  }

  Future<int> insertarNotaModel(NotaModel notaModel) async {
    final db = await database;
    int res = await db.insert("NOTAS", notaModel.toMap());
    return res;
  }

  // OBTENER REGISTROS
  Future<List<Map<String, dynamic>>> obtenerNotas() async {
    final db = await database;

    return db.query(
      "NOTAS",
      where: "titulo = 'Tarea2'",
      columns: ["id,contenido"],
    );
  }

  Future<List<NotaModel>> obtenerNotasModel() async {
    final db = await database;
    List<Map<String, dynamic>> data = await db.query("NOTAS");
    List<NotaModel> notasModelList = data
        .map((e) => NotaModel.fromMap(e))
        .toList();
    return notasModelList;
  }

  // ACTUALIZAR
  Future<int> actualizarNota(int id, String nuevoContenido) async {
    final db = await database;
    int res = await db.update(
      "NOTAS",
      {"contenido": nuevoContenido},
      where: "id = ?",
      whereArgs: [id],
    );
    return res;
  }

  // ELIMINAR
  Future<void> eliminarNota(int id) async {
    // final db = await _initDatabase();
    final db = await database;
    await db.delete("NOTAS", where: "id=?", whereArgs: [id]);
  }
}

// DB NOTAS SIN SINGLETON
// class DbNotas {
//   Database? myNotasDatabase;

//   Future<Database> initDatabase() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     print(directory);
//     String pathDatabase = join(directory.path, 'NotasDB.db');
//     return openDatabase(
//       pathDatabase,
//       version: 1,
//       onCreate: (Database db, int version) {
//         db.execute("""CREATE TABLE NOTAS (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             titulo TEXT,
//             contenido TEXT
//         )""");
//       },
//     );
//   }

//   // INSERTAR
//   Future<void> insertNota(String titulo, String contenido) async {
//     final db = await initDatabase();
//     db.insert("NOTAS", {"titulo": titulo, "contenido": contenido});
//   }

//   Future<void> insertarNotaModel(NotaModel notaModel) async {
//     final db = await initDatabase();
//     await db.insert("NOTAS", notaModel.toMap());
//   }

//   // OBTENER REGISTROS
//   Future<List<Map<String, dynamic>>> obtenerNotas() async {
//     final db = await initDatabase();
//     // return db.rawQuery("SELECT * FROM NOTAS");
//     // return db.rawQuery(
//     //   "SELECT titulo, contenido FROM NOTAS WHERE titulo = 'Tarea1'",
//     // );
//     return db.query(
//       "NOTAS",
//       where: "titulo = 'Tarea2'",
//       columns: ["id,contenido"],
//     );
//   }

//   Future<List<NotaModel>> obtenerNotasModel() async {
//     final db = await initDatabase();
//     List<Map<String, dynamic>> data = await db.query("NOTAS");
//     List<NotaModel> notasModelList = data
//         .map((e) => NotaModel.fromMap(e))
//         .toList();
//     return notasModelList;
//   }

//   // ACTUALIZAR
//   Future<void> actualizarNota(int id, String nuevoContenido) async {
//     final db = await initDatabase();
//     await db.update(
//       "NOTAS",
//       {"contenido": nuevoContenido},
//       where: "id = ?",
//       whereArgs: [id],
//     );
//   }

//   // ELIMINAR
//   Future<void> eliminarNota(int id) async {
//     final db = await initDatabase();
//     await db.delete("NOTAS", where: "id=?", whereArgs: [id]);
//   }
// }
