import 'package:flutter/material.dart';
import 'package:gastosappg14/data/local/drift/app_database.dart';

class CategoriesPage extends StatelessWidget {
  final AppDatabase db;
  const CategoriesPage({required this.db, super.key});

  Future<void> _confirmDelete(BuildContext context, Category c) async {
    // 1. Confirmar si hay notas en esa categoría
    final count = await db.notesDao.countNotesByCategoryId(c.id);

    if (count > 0) {
      // "SÍ HAY NOTAS, NO SE DEBE ELIMINAR"
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("No se puede eliminar"),
          content: Text(
            "La categoría ${c.name} no se puede eliminar porque existen $count notas asociadas a esta categoría",
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Entendido"),
            ),
          ],
        ),
      );
      return;
    }

    // 3. Si no hay notas, pedir confirmacion nromal
    final ok = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Eliminar categoria"),
        content: Text("¿Eliminar ${c.name}"),
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
      await db.categoriesDao.deleteCategory(c.id);
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categorías")),
      body: StreamBuilder(
        stream: db.categoriesDao.watchAllCategories(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final List items = snapshot.data ?? [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (items.isEmpty) {
            return Center(child: Text("No hay categrías aún"));
          }

          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 1);
            },
            itemBuilder: (BuildContext context, int index) {
              final Category c = items[index];
              return ListTile(
                title: Text(c.name),
                leading: Text(c.id.toString()),
                trailing: IconButton(
                  tooltip: "Eliminar",
                  onPressed: () {
                    _confirmDelete(context, c);
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
