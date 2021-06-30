import 'package:codeforces_helper/pages/contest_page.dart';
import 'package:codeforces_helper/pages/main_page.dart';
import 'package:codeforces_helper/values/themes.dart';
import 'package:flutter/material.dart';

void main() => runApp(const CodeforcesHelper());

class CodeforcesHelper extends StatelessWidget {
  const CodeforcesHelper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Codeforces Helper",
      theme: lightTheme,
      home: MainPage(),
    );
  }
}
