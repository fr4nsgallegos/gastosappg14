import 'package:flutter/material.dart';
import 'package:gastosappg14/db/db_notas.dart';
import 'package:gastosappg14/models/nota_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // DbNotas dbnotas = DbNotas();
          // dbnotas.initDatabase();
          // dbnotas.insertNota("Tarea3", "R4alizar reportes de la investigación");
          // dbnotas.obtenerNotas().then((resultado) => print(resultado));
          // dbnotas.actualizarNota(1, "Contenido actualizado");
          // dbnotas.eliminarNota(1);

          // ---------------------- CON MODELOS------------------------
          // dbnotas.insertarNotaModel(
          //   NotaModel(
          //     titulo: "tarea1 Nota model",
          //     contenido:
          //         "Esta es una nota creaada desde una isntancia de Nota model",
          //   ),
          // );

          // dbnotas.obtenerNotasModel().then((notas) => print(notas));

          // CON PATRÓN SINGLETON
          await DbNotas.instance
              .insertNota("NOTA5", "CONTENIDO DE LA NTOA 5")
              .then((valor) => print(valor));
          await DbNotas.instance
              .actualizarNota(3, "nuevoContenido")
              .then((res) => print(res));
          await DbNotas.instance.obtenerNotas().then((valie) => print(valie));
        },
      ),
    );
  }
}
