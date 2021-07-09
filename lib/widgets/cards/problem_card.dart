import 'package:codeforces_helper/models/problem.dart';
import 'package:codeforces_helper/utils/app_styles.dart';
import 'package:codeforces_helper/utils/app_settings.dart';
import 'package:codeforces_helper/widgets/painters/wave_painter.dart';
import 'package:codeforces_helper/widgets/tags/tag_mark.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
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
  late bool _isExpanded;

  List<Widget> _buildTagButtons() {
    return List.generate(
      widget.problem.tags.length,
      (index) => AnimatedOpacity(
        duration: Duration(milliseconds: 150),
        opacity: _isExpanded ? 1.0 : 0.0,
        child: TagMark(
          tagName: widget.problem.tags[index],
        ),
      ),
    );
  }

  Future<void> _shareUrl() async {
    await Share.share(widget.problem.websiteUrl);
  }

  Future<void> _launchUrl() async {
    launch(widget.problem.websiteUrl);
  }

  void _handleCardExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
    _additionalSize = widget.problem.tags.length * 25;
    _isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.decelerate,
      duration: Duration(milliseconds: 150),
      height: AppSettings.getHeight(MediaQuery.of(context).size, 0.2) +
          (_isExpanded ? _additionalSize : 0),
      margin: const EdgeInsets.symmetric(
        horizontal: AppSettings.cardHorizontalMargin,
        vertical: AppSettings.cardVerticalMargin,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppStyles.shadowColor.withOpacity(0.25),
            spreadRadius: AppSettings.shadowSpreadRadius,
            blurRadius: AppSettings.shadowBlurRadius,
          ),
        ],
      ),
      child: Stack(
        children: [
          CustomPaint(
            painter: WavePainter(
              canvasHeight:
                  AppSettings.getHeight(MediaQuery.of(context).size, 0.2),
              firstColor: AppStyles.yellowColor,
              secondColor: AppStyles.peachColor,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _launchUrl,
                onLongPress: _handleCardExpansion,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSettings.cardHorizontalPadding,
                      vertical: AppSettings.cardVerticalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.problem.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.contestTitleTextStyle.copyWith(
                            foreground: Paint()
                              ..shader = AppStyles.firstDivisionGradient),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Wrap(children: _buildTagButtons()),
                        ),
                      ),
                      Text(widget.problem.getRating,
                          style: AppStyles.informationTextStyle),
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
              onPressed: _shareUrl,
              shape: CircleBorder(),
              child: Icon(Icons.share_outlined),
            ),
          )
        ],
      ),
    );
  }
}
