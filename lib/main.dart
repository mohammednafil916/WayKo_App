import 'package:flutter/material.dart';
import 'package:wayko/Screens/login_screen.dart';
import 'package:wayko/Screens/navigation_screen.dart';
import 'package:wayko/Theme/app_theme.dart';
import 'Routes/screens_routes.dart';

void main() {
  runApp(WayKoApp());
}

class WayKoApp extends StatelessWidget {
  const WayKoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
      theme: AppTheme.lightTheme,
    );
  }
}
