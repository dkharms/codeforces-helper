import 'dart:convert';

import 'package:codeforces_helper/models/contest.dart';
import 'package:http/http.dart' as http;

class ApiController {
  static Future<List<Contest>> getContestsByTime(
      DateTime startTime, DateTime endTime) async {
    var contestList = <Contest>[];
    var response =
        await http.get(Uri.parse("https://codeforces.com/api/contest.list"));

    if (response.statusCode == 200) {
      var contestEntries = jsonDecode(response.body)['result'];

      for (var contestEntry in contestEntries) {
        DateTime contestTime = DateTime.fromMillisecondsSinceEpoch(
            contestEntry['startTimeSeconds'] * 1000);

        if (startTime.compareTo(contestTime) <= 0 &&
            contestTime.compareTo(endTime) <= 0) {
          contestList.add(Contest.fromJson(contestEntry));
        }
      }
    } else {
      throw Exception("Failed to load contest");
    }

    return contestList;
  }
}
