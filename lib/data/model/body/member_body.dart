import '../response/team.dart';

class MemberBody {
  final String name;
  final String code;
  final String dateJoin;
  final String status;
  final Team team;
  final String email;
  final String level;
  final String gender;
  final String type;
  final String position;

  MemberBody({
    required this.name,
    required this.code,
    required this.dateJoin,
    required this.status,
    required this.team,
    required this.email,
    required this.level,
    required this.gender,
    required this.type,
    required this.position,
  });

  factory MemberBody.fromJson(Map<String, dynamic> json) {
    return MemberBody(
      name: json['name'],
      code: json['code'],
      dateJoin: json['dateJoin'],
      status: json['status'],
      team: Team.fromJson(json['team']),
      email: json['email'],
      level: json['level'],
      gender: json['gender'],
      type: json['type'],
      position: json['position'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'dateJoin': dateJoin,
      'status': status,
      'team': team.toJson(),
      'email': email,
      'level': level,
      'gender': gender,
      'type': type,
      'position': position,
    };
  }
}
