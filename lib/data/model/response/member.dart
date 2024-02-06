import 'package:timesheet/data/model/response/team.dart';

import '../body/user.dart';

class Member {
  String createDate;
  String createdBy;
  String modifyDate;
  String modifiedBy;
  String id;
  String name;
  String code;
  String gender;
  String type;
  String email;
  String position;
  String level;
  String status;
  String dateJoin;
  Team team;
  UserBody user;

  Member({
    required this.createDate,
    required this.createdBy,
    required this.modifyDate,
    required this.modifiedBy,
    required this.id,
    required this.name,
    required this.code,
    required this.gender,
    required this.type,
    required this.email,
    required this.position,
    required this.level,
    required this.status,
    required this.dateJoin,
    required this.team,
    required this.user,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      createDate: json['createDate'],
      createdBy: json['createdBy'],
      modifyDate: json['modifyDate'],
      modifiedBy: json['modifiedBy'],
      id: json['id'],
      name: json['name'],
      code: json['code'],
      gender: json['gender'],
      type: json['type'],
      email: json['email'],
      position: json['position'],
      level: json['level'],
      status: json['status'],
      dateJoin: json['dateJoin'],
      team: Team.fromJson(json['team']),
      user: UserBody.fromJson(json['user']),
    );
  }
}