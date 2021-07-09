import 'package:codeforces_helper/utils/app_values.dart';

class Contest {
  late int id;
  late String name;
  late String description;
  late String websiteUrl;
  late ContestState contestState;
  late DateTime startTime;
  late Duration duration;

  Contest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "EMPTY";
    description = json['description'] ?? "EMPTY";
    websiteUrl = "https://codeforces.com/contest/$id";
    contestState = ContestState.FINISHED;

    if (json['phase'] == "BEFORE") {
      contestState = ContestState.BEFORE;
    }

    if (json['phase'] == "CODING") {
      contestState = ContestState.CODING;
    }

    startTime =
        DateTime.fromMillisecondsSinceEpoch(json['startTimeSeconds'] * 1000)
            .toLocal();

    duration = Duration(
        hours: json['durationSeconds'] ~/ 3600,
        minutes: json['durationSeconds'] ~/ 60 % 60);
  }

  String get getStartTime =>
      '${AppValues.startTime}' +
      '${startTime.day}-${startTime.month}-${startTime.year} ' +
      '${startTime.hour}h-${startTime.minute}m';

  String get getDuration =>
      '${AppValues.duration}' +
      '${duration.inHours}h ${duration.inMinutes % 60}m';
}

enum ContestState { BEFORE, CODING, FINISHED }
