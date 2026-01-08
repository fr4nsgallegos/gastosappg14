import 'package:drift/drift.dart';
import 'package:gastosappg14/data/local/drift/app_database.dart';
import 'package:gastosappg14/data/local/drift/tables/categories_table.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoriesDao extends DatabaseAccessor<AppDatabase>
    with _$CategoriesDaoMixin {
  CategoriesDao(AppDatabase db) : super(db);

  // CREATE
  Future<int> createCategory(String name, {int? color}) {
    return into(
      categories,
    ).insert(CategoriesCompanion.insert(name: name, color: Value(color)));
  }

  //READ
  Future<List<Category>> getAllCategories() => select(categories).get();

  Stream<List<Category>> watchAllCategories() =>
      (select(categories)..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();

  Future<int> deleteCategory(int id) {
    return (delete(categories)..where((t) => t.id.equals(id))).go();
  }
}
