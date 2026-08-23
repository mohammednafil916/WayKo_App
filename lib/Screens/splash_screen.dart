import 'package:flutter/material.dart';
import 'package:wayko/Routes/screens_routes.dart';
import 'package:wayko/Services/session_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(Duration(seconds: 3));

    bool loggedIn = await SessionService.isLoggedIn();

    if (loggedIn) {
      Navigator.pushReplacementNamed(context, AppRoutes.navigation);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          "assets/images/Logo_Motto_Image.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
