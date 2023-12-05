import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';
import 'package:todo/common/models/task_model.dart';

class DBHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute(
        "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, description TEXT, date STRING, startTime STRING, endTime STRING, remind INTEGER, repeat STRING, isCompleted INTEGER)");
    await database.execute(
        "CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0, isVerified INTEGER)");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'suteerth-db-todo',
      version: 1,
      onCreate: (db, version) async {
        await createTables(db);
      },
    );
  }

  static Future<int> createItem(TaskModel task) async {
    final db = await DBHelper.db();
    final id = await db.insert(
      'todos',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<int> createUser(int isVerified) async {
    final db = await DBHelper.db();
    final data = {
      'id': 1,
      'isVerified': isVerified,
    };
    final id = await db.insert(
      'user',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await DBHelper.db();
    return db.query('user', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DBHelper.db();
    return db.query('todos', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DBHelper.db();
    return db.query(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
  }

  static Future<int> updateItem(
    int id,
    String title,
    String desc,
    int isCompleted,
    String date,
    String startTime,
    String endTime,
  ) async {
    final db = await DBHelper.db();
    final data = {
      'title': title,
      'description': desc,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
    };
    final res = await db.update(
      'todos',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
    return res;
  }

  static Future<void> deleteItem(int id) async {
    final db = await DBHelper.db();
    try {
      db.delete('todos', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
