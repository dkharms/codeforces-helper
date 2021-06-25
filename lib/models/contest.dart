class Contest {

  late int id;
  late String name;
  late String description;
  late DateTime startTime;
  late DateTime duration;

  Contest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name =  json['name'] ?? "EMPTY";
    description = json['description'] ?? "EMPTY";
    startTime = DateTime.fromMillisecondsSinceEpoch(json['startTimeSeconds'] * 1000);
    duration = DateTime.fromMillisecondsSinceEpoch(json['durationSeconds'] * 1000);
  }


  @override
  String toString() {
    return "Name: $name\tStart time: $startTime";
  }
}