import 'package:codeforces_helper/components/cards/contest_card.dart';
import 'package:codeforces_helper/components/painters/wave_painter.dart';
import 'package:codeforces_helper/controllers/api_controller.dart';
import 'package:codeforces_helper/models/contest.dart';
import 'package:codeforces_helper/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContestPage extends StatefulWidget {
  const ContestPage({Key? key}) : super(key: key);

  @override
  State<ContestPage> createState() => _ContestPageState();
}

class _ContestPageState extends State<ContestPage> {
  late List<Contest> _contestList = <Contest>[];

  late DateTime _startTime = DateTime.now();
  late DateTime _endTime = DateTime.now().add(Duration(days: 31));

  void _getContestInfoByTime(DateTime? startTime, DateTime? endTime) async {
    _contestList = await ApiController.getContestsByTime(startTime!, endTime!);
    if (mounted) setState(() {});
  }

  FloatingActionButton _buildFloatingActionButton(String title) {
    return FloatingActionButton.extended(
      label: Text(title, style: GoogleFonts.poppins()),
      icon: Icon(Icons.date_range),
      backgroundColor: blueColor,
      onPressed: () async {
        final date = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2009),
          lastDate: DateTime.now().add(Duration(days: 31)),
        );

        if (date?.start != null && date?.end != null) {
          _startTime = date!.start;
          _endTime = date.end;
          _getContestInfoByTime(_startTime, _endTime);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getContestInfoByTime(_startTime, _endTime);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingActionButton("Date Range"),
      body: RefreshIndicator(
        onRefresh: () async {
          _getContestInfoByTime(_startTime, _endTime);
        },
        child: Container(
          width: double.infinity,
          child: ListView.builder(
            itemCount: _contestList.length,
            itemBuilder: (BuildContext context, int index) {
              return ContestCard(contest: _contestList[index]);
            },
          ),
        ),
      ),
    );
  }
}
