
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week4_practice/constant/app_Colors.dart';
import 'package:week4_practice/constant/app_Constants.dart';
import 'package:week4_practice/data/user_Data.dart';
import 'package:week4_practice/modal/user_Modal.dart';
import 'package:week4_practice/view/home.dart';
import 'package:week4_practice/view/profile_Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  bool isProtected = true;
  User? loggedInUser;
  bool isLoading = false;
  bool rememberMe = false;

  @override
  void initState() {
    // *TODO: implement initState*
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task_alt, color: AppColors.fabColor, size: 70),
                  Text(
                    "DSTP-Todo",
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80),
              Column(
                children: [
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Sign in to continue your journey",
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    TextField(
                      textInputAction: TextInputAction.next,
                      focusNode: emailFocus,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: AppColors.primaryText,
                      ),
                      controller: emailController,
                      onTap: () {
                        setState(() {});
                      },
                      onTapOutside: (event) {
                        emailFocus.unfocus();
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        label: Text(
                          "Email Address",
                          style: TextStyle(
                            color: AppColors.secondaryText,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppColors.secondaryText,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                            color: AppColors.fabColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      focusNode: passFocus,
                      obscureText: isProtected,
                      style: TextStyle(
                        color: AppColors.primaryText,
                      ),
                      controller: passwordController,
                      onTap: () {
                        setState(() {});
                      },
                      onTapOutside: (event) {
                        passFocus.unfocus();
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        label: Text(
                          "Password",
                          style: TextStyle(
                            color: AppColors.secondaryText,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: AppColors.secondaryText,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            isProtected = !isProtected;
                            setState(() {});
                          },
                          icon: isProtected
                              ? Icon(Icons.visibility_off_outlined)
                              : Icon(Icons.visibility_outlined),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                            color: AppColors.fabColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            horizontalTitleGap: 1,
                            controlAffinity:
                            ListTileControlAffinity.leading,
                            title: Text(
                              "Remember me",
                              style: TextStyle(
                                color: AppColors.appbarColor,
                                fontSize: 16,
                              ),
                            ),
                            value: rememberMe,
                            onChanged: (value) {
                              rememberMe = value!;
                              setState(() {});
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: AppColors.fabColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 200),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  // await Future.delayed(const Duration(seconds: 5));

                  for (var myUserData in Users) {
                    if (myUserData.email == emailController.text &&
                        myUserData.password == passwordController.text) {
                      loggedInUser = myUserData;
                      break;
                    }
                  }

                  if (loggedInUser != null) {
                    final SharedPreferences prefs =
                    await SharedPreferences.getInstance();

                    await prefs.setBool(
                      AppConstants.rememberMeFlag,
                      rememberMe,
                    );

                    if (rememberMe) {
                      await prefs.setString(
                        AppConstants.rememberMeEmail,
                        loggedInUser!.email,
                      );
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Welcome, ${loggedInUser!.name}",
                          style: TextStyle(fontSize: 17),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(
                          user: loggedInUser!,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Invalid email or password",
                          style: TextStyle(fontSize: 17),
                        ),
                        backgroundColor: AppColors.cancelIconColor,
                      ),
                    );
                  }

                  setState(() {
                    isLoading = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBtnColor,
                  padding: EdgeInsets.only(left: 160, right: 160),
                ),
                child: isLoading
                    ? CircularProgressIndicator(
                  color: AppColors.primaryText,
                )
                    : Text(
                  "Login",
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 5),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: AppColors.fabColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
