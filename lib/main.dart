import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'utils/theme_manager.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.getTheme(),
      home: HomePage(),
    );
  }
}
