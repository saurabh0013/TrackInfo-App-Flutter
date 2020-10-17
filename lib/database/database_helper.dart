import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:track_info/models/infoDatabaseModel.dart';

class DatabaseHelper {
  Database db;
  init() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'infos.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE infos(id TEXT PRIMARY KEY, label TEXT, lastPlace TEXT,status TEXT,date TEXT,time TEXT)",
        );
      },
      version: 2,
    );
  }

  Future<void> insertInfo(DatabaseModel databaseModel) async {
    await db.insert(
      'infos',
      databaseModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DatabaseModel>> info() async {
    final List<Map<String, dynamic>> maps = await db.query('infos');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return DatabaseModel(
          id: maps[i]['id'],
          date: maps[i]['date'],
          label: maps[i]['label'],
          lastPlace: maps[i]['lastPlace'],
          status: maps[i]['status'],
          time: maps[i]['time']);
    });
  }

  void removeInfo(String id) async {
    await db.delete('infos', where: 'id=?', whereArgs: [id]);
  }
}
