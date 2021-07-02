import 'package:codeforces_helper/components/cards/problem_card.dart';
import 'package:codeforces_helper/controllers/api_controller.dart';
import 'package:codeforces_helper/models/problem.dart';
import 'package:codeforces_helper/values/constants.dart';
import 'package:flutter/material.dart';

class ProblemPage extends StatefulWidget {
  ProblemPage({Key? key}) : super(key: key);

  @override
  _ProblemPageState createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
  int _rating = 800;

  FloatingActionButton _buildFloatingActionButton(String title) {
    return FloatingActionButton.extended(
      label: Text(title),
      icon: Icon(Icons.date_range),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () async {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: TextField(
                keyboardType: TextInputType.number,
                maxLines: 1,
                onChanged: (String rating) {
                  if (rating.isNotEmpty) _rating = int.parse(rating);
                },
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      if (mounted) setState(() {});
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'))
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildProblemCards(List<Problem> problemList) {
    if (problemList.length == 0)
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/empty.gif'),
            Text('No problems with this rating')
          ],
        ),
      );

    return ListView.builder(
        itemCount: problemList.length,
        itemBuilder: (BuildContext context, int index) =>
            ProblemCard(problem: problemList[problemList.length - index - 1]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: _buildFloatingActionButton('Rating'),
      body: Container(
        width: double.infinity,
        child: FutureBuilder<List<Problem>>(
          future: ApiController.getProblemsByRating(_rating),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting)
              return Center(child: Image.asset('assets/images/loading.gif'));

            return _buildProblemCards(snapshot.data);
          },
        ),
      ),
    );
  }
}
