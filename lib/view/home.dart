import 'package:flutter/material.dart';
import 'package:week4_practice/modal/todo_Modal.dart';
import 'package:week4_practice/modal/user_Modal.dart';
import 'package:week4_practice/view/profile_Screen.dart';
import 'package:week4_practice/view/todo_Screen.dart';

class Home extends StatefulWidget {
  const Home({super.key,required this.user});
  final User user;


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget>? _screens;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _screens = [
      TodoScreen(
        // loggedInUser: widget.user,
        // userTodo: widget.user.userTodo,
        userEmailKey: widget.user.email,
      ),
      ProfileScreen(user: widget.user),
    ];
  }

  void addTodo(Todo newTask) {
    widget.user.userTodo?.add(newTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens?[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
      _currentIndex = value;
            setState(() {

            });
          },
          items: [

            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Profile"),

          ]
      ),

    );
  }
}
