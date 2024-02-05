class ProjectModel {
  String? id;
  String code;
  String name;
  String status;
  String description;
  dynamic task;

  ProjectModel({required this.id,
    required this.code,
    required this.name,
    required this.status,
    required this.description,
    required this.task});

  factory ProjectModel.fromJson(Map<String, dynamic> json){
    return ProjectModel(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        status: json['status'],
        description: json['description'],
        task: json['task']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['status'] = status;
    data['description'] = description;
    data['task'] = task;

    return data;
  }
}
