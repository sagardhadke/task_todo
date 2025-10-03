import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_todo/Provider/todo_provider.dart';

class AddUpdateTodo extends StatefulWidget {
  const AddUpdateTodo({super.key});

  @override
  State<AddUpdateTodo> createState() => _AddUpdateTodoState();
}

class _AddUpdateTodoState extends State<AddUpdateTodo> {
  TextEditingController mTitle = TextEditingController();
  TextEditingController mDesc = TextEditingController();

  int? todoId;
  int isCompleted = 0;
  bool _isInitialized = false;

  @override
  void dispose() {
    mTitle.dispose();
    mDesc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isUpdating =
        (ModalRoute.of(context)?.settings.arguments
            as Map<String, dynamic>?)?['isUpdating'] ==
        true;

    if (!_isInitialized) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null) {
        bool isUpdateFlag = args['isUpdating'] == true;
        if (isUpdateFlag) {
          todoId = args['id'] as int?;
          mTitle.text = args['title'] ?? '';
          mDesc.text = args['desc'] ?? '';
          isCompleted = args['done'] ?? 0;
        }
      }
      print("Title ${mTitle.text} and Desc ${mDesc.text}");
      _isInitialized = true;
      print(_isInitialized);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdating ? "Update ToDo" : "Add ToDo"),
        backgroundColor: Colors.amber,
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: mTitle,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter todo title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: Icon(Icons.title),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: mDesc,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter todo description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () async {
                      if (isUpdating && todoId != null) {
                        await provider.updateTodo(
                          id: todoId!,
                          title: mTitle.text.trim(),
                          desc: mDesc.text.trim(),
                          isCompleted: isCompleted,
                        );
                      } else {
                        await provider.addTodo(
                          title: mTitle.text.trim(),
                          desc: mDesc.text.trim(),
                        );
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: Text(isUpdating ? "Update ToDo" : "Add ToDo"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
