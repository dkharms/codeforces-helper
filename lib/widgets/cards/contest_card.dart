import 'package:codeforces_helper/models/contest.dart';
import 'package:codeforces_helper/utils/app_settings.dart';
import 'package:codeforces_helper/utils/app_styles.dart';
import 'package:codeforces_helper/widgets/painters/wave_painter.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
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
    _firstColor = AppStyles.pinkColor;
    _secondColor = AppStyles.blueColor;
    _gradient = AppStyles.otherDivisionContest;

    if (contest.name.contains("Div. 1")) {
      _firstColor = AppStyles.yellowColor;
      _secondColor = AppStyles.peachColor;
      _gradient = AppStyles.firstDivisionGradient;
    }

    if (contest.name.contains("Div. 2")) {
      _firstColor = AppStyles.purpleColor;
      _secondColor = AppStyles.blueColor;
      _gradient = AppStyles.secondDivisionGradient;
    }

    if (contest.name.contains("Div. 3")) {
      _firstColor = AppStyles.greenColor;
      _secondColor = AppStyles.cyanColor;
      _gradient = AppStyles.thirdDivisionGradient;
    }
  }

  Widget _buildBottomRightWidget() {
    if (contest.contestState == ContestState.BEFORE)
      return RawMaterialButton(
        onPressed: () {},
        shape: CircleBorder(),
        child: Icon(Icons.notifications_none_rounded),
      );

    if (contest.contestState == ContestState.CODING)
      return RawMaterialButton(
        onPressed: () async {
          await Share.share(contest.websiteUrl);
        },
        shape: CircleBorder(),
        child: Text("🔥"),
      );

    return RawMaterialButton(
      onPressed: () async {
        await Share.share(contest.websiteUrl);
      },
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
        horizontal: AppSettings.cardHorizontalMargin,
        vertical: AppSettings.cardVerticalMargin,
      ),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: AppStyles.shadowColor.withOpacity(0.25),
          spreadRadius: AppSettings.shadowSpreadRadius,
          blurRadius: AppSettings.shadowBlurRadius,
        ),
      ]),
      child: Stack(children: [
        CustomPaint(
          painter: WavePainter(
            canvasHeight: MediaQuery.of(context).size.height / 5,
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
                    horizontal: AppSettings.cardHorizontalPadding,
                    vertical: AppSettings.cardVerticalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contest.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.contestTitleTextStyle
                          .copyWith(foreground: Paint()..shader = _gradient),
                    ),
                    Expanded(child: Container()),
                    Text(
                      contest.getDuration,
                      style: AppStyles.informationTextStyle,
                    ),
                    Text(
                      contest.getStartTime,
                      style: AppStyles.informationTextStyle,
                    )
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
