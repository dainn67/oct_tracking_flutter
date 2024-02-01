import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet/data/model/response/general_response.dart';
import 'package:timesheet/data/model/response/work_day.dart';

import '../data/repository/tracking_repo.dart';

class TrackingController extends GetxController implements GetxService {
  final TrackingRepo repo;
  final SharedPreferences sharedPreferences;

  TrackingController({required this.repo, required this.sharedPreferences});

  bool _loading = false;
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  String _selectedTeam = 'Team 1';
  String _selectedMember = 'Member 1';
  int _pageIndex = 1;
  int _pageSize = 10;
  List<WorkingDay> _workingDayList = [];

  bool get loading => _loading;

  DateTime get fromDate => _fromDate;
  set fromDate(DateTime newFromDate) {
    _fromDate = newFromDate;
  }

  DateTime get toDate => _toDate;
  set toDate(DateTime newToDate){
    _toDate = newToDate;
  }

  String get selectedTeam => _selectedTeam;
  set selectedTeam(String newTeam){
    _selectedTeam = newTeam;
  }

  String get selectedMember => _selectedMember;
  set selectedMember(String newMember){
    _selectedMember = newMember;
  }

  int get pageIndex => _pageIndex;
  set pageIndex(int newIndex){
    _pageIndex = newIndex;
  }

  int get pageSize => _pageSize;
  set pageSize(int newSize){
    _pageSize = newSize;
  }

  List<WorkingDay> get workingDayList => _workingDayList;

  Future<int> getWorkingDayList() async {
    _loading = true;
    update();

    if (kDebugMode) print('GETTING WORKING DAY LIST');

    Response response = await repo.getWorkingDayList();
    if (response.statusCode == 200) {
      _workingDayList = ApiResponse.fromJson(response.body).data.content;
      if (kDebugMode) print('SUCCESS: $workingDayList');
    } else {
      if (kDebugMode) print('ERROR: ${response.statusCode}\n${response.body}');
    }

    _loading = false;
    update();
    return response.statusCode ?? 404;
  }
}
