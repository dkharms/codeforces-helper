class Problem {
  late int contestId;
  late String name;
  late String index;
  late int rating;
  late String websiteUrl;
  late List<dynamic> tags;

  Problem.fromJson(Map<String, dynamic> json) {
    contestId = json['contestId'];
    name = json['name'];
    index = json['index'];
    rating = json['rating'] ?? 800;
    websiteUrl = 'https://codeforces.com/problemset/problem/$contestId/$index';
    tags = json['tags'];
  }
}
