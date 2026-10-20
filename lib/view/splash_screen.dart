import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week4_practice/constant/app_Colors.dart';
import 'package:week4_practice/data/user_Data.dart';
import 'package:week4_practice/modal/user_Modal.dart';
import 'package:week4_practice/view/home.dart';
import 'package:week4_practice/view/login_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _email = "";
  String _password = "";
  bool _isChecked = false;
  User? userLoggedIn;

  Future<bool> getRememberValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('check_checker') ?? false;
  }

  Future<String> getEmailValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') ?? "";
  }

  Future<String> getPasswordValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('password') ?? "";
  }

  @override
  void initState() {
    super.initState();
    isRemember();
  }

  Future<void> initCalled() async {
    _email = await getEmailValue();
    _password = await getPasswordValue();
    _isChecked = await getRememberValue();
    setState(() {

    });
  }

  Future<void> isRemember() async {

    await initCalled();

    for (final user in Users) {
      if (_email == user.email && _password == user.password) {
        userLoggedIn = user;
        break;
      }
    }
    await Future.delayed(const Duration(seconds: 5));

    if (_isChecked && userLoggedIn != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Home(user: userLoggedIn!);
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
