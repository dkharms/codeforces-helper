import 'dart:convert';

import 'package:codeforces_helper/models/contest.dart';
import 'package:http/http.dart' as http;

class ApiController {
  static Future<List<Contest>> getContests() async {
    var contestList = <Contest>[];
    var response =
        await http.get(Uri.parse("https://codeforces.com/api/contest.list"));

    if (response.statusCode == 200) {
      var contestEntries = jsonDecode(response.body)['result'];
      for (var contestEntry in contestEntries) {
        if (contestEntry['phase'] == 'BEFORE') {
          contestList.add(Contest.fromJson(contestEntry));
        }
      }
    } else {
      throw Exception("Failed to load contest");
    }

    return contestList;
  }
}
