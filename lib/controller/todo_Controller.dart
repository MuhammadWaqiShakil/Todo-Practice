import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:week4_practice/modal/todo_Modal.dart';


class TodoController {
  List<Todo> taskList = [];
  List<Todo> searchList = [];

  List<String> convertTodoListIntoStringList() {
    List<Map<String, dynamic>> todoMapList = taskList.map((item) => item.toMap()).toList();
    List<String> jsonTodoList = todoMapList.map((mapItem) => jsonEncode(mapItem)).toList();
    return jsonTodoList;
  }

  void saveTodoListInPref({required String userEmailKey}) async {
    List<String> jsonTodoList = convertTodoListIntoStringList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(userEmailKey, jsonTodoList);
  }

  Future<void> convertStringListIntoTodoList({required String userEmailKey}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonTodo = prefs.getStringList(userEmailKey) ?? [];
    List<dynamic> mapTodo = jsonTodo.map((mapItem) => jsonDecode(mapItem)).toList();
    List<Todo> todoList = mapTodo.map((item) => Todo.fromMap(item)).toList();
    taskList = todoList;
  }
}
