import 'package:codeforces_helper/components/painters/wave_painter.dart';
import 'package:codeforces_helper/controllers/api_controller.dart';
import 'package:codeforces_helper/models/contest.dart';
import 'package:codeforces_helper/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Contest> _contestList = <Contest>[];

  void _getContestInfo() async {
    _contestList = await ApiController.getContests();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getContestInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Container(
          height: MediaQuery.of(context).size.height / 5,
          margin: const EdgeInsets.symmetric(
              horizontal: cardHorizontalMargin, vertical: cardVerticalMargin),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 20,
            ),
          ]),
          child: Stack(children: [
            CustomPaint(
              painter:
                  WavePainter(firstColor: greenColor, secondColor: cyanColor),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: cardHorizontalPadding,
                        vertical: cardVerticalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Codeforces #727 (Div. 2)",
                            style: contestTitleTextStyle),
                        Expanded(child: Container()),
                        Text("Duration", style: informationTextStyle),
                        Text("Starts in", style: informationTextStyle)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5.0,
              right: -10.0,
              child: RawMaterialButton(
                padding: EdgeInsets.all(0.0),
                onPressed: () {},
                shape: CircleBorder(),
                child: Icon(Icons.notifications_none_rounded),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
