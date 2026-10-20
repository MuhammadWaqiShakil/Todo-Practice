import 'package:flutter/material.dart';
import 'package:week4_practice/constant/app_Colors.dart';
import 'package:week4_practice/modal/user_Modal.dart';
import 'package:week4_practice/view/login_Screen.dart';

class ProfileScreen extends StatefulWidget {


  const ProfileScreen({super.key,required this.user});
  final User user;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.appbarColor,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.fabColor,
                  child: Text(
                    widget.user.name.trim().split(' ').map((l) => l[0]).join().toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w700,
                      fontSize: 35,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.user.name,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  "Grade 8 - Section B",
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 110,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.taskCardBgColor,
                    border: Border.all(color: AppColors.taskCardBorderColor),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "12",
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Quizzes",
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 110,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.taskCardBgColor,
                    border: Border.all(color: AppColors.taskCardBorderColor),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "82%",
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Avg Score",
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 110,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.taskCardBgColor,
                    border: Border.all(color: AppColors.taskCardBorderColor),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "#5",
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Rank",
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Container(
              width: 385,
              decoration: BoxDecoration(
                color: AppColors.taskCardBgColor,
                border: Border.all(color: AppColors.taskCardBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.email, color: AppColors.secondaryText),
                            SizedBox(width: 8),
                            Text(
                              "Email",
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.user.email,
                          style: const TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.school, color: AppColors.secondaryText),
                            SizedBox(width: 8),
                            Text(
                              "School",
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "City Public School",
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: AppColors.secondaryText,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Joined",
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "March 2026",
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 385,
              decoration: BoxDecoration(
                  color: AppColors.taskCardBgColor,
                  border: Border.all(color: AppColors.taskCardBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Actions",style: TextStyle(color: AppColors.primaryText,fontSize: 22,fontWeight: FontWeight.w600),),
                    const SizedBox(height: 15,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.notifications, color: AppColors.secondaryText),
                            SizedBox(width: 8),
                            Text(
                              "Notifications",
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,color: AppColors.secondaryText,size: 20,),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.exit_to_app, color: Colors.red),
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  var route = Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                    return LoginScreen();
                                  }));
                                });
                              },
                              child: const Text("Logout",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
