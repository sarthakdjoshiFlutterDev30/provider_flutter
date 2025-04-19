import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper instance = DbHelper._();

  Database? _myDb;

  Future<Database> getDb(String dbName) async {
    if (_myDb != null) {
      return _myDb!;
    } else {
      return await openDb(dbName);
    }
  }

  Future<Database> openDb(String dbName) async {
    String path = join(await getDatabasesPath(), dbName);
    _myDb = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // Create tables here
        return db.execute(
          'CREATE TABLE User(s_no INTEGER PRIMARY KEY, title TEXT, description TEXT)',
        );
      },
    );

    return _myDb!;
  }

  Future<bool> addnotes(String title, String description, String dbName) async {
    var db = await getDb(dbName);
    int rowsAffected = await db.insert('User ', {
      'title': title,
      'description': description,
    });
    return rowsAffected > 0;
  }

  Future<List<Map<String, dynamic>>> getallnotes(String dbName) async {
    var db = await getDb(dbName);
    List<Map<String, dynamic>> data = await db.query('User ');
    return data;
  }

  Future<void> deleteNote(int id, String dbName) async {
    var db = await getDb(dbName);
    await db.delete('User ', where: 's_no = ?', whereArgs: [id]);
  }

  Future<void> updateNote(
    int id,
    String title,
    String description,
    String dbName,
  ) async {
    var db = await getDb(dbName);
    await db.update(
      'User ',
      {'title': title, 'description': description},
      where: 's_no = ?',
      whereArgs: [id],
    );
  }
}
