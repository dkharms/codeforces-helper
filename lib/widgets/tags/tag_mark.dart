import 'package:codeforces_helper/utils/app_styles.dart';
import 'package:flutter/material.dart';

class TagMark extends StatelessWidget {
  final String tagName;
  const TagMark({Key? key, required this.tagName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, right: 10.0, bottom: 5.0),
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Theme.of(context).primaryColor),
      child: Text(tagName, style: AppStyles.informationTextStyle),
    );
  }
}
