class Contest {
  late int id;
  late String name;
  late String description;
  late String websiteUrl;
  late DateTime startTime;
  late Duration duration;

  Contest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "EMPTY";
    description = json['description'] ?? "EMPTY";
    websiteUrl = "https://codeforces.com/contest/$id";
    startTime =
        DateTime.fromMillisecondsSinceEpoch(json['startTimeSeconds'] * 1000)
            .toLocal();

    int hours = json['durationSeconds'] ~/ 3600;
    int minutes = json['durationSeconds'] ~/ 60 % 60;
    duration = Duration(hours: hours, minutes: minutes);
  }

  @override
  String toString() {
    return "Name: $name\tStart time: $startTime";
  }
}
