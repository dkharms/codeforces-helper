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

  List<Widget> _buildContestCards(List<Contest> contestList) {
    List<Widget> contestCards = <Widget>[];
    for (var contest in contestList) {
      contestCards.add(InkWell(
        onTap: () {},
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Text(contest.name),
              Text(contest.startTime.toLocal().toString())
            ],
          ),
        ),
      ));
    }

    return contestCards;
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
          height: 160,
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
                  onTap: () {
                    print("Hello World!");
                  },
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
                        SizedBox(height: 30.0),
                        Text("Duration", style: informationTextStyle),
                        Text("Starts in", style: informationTextStyle)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.notifications_none_rounded))
          ]),
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final Color firstColor;
  final Color secondColor;

  WavePainter({required this.firstColor, required this.secondColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint wavePaint = Paint()
      ..shader = LinearGradient(colors: [
        firstColor.withOpacity(0.25),
        secondColor.withOpacity(0.25)
      ]).createShader(Rect.fromLTRB(0, 0, size.width, 0.5 * size.height));

    final w = size.width;
    final h = size.height;

    final path = Path()
      ..moveTo(0, 0.5 * size.height)
      ..quadraticBezierTo(w / 4, h / 6, w / 2, h / 2)
      ..quadraticBezierTo(3 * w / 4, 0.8 * h, w, 0.25 * h)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(WavePainter oldDelegate) => false;
}
