import 'package:drift/drift.dart';
import 'package:gastosappg14/data/local/drift/app_database.dart';
import 'package:gastosappg14/data/local/drift/tables/categories_table.dart';
import 'package:gastosappg14/data/local/drift/tables/notes_table.dart';

part 'notes_dao.g.dart';

class NoteWithCategory {
  final Note note;
  final Category? category;
  NoteWithCategory(this.note, this.category);
}

@DriftAccessor(tables: [Notes, Categories])
class NotesDao extends DatabaseAccessor<AppDatabase> with _$NotesDaoMixin {
  NotesDao(AppDatabase db) : super(db);

  // CREATE
  Future<int> createNote({
    required String titulo,
    required contenido,
    int? categoryId,
  }) {
    return into(notes).insert(
      NotesCompanion.insert(
        titulo: titulo,
        contenido: contenido,
        categoryId: Value(categoryId),
      ),
    );
  }
}
