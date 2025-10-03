import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_todo/Database/db_helper.dart';
import 'package:task_todo/Provider/todo_provider.dart';
import 'package:task_todo/Routes/app_routes.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"), backgroundColor: Colors.amber),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {
          if (provider.todos.isEmpty) {
            return Center(child: Text("No Todo's Available"));
          } else {
            return ListView.builder(
              itemCount: provider.todos.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    final todo = provider.todos[index];
                    Navigator.pushNamed(
                      context,
                      AppRoutes.addUpdateTodo,
                      arguments: {
                        'isUpdating': true,
                        'title': todo[DBHelper.todoTitle],
                        'desc': todo[DBHelper.todoDesc],
                        'id': todo[DBHelper.todoSrNo],
                        'done': todo[DBHelper.todoDone],
                      },
                    );
                  },
                  title: Text(
                    provider.todos[index][DBHelper.todoTitle] ?? '',
                    style: TextStyle(
                      decoration: provider.todos[index][DBHelper.todoDone] == 1
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(
                    provider.todos[index][DBHelper.todoDesc].toString(),
                  ),
                  leading: Checkbox.adaptive(
                    value: provider.todos[index][DBHelper.todoDone] == 1,
                    onChanged: (value) async {
                      final todo = provider.todos[index];
                      await provider.updateTodo(
                        id: todo[DBHelper.todoSrNo],
                        title: todo[DBHelper.todoTitle],
                        desc: todo[DBHelper.todoDesc],
                        isCompleted: value! ? 1 : 0,
                      );
                    },
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      await provider.deleteTodo(
                        id: provider.todos[index][DBHelper.todoSrNo],
                      );
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addUpdateTodo),
        child: Icon(Icons.add),
      ),
    );
  }
}
