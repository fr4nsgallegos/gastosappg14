import 'package:flutter/material.dart';
import 'package:gastosappg14/data/local/drift/app_database.dart';

class NotesPage extends StatelessWidget {
  final AppDatabase db;
  NotesPage({required this.db});

  // Future<void>

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notas")),
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
              );
            },
          );
        },
      ),
    );
  }
}
