import 'package:flutter/material.dart';
import 'package:gastosappg14/db/db_notas.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DbNotas dbnotas = DbNotas();
          // dbnotas.initDatabase();
          // dbnotas.insertNota("Tarea3", "R4alizar reportes de la investigación");

          // dbnotas.obtenerNotas().then((resultado) => print(resultado));
          // dbnotas.actualizarNota(1, "Contenido actualizado");
          dbnotas.eliminarNota(1);
        },
      ),
    );
  }
}
