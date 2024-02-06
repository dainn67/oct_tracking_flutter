import 'dart:convert';

import 'Task.dart';
import 'member.dart';

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

