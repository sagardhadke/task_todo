import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_todo/Provider/todo_provider.dart';
import 'package:task_todo/Routes/app_routes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (ctx) => TodoProvider()..fetchAllTodos(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.home,
      routes: AppRoutes.mRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
