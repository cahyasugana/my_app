import 'package:flutter/material.dart';
import 'package:my_app/FrontEnd/elements/screens/routes/home_fragments/home_screen.dart';
import 'package:my_app/FrontEnd/elements/screens/routes/navi.dart';
import 'package:my_app/FrontEnd/elements/screens/login/login.dart';
import 'package:my_app/FrontEnd/elements/screens/routes/home_fragments/setting_screen.dart';
import 'package:my_app/FrontEnd/elements/screens/login/landing.dart';
import 'package:my_app/LATIHAN/UTS/about_us_uts.dart';
import 'package:my_app/LATIHAN/UTS/customer_service_screen.dart';
// import 'package:my_app/FrontEnd/elements/screens/splash.dart';
import 'package:my_app/LATIHAN/note_screen.dart';
import 'package:my_app/LATIHAN/news_screen.dart';
import 'package:my_app/LATIHAN/si_api_screen.dart';
import 'package:my_app/PinjamNada/Screens/addInstrument.dart';
import 'package:my_app/PinjamNada/Screens/dashboard.dart';
import 'package:my_app/PinjamNada/Screens/myInstrument.dart';
import 'package:my_app/PinjamNada/Screens/myLoan.dart';
import 'package:my_app/PinjamNada/Screens/profile.dart';
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
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/news': (context) => const NewsScreen(),
        '/sqflite': (context) => const NoteScreen(),
        '/main': (context) => const MyApp(),
        '/landing': (context) => const Landing(),
        '/login': (context) => const Login(),
        '/home-screen': (context) => HomeScreen(),
        '/setting-screen': (context) => const SettingScreen(),
        '/datas-screen': (context) => const DatasScreen(),
        '/customer-service-screen': (context) => const UtsScreen(),
        '/about-us': (context) => AboutUs(),

        //PINJAM NADA
        '/navi': (context) => MyHomePage(),
        '/profile': (context) => Profile(),
        '/dashboard': (context) => Dashboard(),
        '/my-instrument': (context) => MyInstrument(),
        '/my-loan': (context) => MyLoan(),
        '/add-instrument': (context) => AddInstrument(),
      },
    );
  }
}
