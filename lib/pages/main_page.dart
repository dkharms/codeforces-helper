import 'package:codeforces_helper/pages/contest_page.dart';
import 'package:codeforces_helper/pages/problem_page.dart';
import 'package:codeforces_helper/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  late int _pageIndex = 0;

  late List<Widget> _pages = [
    ContestPage(),
    ProblemPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (int index) {
          setState(() {
            _pageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.star_rate_rounded), label: "Contests"),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded), label: "Problems"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
