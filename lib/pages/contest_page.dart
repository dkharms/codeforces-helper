import 'package:codeforces_helper/controllers/api_controller.dart';
import 'package:codeforces_helper/models/contest.dart';
import 'package:codeforces_helper/utils/app_values.dart';
import 'package:codeforces_helper/widgets/cards/contest_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContestPage extends StatefulWidget {
  const ContestPage({Key? key}) : super(key: key);

  @override
  State<ContestPage> createState() => _ContestPageState();
}

class _ContestPageState extends State<ContestPage> {
  late DateTime _startTime;
  late DateTime _endTime;

  Future<void> _onPressed() async {
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
  }

  Future<void> _onRefresh() async {
    if (mounted) setState(() {});
  }

  Widget _builder(BuildContext context, AsyncSnapshot snapshot) {
    if (!snapshot.hasData ||
        snapshot.connectionState == ConnectionState.waiting)
      return Center(child: Image.asset(AppValues.loadingGifPath));

    if (snapshot.hasError)
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppValues.emptyGifPath),
            Text(AppValues.contestLoadError)
          ],
        ),
      );

    List<Contest> contestList = snapshot.data;

    if (contestList.length == 0)
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppValues.emptyGifPath),
            Text(AppValues.contestsNotFound),
          ],
        ),
      );

    return ListView.builder(
      reverse: true,
      itemCount: contestList.length,
      itemBuilder: (BuildContext context, int index) {
        return ContestCard(contest: contestList[index]);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startTime =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _endTime = DateTime.now().add(Duration(days: 31));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text(AppValues.fabContestsTitle),
        icon: Icon(Icons.date_range),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: _onPressed,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Container(
          width: double.infinity,
          child: FutureBuilder<List<Contest>>(
            future: ApiController.getContestsByTime(_startTime, _endTime),
            builder: _builder,
          ),
        ),
      ),
    );
  }
}
