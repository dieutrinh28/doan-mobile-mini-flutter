import 'package:doan_mini_flutter/screen/home.dart';
import 'package:doan_mini_flutter/screen/setting.dart';
import 'package:doan_mini_flutter/screen/signup.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({
    Key? key,
  }) : super(key: key);

  @override
  State<Navbar> createState() => NavbarState();
}

class NavbarState extends State<Navbar> {
  int selectedIndex = 0;

  List<Widget> pages = const [
    HomePage(),
    SignupPage(),
    SettingPage(),
  ];

  void onNavBarItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        onTap: onNavBarItemTapped,
      ),
    );
  }
}
