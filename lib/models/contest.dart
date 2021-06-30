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
      contestState = ContestState.BEFORE;
    }

    startTime =
        DateTime.fromMillisecondsSinceEpoch(json['startTimeSeconds'] * 1000)
            .toLocal();

    duration = Duration(
        hours: json['durationSeconds'] ~/ 3600,
        minutes: json['durationSeconds'] ~/ 60 % 60);
  }
}

enum ContestState { BEFORE, CODING, FINISHED }
