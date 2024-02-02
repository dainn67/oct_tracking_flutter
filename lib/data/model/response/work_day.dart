import 'dart:convert';

import 'Task.dart';

class WorkingDay {
  String? createDate;
  String? createdBy;
  String? modifyDate;
  String? modifiedBy;
  String? id;
  bool? dayOff;
  String? dateWorking;
  Member? member;
  List<Task>? tasks;

  WorkingDay({
    required this.createDate,
    required this.createdBy,
    required this.modifyDate,
    required this.modifiedBy,
    required this.id,
    required this.dayOff,
    required this.dateWorking,
    required this.member,
    required this.tasks,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> receivedJson) {
    return WorkingDay(
      createDate: receivedJson['createDate'],
      createdBy: receivedJson['createdBy'],
      modifyDate: receivedJson['modifyDate'],
      modifiedBy: receivedJson['modifiedBy'],
      id: receivedJson['id'],
      dayOff: receivedJson['dayOff'],
      dateWorking: receivedJson['dateWorking'],
      member: receivedJson['member'] != null ? Member.fromJson(receivedJson['member']) : null,
      tasks: receivedJson['tasks'] != null
          ? (receivedJson['tasks'] as List)
              .map((taskJson) => Task.fromJson(taskJson))
              .toList()
          : null,
    );
  }
}

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
  User user;

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
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  String createDate;
  String createdBy;
  String modifyDate;
  String modifiedBy;
  int id;
  String? gender;
  String username;
  bool accountNonExpired;
  bool accountNonLocked;
  bool active;
  bool credentialsNonExpired;
  String email;
  String? phone;
  bool justCreated;
  int? lastLoginFailures;
  DateTime? lastLoginTime;
  int? totalLoginFailures;
  dynamic orgId;
  List<String>? roles;
  List<String>? authorities;

  User({
    required this.createDate,
    required this.createdBy,
    required this.modifyDate,
    required this.modifiedBy,
    required this.id,
    required this.gender,
    required this.username,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.active,
    required this.credentialsNonExpired,
    required this.email,
    required this.phone,
    required this.justCreated,
    required this.lastLoginFailures,
    required this.lastLoginTime,
    required this.totalLoginFailures,
    required this.orgId,
    required this.roles,
    required this.authorities,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      createDate: json['createDate'],
      createdBy: json['createdBy'],
      modifyDate: json['modifyDate'],
      modifiedBy: json['modifiedBy'],
      id: json['id'],
      gender: json['gender'],
      username: json['username'],
      accountNonExpired: json['accountNonExpired'],
      accountNonLocked: json['accountNonLocked'],
      active: json['active'],
      credentialsNonExpired: json['credentialsNonExpired'],
      email: json['email'],
      phone: json['phone'],
      justCreated: json['justCreated'],
      lastLoginFailures: json['lastLoginFailures'],
      lastLoginTime: json['lastLoginTime'] != null
          ? DateTime.parse(json['lastLoginTime'])
          : null,
      totalLoginFailures: json['totalLoginFailures'],
      orgId: json['orgId'],
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      authorities: (json['authorities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }
}
