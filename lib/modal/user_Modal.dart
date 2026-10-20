import 'package:week4_practice/modal/todo_Modal.dart';

class User{
  String name;
  String email;
  String password;
  List<Todo>? userTodo = [];

  User({
    required this.name,
    required this.email,
    required this.password,
    List<Todo>? userTodo,
  }) : userTodo = userTodo ?? [];

}