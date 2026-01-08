import 'package:flutter/material.dart';
import 'package:gastosappg14/data/local/drift/app_database.dart';
import 'package:gastosappg14/data/local/drift/tables/categories_table.dart';

class NoteFormPage extends StatefulWidget {
  final AppDatabase db;
  final Note? editing;
  const NoteFormPage({required this.db, this.editing, super.key});

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _tituloController;
  late final TextEditingController _contenidoController;
  int? _selectedCategoryId;

  bool get isEditing => widget.editing != null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tituloController = TextEditingController(
      text: widget.editing?.titulo ?? "",
    );
    _contenidoController = TextEditingController(
      text: widget.editing?.contenido ?? "",
    );
    _selectedCategoryId = widget.editing?.categoryId;
    print(_selectedCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    final title = isEditing ? "Editar Nota" : "Nueva nota";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(
                  labelText: "Título",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty)
                    return "El título es obligatorio";
                  if (value.trim().length > 100)
                    return "Debe tener un máximo de 100 caracteres";
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _contenidoController,
                decoration: InputDecoration(
                  labelText: "Contenido",
                  border: OutlineInputBorder(),
                ),
                minLines: 4,
                maxLines: 8,
                validator: (value) {
                  if (value == null || value.trim().isEmpty)
                    return "El contenido es obligatorio";
                },
              ),
              SizedBox(height: 15),
              StreamBuilder(
                stream: widget.db.categoriesDao.watchAllCategories(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  final List<Category> categories = snapshot.data ?? [];
                  categories.forEach((element) {
                    print(element.id);
                  });
                  return DropdownButtonFormField(
                    value: _selectedCategoryId,
                    decoration: InputDecoration(
                      labelText: "Categoría (opcional)",
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Text("Sin categoría"),
                        value: null,
                      ),
                      ...categories.map((c) {
                        return DropdownMenuItem(
                          child: Text("${c.name} - ${c.id}"),
                          value: c.id,
                        );
                      }),
                    ],
                    onChanged: (value) =>
                        setState(() => _selectedCategoryId = value),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
