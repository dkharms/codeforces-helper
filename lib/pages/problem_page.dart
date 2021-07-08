import 'package:codeforces_helper/controllers/api_controller.dart';
import 'package:codeforces_helper/models/problem.dart';
import 'package:codeforces_helper/values/tags.dart';
import 'package:codeforces_helper/widgets/cards/problem_card.dart';
import 'package:codeforces_helper/widgets/tags/tag_button.dart';
import 'package:flutter/material.dart';

class ProblemPage extends StatefulWidget {
  ProblemPage({Key? key}) : super(key: key);

  @override
  _ProblemPageState createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
  late int _rating;
  late List<String> _tags;

  List<Widget> _buildTagButtons() {
    return List<Widget>.generate(
      tags.length,
      (index) => TagButton(
        tagName: tags[index],
        filters: _tags,
      ),
    );
  }

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
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: 'Rating'),
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      onChanged: (String rating) {
                        if (rating.isNotEmpty) _rating = int.parse(rating);
                      },
                    ),
                    Wrap(children: _buildTagButtons())
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (mounted) setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
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
  void initState() {
    super.initState();
    _rating = 800;
    _tags = List.from(tags);
  }

  @override
  void dispose() {
    _tags.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: _buildFloatingActionButton('Rating and Tags'),
      body: Container(
        width: double.infinity,
        child: FutureBuilder<List<Problem>>(
          future: ApiController.getProblemsByRating(_rating, _tags),
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
