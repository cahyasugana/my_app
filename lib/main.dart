import 'package:flutter/material.dart';
import 'package:my_app/FrontEnd/elements/screens/routes/home_fragments/home_screen.dart';
import 'package:my_app/FrontEnd/elements/screens/routes/navi.dart';
import 'package:my_app/FrontEnd/elements/screens/login/login.dart';
import 'package:my_app/FrontEnd/elements/screens/routes/home_fragments/setting_screen.dart';
import 'package:my_app/FrontEnd/elements/screens/login/landing.dart';
import 'package:my_app/FrontEnd/elements/screens/splash.dart';
import 'package:my_app/LATIHAN/note_screen.dart';
import 'package:my_app/LATIHAN/news_screen.dart';
// import 'package:my_app/FrontEnd/elements/screens/splash.dart';
// import 'package:my_app/FrontEnd/elements/screens/splash.dart';
// import 'package:my_app/latihan%20news/news_screen.dart';


//Global 
const Color bases = Colors.white;
const Color primary = Color.fromRGBO(125, 10, 10, 1);
const Color secondary = Color.fromRGBO(191, 49, 49, 1);
String namaApp = 'RestoKu';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(destinationWidget: Landing()),
      debugShowCheckedModeBanner: false,
      routes: {
        '/news' : (context) => NewsScreen(),
        '/sqflite' : (context) => NoteScreen(),
        '/main' : (context) => MyApp(),
        '/navi' : (context) => MyHomePage(),
        '/landing' : (context) => const Landing(),
        '/login' : (context) => const Login(),
        '/home-screen' : (context) => HomeScreen(),
        '/setting-screen' : (context) => const SettingScreen()
      },
    );
  }
}