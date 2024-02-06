class TeamBody {
  final String name;
  final String code;
  final String description;

  TeamBody({
    required this.name,
    required this.code,
    required this.description,
  });

  factory TeamBody.fromJson(Map<String, dynamic> json) {
    return TeamBody(
      name: json['name'],
      code: json['code'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'description': description,
    };
  }
}
