class Contest {
  late int id;
  late String name;
  late String description;
  late DateTime startTime;
  late Duration duration;

  Contest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "EMPTY";
    description = json['description'] ?? "EMPTY";
    startTime =
        DateTime.fromMillisecondsSinceEpoch(json['startTimeSeconds'] * 1000);

    int hours = json['startTimeSeconds'] ~/ 3600;
    int minutes = json['startTimeSeconds'] ~/ 60 % 60;
    duration = Duration(hours: hours, minutes: minutes);
  }

  @override
  String toString() {
    return "Name: $name\tStart time: $startTime";
  }
}
