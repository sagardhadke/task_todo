import 'package:flutter/material.dart';
import 'package:task_todo/View/home_page.dart';

class AppRoutes {
  static const String home = "/home";
  static const String addTodo = "/addTODO";

  static Map<String, WidgetBuilder> mRoutes = {
    AppRoutes.home: (_) => MyHomePage(),
  };
}
