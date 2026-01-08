import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:gastosappg14/data/local/drift/daos/categories_dao.dart';
import 'package:gastosappg14/data/local/drift/daos/notes_dao.dart';

import 'tables/notes_table.dart';
import 'tables/categories_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Notes, Categories], daos: [NotesDao, CategoriesDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
    : super(
        driftDatabase(name: "notas_db", native: const DriftNativeOptions()),
      );
  @override
  int get schemaVersion => 1;
}
