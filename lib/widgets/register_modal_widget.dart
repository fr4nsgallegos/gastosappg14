import 'package:flutter/material.dart';
import 'package:gastosappg14/utils/data_general.dart';
import 'package:gastosappg14/widgets/field_widget.dart.dart';
import 'package:gastosappg14/widgets/item_type_widget.dart';

class RegisterModalWidget extends StatefulWidget {
  const RegisterModalWidget({super.key});

  @override
  State<RegisterModalWidget> createState() => _RegisterModalWidgetState();
}

class _RegisterModalWidgetState extends State<RegisterModalWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String typeSelected = "Alimentos";

  Widget _buildAddButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        onPressed: () {},
        child: Text("Añadir", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Registra el pago", style: TextStyle(fontSize: 24)),
            SizedBox(height: 12),
            FieldWidget(
              hintText: "Ingresa el título",
              controller: titleController,
            ),
            FieldWidget(
              hintText: "Ingresa el monto",
              controller: priceController,
              isNumberKeyboard: true,
            ),
            FieldWidget(
              hintText: "Ingresa la fecha",
              controller: dateController,
              function: () {
                print("Mostrar selectet picker");
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: types
                    .map(
                      (e) => ItemTypeWidget(
                        data: e,
                        isSelected: typeSelected == e["name"] ? true : false,
                        tap: () {
                          typeSelected = e["name"];
                          setState(() {});
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            _buildAddButton(),
          ],
        ),
      ),
    );
  }
}
