import 'package:codeforces_helper/components/painters/wave_painter.dart';
import 'package:codeforces_helper/models/problem.dart';
import 'package:codeforces_helper/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProblemCard extends StatefulWidget {
  final Problem problem;

  ProblemCard({
    Key? key,
    required this.problem,
  }) : super(key: key);

  @override
  _ProblemCardState createState() => _ProblemCardState();
}

class _ProblemCardState extends State<ProblemCard> {
  late double _additionalSize;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    _additionalSize = MediaQuery.of(context).size.height / 10;
    return AnimatedContainer(
      curve: Curves.decelerate,
      duration: Duration(milliseconds: 150),
      height: MediaQuery.of(context).size.height / 5 +
          (_isExpanded ? _additionalSize : 0),
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
            firstColor: yellowColor,
            secondColor: peachColor,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                launch(widget.problem.websiteUrl);
              },
              onLongPress: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: cardHorizontalPadding,
                    vertical: cardVerticalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.problem.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: contestTitleTextStyle.copyWith(
                            foreground: Paint()
                              ..shader = firstDivisionGradient)),
                    Expanded(child: Container()),
                    Text('Rating ${widget.problem.rating}',
                        style: informationTextStyle),
                    _isExpanded
                        ? Text('Tags ${widget.problem.tags}',
                            style: informationTextStyle)
                        : SizedBox(),
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
            onPressed: () {},
            shape: CircleBorder(),
            child: Icon(Icons.share_outlined),
          ),
        )
      ]),
    );
  }
}
