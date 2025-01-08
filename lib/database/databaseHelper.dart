import 'package:rieng/model/task.dart';
import 'package:rieng/model/taskNew.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static final int _version = 1;
  static final _tableName = ["task", "dailyInput"];

  static Future<void> createTables(sql.Database database) async {
    await database.execute("CREATE TABLE IF NOT EXISTS ${_tableName[0]} ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "title STRING, note TEXT, date STRING,"
        "startTime STRING, endTime STRING,"
        "remind INTEGER, repeat STRING,"
        "color INTEGER, isCompleted INTEGER)");

    await database.execute("CREATE TABLE IF NOT EXISTS ${_tableName[1]} ("
        "dailyInputId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "dailyInputType INTEGER, dailyInputDate STRING,"
        "idTask INTEGER)");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'task',
      version: _version,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> insert(Task? task) async {
    final database = await db();
    final id = await database.insert(_tableName[0], task!.toJson(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> insertProgress(Map<String, dynamic> task) async {
    final database = await db();
    final id = await database.insert(_tableName[1], task,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    print(id);
    return id;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    final database = await db();
    // return await database.rawQuery('''
    // SELECT * FROM ${_tableName[0]}
    // ''');

    return await database.rawQuery('''
    SELECT t.*, GROUP_CONCAT(d.dailyInputDate, ',') AS dailyInputDates, GROUP_CONCAT(d.dailyInputType, ',') AS dailyInputTypes FROM ${_tableName[0]} t
    LEFT JOIN ${_tableName[1]} d ON
    t.id = d.idTask
    GROUP BY t.id
    ORDER BY t.id DESC
    ''');
  }

  static delete({required TaskNew? task}) async {
    final database = await db();
    await database.delete(_tableName[0], where: 'id=?', whereArgs: [task!.id]);
  }

  static updateComplete({required int id}) async {
    final database = await db();
    return await database.rawUpdate('''
    UPDATE ${_tableName[0]}
    SET isCompleted =?
    WHERE id=?
    ''', [1, id]);
  }

  static updateHabit({required Task task}) async {
    final database = await db();
    return await database.update(_tableName[0], task.toJson(),
        where: 'id=?', whereArgs: [task.id],
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }
}
