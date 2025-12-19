import 'package:flutter/material.dart';
import 'package:gastosappg14/db/db_notas.dart';
import 'package:gastosappg14/models/nota_model.dart';
import 'package:gastosappg14/widgets/custom_card_item.dart';
import 'package:gastosappg14/widgets/field_widget.dart.dart';
import 'package:gastosappg14/widgets/register_modal_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  void showRegisterModal() {
    showModalBottomSheet(
      isScrollControlled:
          true, //Permite que el modal use más altura, incluso el 100% de la pantalla
      context: context,
      builder: (BuildContext context) {
        // Cuando usamos forms dentro del shotmodalbotton debemos poner encerrar todo en un pading de la siguiente forma para que no se tape en contenido

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: RegisterModalWidget(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     // DbNotas dbnotas = DbNotas();
        //     // dbnotas.initDatabase();
        //     // dbnotas.insertNota("Tarea3", "R4alizar reportes de la investigación");
        //     // dbnotas.obtenerNotas().then((resultado) => print(resultado));
        //     // dbnotas.actualizarNota(1, "Contenido actualizado");
        //     // dbnotas.eliminarNota(1);

        //     // ---------------------- CON MODELOS------------------------
        //     // dbnotas.insertarNotaModel(
        //     //   NotaModel(
        //     //     titulo: "tarea1 Nota model",
        //     //     contenido:
        //     //         "Esta es una nota creaada desde una isntancia de Nota model",
        //     //   ),
        //     // );

        //     // dbnotas.obtenerNotasModel().then((notas) => print(notas));

        //     // CON PATRÓN SINGLETON
        //     await DbNotas.instance
        //         .insertNota("NOTA5", "CONTENIDO DE LA NTOA 5")
        //         .then((valor) => print(valor));
        //     await DbNotas.instance
        //         .actualizarNota(3, "nuevoContenido")
        //         .then((res) => print(res));
        //     await DbNotas.instance.obtenerNotas().then((valie) => print(valie));
        //   },
        // ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      showRegisterModal();
                    },
                    child: Container(
                      color: Colors.black,
                      width: double.infinity,
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            "Agregar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Resumen de gastos",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Gestiona tus gastos de mejor forma",
                            style: TextStyle(color: Colors.grey),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: FieldWidget(
                              controller: searchController,
                              hintText: "Buscar por título",
                            ),
                          ),

                          CustomCardItem(
                            title: "Cine",
                            subtitle: "2024-11-15 00:00:00.000",
                            amount: "S/ 50.0",
                            iconWidget: Icon(
                              Icons.movie_creation_outlined,
                              size: 40,
                              color: Colors.red[300],
                            ),
                          ),

                          CustomCardItem(
                            title: "Curso Codigo",
                            subtitle: "2024-11-15 00:00:00.000",
                            amount: "S/ 110.0",
                            iconWidget: Icon(
                              Icons.fastfood,
                              size: 40,
                              color: Colors.orange[300],
                            ),
                          ),

                          CustomCardItem(
                            title: "Deuda banco",
                            subtitle: "2024-11-21 00:00:00.000",
                            amount: "S/ 1582.0",
                            iconWidget: Icon(
                              Icons.fastfood,
                              size: 40,
                              color: Colors.orange[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 90),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
