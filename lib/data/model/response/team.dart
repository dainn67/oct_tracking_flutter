class Team {
  String createDate;
  String createdBy;
  String modifyDate;
  String modifiedBy;
  String id;
  String name;
  String code;
  String description;
  List<String>? members;

  Team({
    required this.createDate,
    required this.createdBy,
    required this.modifyDate,
    required this.modifiedBy,
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    this.members,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      createDate: json['createDate'],
      createdBy: json['createdBy'],
      modifyDate: json['modifyDate'],
      modifiedBy: json['modifiedBy'],
      id: json['id'],
      name: json['name'],
      code: json['code'],
      description: json['description'],
      members: json['members'] != null ? List<String>.from(json['members']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createDate': createDate,
      'createdBy': createdBy,
      'modifyDate': modifyDate,
      'modifiedBy': modifiedBy,
      'id': id,
      'name': name,
      'code': code,
      'description': description,
      'members': members,
    };
  }
}
