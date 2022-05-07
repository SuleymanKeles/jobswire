
class Data {
  Data({
    required this.success,
    required this.result,
  });

  final bool success;
  final List<Result> result;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "result": List<dynamic>.from(result.map((x) => x.toMap())),
  };
}

class Result {
  Result({
    required this.key,
    required this.url,
    required this.description,
    required this.image,
    required this.name,
    required this.source,
  });

  final String key;
  final String url;
  final String description;
  final String image;
  final String name;
  final String source;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    key: json["key"],
    url: json["url"],
    description: json["description"],
    image: json["image"],
    name: json["name"],
    source: json["source"],
  );

  Map<String, dynamic> toMap() => {
    "key": key,
    "url": url,
    "description": description,
    "image": image,
    "name": name,
    "source": source,
  };
}
