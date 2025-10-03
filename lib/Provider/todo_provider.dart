import 'package:flutter/cupertino.dart';
import 'package:task_todo/Database/db_helper.dart';

class TodoProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _todos = [];

  List<Map<String, dynamic>> get todos => _todos;

  Future<void> fetchAllTodos() async {
    try {
      _todos = await DBHelper.getInstance.fetchAllTodos();
      notifyListeners();
    } catch (e) {
      print("Error in fetchAllTodos: $e");
    }
  }

  Future<void> addTodo({required String title, required String desc}) async {
    await DBHelper.getInstance.addTodo(mTitle: title, mDesc: desc);
    await fetchAllTodos();
  }

  Future<void> updateTodo({
    required int id,
    required String title,
    required String desc,
    required int isCompleted,
  }) async {
    DBHelper db = DBHelper.getInstance;
    await db.updateTodo(
      id: id,
      mTitle: title,
      mDesc: desc,
      isCompleted: isCompleted,
    );
    await fetchAllTodos();
  }

  Future<void> deleteTodo({required int id}) async {
    DBHelper db = DBHelper.getInstance;
    await db.deleteTodo(id: id);
    await fetchAllTodos();
  }
}
