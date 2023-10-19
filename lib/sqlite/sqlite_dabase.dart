import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class SqliteDatabase {
 static Database? db;

 Future<Database> getDatabase() async {
   db ??= await iniciarBancoDeDados();
   return db!;
 }

  Future<Database> iniciarBancoDeDados() async {
    return await openDatabase(
      path.join(await getDatabasesPath(), 'app.db'),
      version: scripts.length,
      onCreate: (Database db, int version) async {
        for (var i = 1; i <= scripts.length; i++) {
          await db.execute(scripts[i]!);
          print('onCreate: ' + scripts[i]!);
        }
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        for (var i = oldVersion + 1; i <= newVersion; i++) {
          if (scripts.containsKey(i)) {
            await db.execute(scripts[i]!);
            print('onUpgrade: ' + scripts[i]!);
          }
        }
      },
    );
  }

  Map<int, String> scripts = {
    1: '''CREATE TABLE imc_pessoa (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          nome TEXT,
          altura REAL,
          peso REAL,
          imc REAL,
          resultado TEXT
        );'''
  };
}
