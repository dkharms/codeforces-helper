import 'package:codeforces_helper/utils/app_styles.dart';
import 'package:flutter/material.dart';

class TagButton extends StatefulWidget {
  final String tagName;
  final List<String> filters;

  TagButton({
    Key? key,
    required this.tagName,
    required this.filters,
  }) : super(key: key);

  @override
  _TagButtonState createState() => _TagButtonState();
}

class _TagButtonState extends State<TagButton> {
  void _onSelected(bool value) {
    setState(() {
      if (widget.filters.contains(widget.tagName))
        widget.filters.remove(widget.tagName);
      else
        widget.filters.add(widget.tagName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: FilterChip(
        label: Text(widget.tagName, style: AppStyles.informationTextStyle),
        selected: widget.filters.contains(widget.tagName),
        selectedColor: Theme.of(context).primaryColor,
        onSelected: _onSelected,
      ),
    );
  }
}
