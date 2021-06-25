import 'package:codeforces_helper/pages/main_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const CodeforcesHelper());

class CodeforcesHelper extends StatelessWidget {
  const CodeforcesHelper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}
