import 'package:flutter/material.dart';
import 'package:my_app/FrontEnd/elements/screens/routes/home_fragments/history.dart';
// import 'package:my_app/main.dart';
import 'package:my_app/FrontEnd/elements/screens/routes/home_fragments/home_screen.dart';
// import 'package:my_app/FrontEnd/elements/screens/routes/home_fragments/profile_screen.dart';
// import 'package:my_app/FrontEnd/elements/screens/routes/home_fragments/setting_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:my_app/FrontEnd/elements/screens/routes/home_fragments/shopping_cart.dart';
// import 'package:my_app/FrontEnd/elements/screens/routes/home_fragments/profile_screen.dart';
import 'package:my_app/FrontEnd/elements/components/asset_image_widget.dart';
import 'package:my_app/PinjamNada/Screens/dashboard.dart';
import 'package:my_app/PinjamNada/Screens/myInstrument.dart';
import 'package:my_app/PinjamNada/Screens/myLoan.dart';
import 'package:my_app/PinjamNada/cubit/auth/auth_cubit.dart';
import 'package:my_app/PinjamNada/cubit/instruments/instruments_cubit.dart';
import 'package:my_app/PinjamNada/cubit/loan/loan_cubit.dart';
import 'package:my_app/PinjamNada/cubit/my_instruments/my_instruments_cubit.dart';
import 'package:my_app/dto/dto_uts.dart';
import 'package:my_app/main.dart';
import 'package:my_app/PinjamNada/cubit/user/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 1;
  late AuthCubit _authCubit;
  late UserCubit _userCubit;
  late InstrumentsCubit _instrumentsCubit;
  late LoanCubit _loanCubit;
  late MyInstrumentsCubit _myInstrumentsCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = BlocProvider.of<AuthCubit>(context);
    _userCubit = BlocProvider.of<UserCubit>(context);
    _instrumentsCubit = BlocProvider.of<InstrumentsCubit>(context);
    _loanCubit = BlocProvider.of<LoanCubit>(context);
    _myInstrumentsCubit = BlocProvider.of<MyInstrumentsCubit>(context);
    print(_userCubit.roles);
  }

  final List<Widget> _screens = [
    const MyInstrument(),
    const Dashboard(),
    const MyLoan(),
  ];

  final List<String> _pageTitles = ['My Instrument', 'Dashboard', 'My Loan'];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _navigateToProfileScreen(BuildContext context) {
    // Check if the selected index is equal to the index of the profile screen
    if (selectedIndex != 2) {
      setState(() {
        selectedIndex = 2; // Set the selected index to the profile screen index
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: Text(
          _pageTitles[selectedIndex],
          style: const TextStyle(
            color: Colors.white,
          ),
        ), // Update title dynamically // Hide leading icon on ProfileScreen
        actions: [
          IconButton(
            // Only show profile button if not on ProfileScreen
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.blueGrey[300],
        child: Column(
          children: [
            const DrawerHeader(
              child: AssetImageWidget(
                imagePath: 'assets/images/logoPinjamNadaPutih.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            ExpansionTile(
              leading:
                  const Icon(Icons.arrow_right, size: 28), // Indent the submenu
              title: const Text('DANAN | 4C'), // Submenu title
              children: [
                ListTile(
                  leading: const Icon(Icons.assignment_rounded, size: 28),
                  title: const Text('TUGAS API'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/news');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.assignment_rounded, size: 28),
                  title: const Text('TUGAS SQFLite'), // Submenu item
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/sqflite');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image, size: 28),
                  title: const Text('TUGAS API Gambar'), // Submenu item
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/datas-screen');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image, size: 28),
                  title: const Text('UTS'), // Submenu item
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/customer-service-screen');
                  },
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.home, size: 28),
              title: const Text('About Us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about-us');
              },
            ),
            ListTile(
              leading: const Icon(Icons.home, size: 28),
              title: const Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings, size: 28),
              title: const Text('SETTINGS'),
              onTap: () {},
            ),
            _userCubit.roles == "admin"
                ? ListTile(
                    leading: const Icon(Icons.exit_to_app, size: 28),
                    title: const Text('ADMIN'),
                    onTap: () {},
                  )
                : SizedBox.shrink(),
            ListTile(
              leading: const Icon(Icons.exit_to_app, size: 28),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
                _userCubit.logout();
                _authCubit.logout();
                _instrumentsCubit.logout();
                _loanCubit.logout();
                _myInstrumentsCubit.logout();
              },
            ),
          ],
        ),
      ),
      body: _screens[selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        items: const <Widget>[
          Icon(Icons.history, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.shopping_cart, size: 30),
        ],
        color: primary,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: secondary,
        height: 50,
        animationDuration: const Duration(milliseconds: 500),
        index: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
