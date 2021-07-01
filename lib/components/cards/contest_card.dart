import 'package:codeforces_helper/components/painters/wave_painter.dart';
import 'package:codeforces_helper/models/contest.dart';
import 'package:codeforces_helper/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContestCard extends StatelessWidget {
  final Contest contest;
  late Color _firstColor;
  late Color _secondColor;
  late Shader _gradient;

  ContestCard({
    Key? key,
    required this.contest,
  }) : super(key: key);

  _setupColors() {
    _firstColor = blueColor;
    _secondColor = pinkColor;
    _gradient = otherDivisionContest;

    if (contest.name.contains("Div. 1")) {
      _firstColor = yellowColor;
      _secondColor = peachColor;
      _gradient = firstDivisionGradient;
    }

    if (contest.name.contains("Div. 2")) {
      _firstColor = purpleColor;
      _secondColor = blueColor;
      _gradient = secondDivisionGradient;
    }

    if (contest.name.contains("Div. 3")) {
      _firstColor = greenColor;
      _secondColor = cyanColor;
      _gradient = thirdDivisionGradient;
    }
  }

  Widget _buildBottomRightWidget() {
    if (contest.contestState == ContestState.BEFORE)
      return RawMaterialButton(
        onPressed: () {},
        shape: CircleBorder(),
        child: Icon(Icons.notifications_none_rounded),
      );

    if (contest.contestState == ContestState.CODING) return Text("🔥");

    return RawMaterialButton(
      onPressed: () {},
      shape: CircleBorder(),
      child: Icon(Icons.share_outlined),
    );
  }

  @override
  Widget build(BuildContext context) {
    _setupColors();
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      margin: const EdgeInsets.symmetric(
        horizontal: cardHorizontalMargin,
        vertical: cardVerticalMargin,
      ),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: shadowColor.withOpacity(0.25),
          spreadRadius: shadowSpreadRadius,
          blurRadius: shadowBlurRadius,
        ),
      ]),
      child: Stack(children: [
        CustomPaint(
          painter: WavePainter(
            firstColor: _firstColor,
            secondColor: _secondColor,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                launch(contest.websiteUrl);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: cardHorizontalPadding,
                    vertical: cardVerticalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contest.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: contestTitleTextStyle.copyWith(
                            foreground: Paint()..shader = _gradient)),
                    Expanded(child: Container()),
                    Text(
                        "Duration ${contest.duration.inHours}h ${contest.duration.inMinutes - contest.duration.inHours * 60}m",
                        style: informationTextStyle),
                    Text(
                        "Starts ${contest.startTime.day}-${contest.startTime.month} in ${contest.startTime.hour}h ${contest.startTime.minute}m",
                        style: informationTextStyle)
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 5.0,
          right: -10.0,
          child: _buildBottomRightWidget(),
        )
      ]),
    );
  }
}
