import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/FrontEnd/elements/screens/routes/home_fragments/home_screen.dart';
import 'package:my_app/FrontEnd/elements/screens/routes/navi.dart';
import 'package:my_app/PinjamNada/Screens/aboutUs.dart';
import 'package:my_app/PinjamNada/cubit/auth/auth_cubit.dart';
import 'package:my_app/PinjamNada/cubit/instruments/instruments_cubit.dart';
import 'package:my_app/PinjamNada/cubit/my_instruments/my_instruments_cubit.dart';
import 'package:my_app/PinjamNada/cubit/user/user_cubit.dart';
import 'package:my_app/PinjamNada/login/login_screen.dart';
import 'package:my_app/FrontEnd/elements/screens/routes/home_fragments/setting_screen.dart';
import 'package:my_app/PinjamNada/login/landing.dart';
// import 'package:my_app/LATIHAN/UTS/about_us_uts.dart';
import 'package:my_app/LATIHAN/UTS/customer_service_screen.dart';
// import 'package:my_app/FrontEnd/elements/screens/splash.dart';
import 'package:my_app/LATIHAN/note_screen.dart';
import 'package:my_app/news_screen.dart';
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
const Color bases = Color(0xFF5C99C4);
const Color primary = Color(0xFF5C88C4);
const Color secondary = Color(0xFFC4985C);
String namaApp = 'Pinjam Nada';

// static const Color primaryBlue = Color(0xFF5C88C4);
//   static const Color complementaryOrange = Color(0xFFC4985C);
//   static const Color analogousBlue1 = Color(0xFF5C72C4);
//   static const Color analogousBlue2 = Color(0xFF5C99C4);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<UserCubit>(create: (context) => UserCubit()),
        BlocProvider<InstrumentsCubit>(create: (context) => InstrumentsCubit()),
        BlocProvider<MyInstrumentsCubit>(create: (context) => MyInstrumentsCubit())
      ],
      child: MaterialApp(
        title: 'Restaurant',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        debugShowCheckedModeBanner: false,
        routes: {
          '/news': (context) => const NewsScreen(),
          '/sqflite': (context) => const NoteScreen(),
          '/main': (context) => const MyApp(),
          '/landing': (context) => const Landing(),
          '/login': (context) => LoginScreen(),
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
      ),
    );
  }
}
