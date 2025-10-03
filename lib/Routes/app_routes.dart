import 'package:flutter/material.dart';
import 'package:task_todo/screens/add_update.dart';
import 'package:task_todo/screens/home_page.dart';

class AppRoutes {
  static const String home = "/home";
  static const String addUpdateTodo = "/addUpdateTODO";

  static Map<String, WidgetBuilder> mRoutes = {
    AppRoutes.home: (_) => MyHomePage(),
    AppRoutes.addUpdateTodo: (_) => AddUpdateTodo(),
  };
}
