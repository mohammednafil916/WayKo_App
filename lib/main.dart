import 'package:flutter/material.dart';
import 'package:wayko/Screens/splash_screen.dart';

void main() {
  runApp(WayKoApp());
}

class WayKoApp extends StatelessWidget {
  const WayKoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
