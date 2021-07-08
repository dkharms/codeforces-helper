import 'package:codeforces_helper/pages/contest_page.dart';
import 'package:codeforces_helper/pages/problem_page.dart';
import 'package:codeforces_helper/utils/app_values.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  late int _activePageIndex = 0;

  late List<Widget> _pages = [
    ContestPage(),
    ProblemPage(),
  ];

  late List<BottomNavigationBarItem> _bottomNavigationItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.star_rate_rounded),
      label: AppValues.contests,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list_alt_rounded),
      label: AppValues.problems,
    ),
  ];

  void _onTap(int index) {
    setState(() {
      _activePageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_activePageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        showUnselectedLabels: false,
        currentIndex: _activePageIndex,
        onTap: _onTap,
        items: _bottomNavigationItems,
      ),
    );
  }
}
