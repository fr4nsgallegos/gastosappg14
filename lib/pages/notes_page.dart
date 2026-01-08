import 'package:flutter/material.dart';
import 'package:gastosappg14/data/local/drift/app_database.dart';
import 'package:gastosappg14/pages/categories_page.dart';

class NotesPage extends StatelessWidget {
  final AppDatabase db;
  NotesPage({required this.db});

  Future<void> _confirmDelete(BuildContext context, int noteId) async {
    final ok = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Eliminar nota"),
        content: Text("¿Seguro que deseas eliminar esta nota?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text("Cancelar"),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text("Eliminar"),
          ),
        ],
      ),
    );
    if (ok == true) {
      await db.notesDao.deleteNote(noteId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final catId = await db.categoriesDao.createCategory("Trabajo");
          await db.notesDao.createNote(
            titulo: "Revisión de base de datos",
            contenido:
                "Hacer una revisión del comportamiento y datos con respecto al mes pasado",
            categoryId: catId,
          );
        },
      ),
      appBar: AppBar(
        title: Text("Notas"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoriesPage(db: db)),
              );
            },
            icon: Icon(Icons.category_outlined),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: db.notesDao.watchNotesWithCategory(),
        builder: (context, snapshot) {
          final items = snapshot.data ?? [];

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (items.isEmpty) {
            return Center(child: Text("No hay Datos todavía"));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 1);
            },
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];
              final note = item.note;
              final cat = item.category;
              return ListTile(
                title: Text(note.titulo),
                subtitle: Text(cat?.name ?? "Sin categoría"),
                trailing: IconButton(
                  onPressed: () {
                    _confirmDelete(context, note.id);
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
