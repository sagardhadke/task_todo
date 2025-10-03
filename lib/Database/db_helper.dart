import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper getInstance = DBHelper._();
  Database? myDB;
  static const String todoTableName = "myTable_Name";
  static const String todoSrNo = "todo_SrNo";
  static const String todoTitle = "todo_title";
  static const String todoDesc = "todo_desc";
  static const String todoDone = "todo_done";
  static const String todoCreatedAt = "todo_createdAt";

  Future<Database> initDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await openDB();
      return myDB!;
    }
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "myTodo.db");
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "create table $todoTableName ($todoSrNo integer primary key autoincrement, $todoTitle text, $todoDesc text, $todoDone integer, $todoCreatedAt integer) ",
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchAllTodos() async {
    Database db = await initDB();
    return await db.query(todoTableName);
  }

  Future<bool> addTodo({required String mTitle, required String mDesc}) async {
    Database db = await initDB();
    int rowsEffected = await db.insert(todoTableName, {
      todoTitle: mTitle,
      todoDesc: mDesc,
      todoCreatedAt: DateTime.now().millisecondsSinceEpoch,
      todoDone: 0,
    });
    return rowsEffected > 0;
  }

  Future<bool> updateTodo({
    required int id,
    required String mTitle,
    required String mDesc,
    required int isCompleted,
  }) async {
    Database db = await initDB();
    int rowsEffected = await db.update(
      todoTableName,
      {todoTitle: mTitle, todoDesc: mDesc, todoDone: isCompleted},
      where: "$todoSrNo = ?",
      whereArgs: [id],
    );
    return rowsEffected > 0;
  }

  Future<bool> deleteTodo({required int id}) async {
    Database db = await initDB();
    int rowsEffected = await db.delete(
      todoTableName,
      where: '$todoSrNo = ?',
      whereArgs: [id],
    );
    return rowsEffected > 0;
  }
}
