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
import 'package:my_app/main.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 1;

  final List<Widget> _screens = [
    History(),
    HomeScreen(),
    CartScreen(),
  ];

  final List<String> _pageTitles = ['History', 'Home', 'Cart'];

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
          style: TextStyle(
            color: Colors.white,
          ),
        ), // Update title dynamically // Hide leading icon on ProfileScreen
        actions: [
          IconButton(
            // Only show profile button if not on ProfileScreen
            icon: Icon(Icons.person, color: Colors.white,),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.blueGrey[300],
        child: Column(
          children: [
            DrawerHeader(
              child: const AssetImageWidget(
                imagePath: 'assets/images/Logo.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            ExpansionTile(
              leading: Icon(Icons.arrow_right, size: 28), // Indent the submenu
              title: Text('DANAN | 4C'), // Submenu title
              children: [
                ListTile(
                  leading: Icon(Icons.assignment_rounded, size: 28),
                  title: Text('TUGAS API'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/news');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.assignment_rounded, size: 28),
                  title: Text('TUGAS SQFLite'), // Submenu item
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/sqflite');
                  },
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.home, size: 28),
              title: Text('About Us'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.home, size: 28),
              title: Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings, size: 28),
              title: Text('SETTINGS'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: _screens[selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(Icons.history, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.shopping_cart, size: 30),
        ],
        color: primary,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: secondary,
        height: 50,
        animationDuration: Duration(milliseconds: 500),
        index: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
