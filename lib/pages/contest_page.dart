import 'package:codeforces_helper/components/cards/contest_card.dart';
import 'package:codeforces_helper/components/painters/wave_painter.dart';
import 'package:codeforces_helper/controllers/api_controller.dart';
import 'package:codeforces_helper/models/contest.dart';
import 'package:codeforces_helper/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ContestPage extends StatefulWidget {
  const ContestPage({Key? key}) : super(key: key);

  @override
  State<ContestPage> createState() => _ContestPageState();
}

class _ContestPageState extends State<ContestPage> {
  late DateTime _startTime = DateTime.now();
  late DateTime _endTime = DateTime.now().add(Duration(days: 31));

  FloatingActionButton _buildFloatingActionButton(String title) {
    return FloatingActionButton.extended(
      label: Text(title),
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
          if (mounted) setState(() {});
        }
      },
    );
  }

  Widget _buildContestCards(List<Contest> contestList) {
    if (contestList.length == 0)
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/empty.gif"),
            Text("No contests during this period")
          ],
        ),
      );

    return ListView.builder(
      itemCount: contestList.length,
      itemBuilder: (BuildContext context, int index) {
        return ContestCard(
            contest: contestList[contestList.length - index - 1]);
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton("Date Range"),
      body: RefreshIndicator(
        onRefresh: () async {
          if (mounted) setState(() {});
        },
        child: Container(
          width: double.infinity,
          child: FutureBuilder<List<Contest>>(
            future: ApiController.getContestsByTime(_startTime, _endTime),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting)
                return Center(child: Image.asset("assets/images/loading.gif"));

              return _buildContestCards(snapshot.data);
            },
          ),
        ),
      ),
    );
  }
}
