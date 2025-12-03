import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'utils/theme_manager.dart';
import 'config/env.dart';
import 'services/oauth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load();
  OAuthService.instance.init();
  runApp(const MyApp());
}

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
