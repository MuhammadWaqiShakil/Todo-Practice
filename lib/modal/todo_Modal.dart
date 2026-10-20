import 'package:flutter/material.dart';

class Todo {
  String title = '';
  String? description;
  DateTime? dateTime;
  TimeOfDay? time;
  bool? isCompleted;

  Todo({
    required this.title,
    this.description,
    this.isCompleted = false,
    TimeOfDay? time,
    DateTime? dateTime,
  }) {
    this.dateTime = dateTime ?? DateTime.now();
    this.time = time ?? TimeOfDay.now();
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data["title"] = this.title;
    data["description"] = this.description;
    data["dateTime"] = this.dateTime.toString();
    data["isCompleted"] = this.isCompleted;
    data["time"] = this.time.toString();
    return data;
  }

  Todo.fromMap(Map<String, dynamic> todoMap) {
    this.title = todoMap['title'];
    this.description = todoMap['description'];
    this.dateTime = DateTime.parse(todoMap['dateTime']);
    this.isCompleted = todoMap['isCompleted'];
  }
}
