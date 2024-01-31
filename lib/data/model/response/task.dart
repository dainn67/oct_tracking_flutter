class Task {
  String createDate;
  String createdBy;
  String modifyDate;
  String modifiedBy;
  String id;
  double overtimeHour;
  double officeHour;
  String taskOffice;
  String taskOverTime;
  Project project;

  Task({
    required this.createDate,
    required this.createdBy,
    required this.modifyDate,
    required this.modifiedBy,
    required this.id,
    required this.overtimeHour,
    required this.officeHour,
    required this.taskOffice,
    required this.taskOverTime,
    required this.project,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      createDate: json['createDate'],
      createdBy: json['createdBy'],
      modifyDate: json['modifyDate'],
      modifiedBy: json['modifiedBy'],
      id: json['id'],
      overtimeHour: json['overtimeHour'],
      officeHour: json['officeHour'],
      taskOffice: json['taskOffice'],
      taskOverTime: json['taskOverTime'],
      project: Project.fromJson(json['project']),
    );
  }
}

class Project {
  String id;
  String name;
  String code;
  String status;
  String description;
  List<Task>? tasks;

  Project({
    required this.id,
    required this.name,
    required this.code,
    required this.status,
    required this.description,
    required this.tasks,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      status: json['status'],
      description: json['description'],
      tasks: null,
    );
  }
}
