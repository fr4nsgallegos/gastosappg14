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

  // READ (Future) -
  Future<List<Note>> getAllNotes() => select(notes).get();

  // READ (Stream) -
  Stream<List<Note>> watchAllNotes() =>
      (select(notes)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();

  // GET NOTES WITH CATEGORY STREAM
  Stream<List<NoteWithCategory>> watchNotesWithCategory() {
    final q = select(notes).join([
      leftOuterJoin(categories, categories.id.equalsExp(notes.categoryId)),
    ])..orderBy([OrderingTerm.desc(notes.categoryId)]);

    return q.watch().map((rows) {
      return rows.map((row) {
        final note = row.readTable(notes);
        final category = row.readTableOrNull(categories);
        return NoteWithCategory(note, category);
      }).toList();
    });
  }

  // UPDATE
  Future<int> updateNote({
    required int id,
    String? titulo,
    String? contenido,
    int? categoryId,
  }) {
    return (update(notes)..where((t) => t.id.equals(id))).write(
      NotesCompanion(
        titulo: titulo != null ? Value(titulo) : Value.absent(),
        contenido: contenido != null ? Value(contenido) : Value.absent(),
        categoryId: Value(categoryId),
      ),
    );
  }

  // DELETE
  Future<int> deleteNote(int id) {
    return (delete(notes)..where((t) => t.id.equals(id))).go();
  }
}
