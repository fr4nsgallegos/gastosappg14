import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gastosappg14/data/local/drift/app_database.dart';
import 'package:gastosappg14/generated/l10n.dart';
import 'package:gastosappg14/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final db = AppDatabase();
  // final catId = await db.categoriesDao.createCategory("Personal");
  // await db.categoriesDao.createCategory("Trabajo");
  // debugPrint(catId.toString());

  runApp(
    MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

// // PARA USAR CON DRIFT
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gastosappg14/data/local/drift/app_database.dart';
// import 'package:gastosappg14/pages/notes_page.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late final AppDatabase db;

//   @override
//   void initState() {
//     super.initState();
//     db = AppDatabase();
//   }

//   @override
//   void dispose() {
//     db.close();
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: NotesPage(db: db),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
