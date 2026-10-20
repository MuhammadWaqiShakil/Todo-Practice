import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week4_practice/constant/app_Assets.dart';
import 'package:week4_practice/constant/app_Colors.dart';
import 'package:week4_practice/controller/todo_Controller.dart';
import 'package:week4_practice/modal/todo_Modal.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({required this.userEmailKey});

  final String userEmailKey;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  TodoController todoController = TodoController();

  @override
  void initState() {
    super.initState();
    onInitCalled();
  }

  void onInitCalled() async {
    await todoController.convertStringListIntoTodoList(
      userEmailKey: widget.userEmailKey,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Todo newTodo = Todo(title: "New Todo");
    // Map<String, dynamic> newTodoMap = newTodo.toMap();
    // String jsonTodo = jsonEncode(newTodoMap);

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: Text(
          "Todo",
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.appbarColor,
      ),
      body: todoController.taskList.isEmpty
          ? Center(child: Lottie.asset(AppAssets.noDataAnimation))
          : Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18,
                      right: 18,
                      top: 10,
                      bottom: 20,
                    ),
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      focusNode: searchFocus,
                      keyboardType: TextInputType.text,
                      controller: searchController,
                      style: const TextStyle(color: AppColors.primaryText),
                      onChanged: (value) {
                        todoController.searchList = todoController.taskList
                            .where(
                              (item) => item.title.toLowerCase().contains(
                                value.toLowerCase(),
                              ),
                            )
                            .toList();
                        setState(() {});
                      },
                      onSubmitted: (value) {
                        print("ON SUBMITTED===== $value");
                        searchFocus.unfocus();
                        setState(() {});
                      },
                      onTap: () {
                        setState(() {});
                      },
                      onTapOutside: (event) {
                        searchFocus.unfocus();
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        fillColor: AppColors.inputFieldBgColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: AppColors.inputHintTextColor,
                        hint: Text(
                          "Search title",
                          style: TextStyle(color: AppColors.inputHintTextColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColors.taskCardBorderColor.withValues(
                              alpha: 0.7,
                            ),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.taskCardBorderColor,
                            width: 2.0,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  if (searchController.text.isNotEmpty &&
                      todoController.searchList.isEmpty) ...[
                    Expanded(child: Lottie.asset(AppAssets.notFoundAnimation)),
                  ] else ...[
                    Expanded(
                      flex: 7,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        itemCount: searchController.text.isNotEmpty
                            ? todoController.searchList.length
                            : todoController.taskList.length,
                        itemBuilder: (context, index) {
                          final todoListings = searchController.text.isNotEmpty
                              ? todoController.searchList[index]
                              : todoController.taskList[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 10,
                            ),
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 8),
                            // height: 100,
                            decoration: BoxDecoration(
                              color: AppColors.bgColor,
                              border: Border.all(
                                color: AppColors.taskCardBorderColor,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 9),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${todoListings.title}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                      ),
                                    ),
                                    (todoListings.description != null)
                                        ? Text(
                                            "${todoListings.description}",
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 18,
                                            ),
                                          )
                                        : SizedBox(height: 1),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          "${todoListings.dateTime?.day}/${todoListings.dateTime?.month}/${todoListings.dateTime?.year}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "${todoListings.time?.hourOfPeriod}:${todoListings.time?.minute} ${todoListings.time?.period.name}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        // Icon(Icons.delete,color: Colors.red,)
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        heroTag: UniqueKey(),
        onPressed: () {
          DateTime? selectedDate = DateTime.now();
          DateTime? tempDate = DateTime.now();
          TimeOfDay? selectedTime = TimeOfDay.now();
          TimeOfDay? tempTime = TimeOfDay.now();
          final titleController = TextEditingController();
          final descriptionController = TextEditingController();
          showModalBottomSheet(
            isDismissible: false,
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setBottomSheet) {
                  return Container(
                    color: Colors.black,
                    padding: EdgeInsets.only(top: 20),
                    height: 490,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Enter Task",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_downward,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextField(
                            controller: titleController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              label: Text("Title"),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextField(
                            controller: descriptionController,
                            maxLines: 5,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              label: Text("Description"),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            if (titleController.text.isNotEmpty) {
                              Todo newTodo = Todo(
                                title: titleController.text,
                                description: descriptionController.text.isEmpty
                                    ? null
                                    : descriptionController.text,
                                dateTime: selectedDate,
                              );
                              todoController.taskList.add(newTodo);
                              todoController.saveTodoListInPref(
                                userEmailKey: widget.userEmailKey,
                              );
                              setState(() {});
                              Navigator.pop(context);
                              titleController.clear();
                              descriptionController.clear();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "New todo has been added",
                                    style: TextStyle(
                                      color: AppColors.primaryText,
                                      fontSize: 16,
                                    ),
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "Title required",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBtnColor,
                            padding: EdgeInsets.only(left: 60, right: 60),
                          ),
                          child: Text(
                            "Add",
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primaryText,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    selectedDate = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(3000),
                                      initialDate: DateTime.now(),
                                    );
                                    if (selectedDate == null) {
                                      selectedDate = tempDate;
                                    }
                                    setBottomSheet(() {});
                                  },
                                  label: Text(
                                    "${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}",
                                  ),
                                  icon: Icon(Icons.calendar_month),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    selectedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (selectedDate == null) {
                                      selectedTime = tempTime;
                                    }
                                    setBottomSheet(() {});
                                  },
                                  label: Text(
                                    "${selectedTime?.hourOfPeriod}:${selectedTime?.minute} ${selectedTime?.period.name}",
                                  ),
                                  icon: Icon(Icons.access_time_outlined),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        backgroundColor: AppColors.appbarColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
