import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'test.db'),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE test_table(name TEXT PRIMARY KEY, number TEXT)'),
        version: 1);
  }

  static Future<void> insert(String name, String number) async {
    final db = await DBHelper.database();
    await db.insert(
      'test_table',
      {
        'name': name,
        'number': number,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> fetch() async {
    final db = await DBHelper.database();
    return db.query('test_table');
  }

  static Future<void> edit(String name, String number) async {
    final db = await DBHelper.database();
    await db.rawUpdate(
        'UPDATE test_table SET number = ? WHERE name = ?', [number, name]);
  }

  static Future<void> delete(String name) async {
    final db = await DBHelper.database();
    await db.rawDelete('DELETE FROM test_table WHERE name = ?', [name]);
  }
}
