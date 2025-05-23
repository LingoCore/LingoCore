import 'package:flutter/material.dart';
import 'package:lingocore/globals.dart';
import 'package:lingocore/home_page.dart';
import 'package:lingocore/lesson_pages.dart';
import 'package:lingocore/login_page.dart';
import 'package:lingocore/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkSavedGlobals();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          (MediaQuery.of(context).platformBrightness == Brightness.dark)
              ? darkThemeData
              : lightThemeData,
      initialRoute: loggedInUser == null ? "login" : "home",
      routes: {
        "login": (context) => const LoginPage(),
        "home": (context) => const HomePage(),
        "lesson": (context) => const LessonPages(),
      },
    );
  }
}
