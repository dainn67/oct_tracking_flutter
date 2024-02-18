import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet/data/model/response/general_response.dart';
import 'package:timesheet/data/model/response/work_day.dart';

import '../data/model/response/member.dart';
import '../data/model/response/team.dart';
import '../data/repository/tracking_repo.dart';

class TrackingController extends GetxController implements GetxService {
  final TrackingRepo repo;
  final SharedPreferences sharedPreferences;

  TrackingController({required this.repo, required this.sharedPreferences});

  bool _loading = false;
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();

  String _selectedTeam = '';
  String? _selectedTeamId;

  String _selectedMember = '';
  String? _selectedMemberId;

  int _pageIndex = 1;
  int _pageSize = 10;
  int _maxPages = -1;

  final List<String> _teamNameList = [''];
  List<Team> _teamList = [];

  final List<String> _memberNameList = [''];
  List<Member> _memberList = [];

  List<WorkingDay> _workingDayList = [];

  bool get loading => _loading;

  DateTime get fromDate => _fromDate;

  set fromDate(DateTime newFromDate) {
    _fromDate = newFromDate;
    getWorkingDayList();
  }

  DateTime get toDate => _toDate;

  set toDate(DateTime newToDate) {
    _toDate = newToDate;
    getWorkingDayList();
  }

  String get selectedTeam => _selectedTeam;
  set selectedTeam(String newTeamName) {
    _selectedTeam = newTeamName;
    if(newTeamName == 'None') {
      _selectedTeamId = null;
      _selectedMemberId = null;
    } else {
      _selectedTeamId = _teamList.firstWhere((element) => element.name == newTeamName).id;
    }
    getMemberNameList();
    getWorkingDayList();
  }

  String get selectedMember => _selectedMember;
  set selectedMember(String newMemberName) {
    _selectedMember = newMemberName;
    if(newMemberName == 'None') {
      _selectedMemberId = null;
    } else {
      _selectedMemberId = _memberList.firstWhere((element) => element.name == newMemberName).id;
    }
    getWorkingDayList();
  }

  int get pageIndex => _pageIndex;

  set pageIndex(int newIndex) {
    _pageIndex = newIndex;
    getWorkingDayList();
  }

  int get pageSize => _pageSize;

  set pageSize(int newSize) {
    _pageSize = newSize;
    _pageIndex = 1;
    getWorkingDayList();
  }

  int get maxPages => _maxPages;

  List<String> get teamNameList => _teamNameList;

  List<String> get memberNameList => _memberNameList;

  List<WorkingDay> get workingDayList => _workingDayList;

  void init() {
    _fromDate = DateTime(_fromDate.year, _fromDate.month, 1);

    repo.init();
    getWorkingDayList();
    getTeamNameList();
    getMemberNameList();
  }

  Future<int> getWorkingDayList() async {
    _loading = true;
    update();

    print('HERE: $_selectedTeamId - $_selectedMemberId');
    try {
      Response response = await repo.getWorkingDayList(
          _fromDate, _toDate, _pageIndex, _pageSize, teamId: _selectedTeamId, memberId: _selectedMemberId);
      if (response.statusCode == 200) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body);
        _workingDayList = apiResponse.data.content as List<WorkingDay>;
        _maxPages = apiResponse.data.totalPages;
      } else {
        if (kDebugMode) {
          print(
              'GET WORKING DAY LIST FAILED: ${response.statusCode}\n${response.body}');
        }
      }

      _loading = false;
      update();
      return response.statusCode ?? 404;
    } catch (e) {
      if (kDebugMode) print('GET WORKING DAY LIST ERROR: $e');
      _loading = false;
      update();
      return 404;
    }
  }

  Future<int> getTeamNameList() async {
    _loading = true;
    update();

    Response response = await repo.getTeams(1, 1000);
    if (response.statusCode == 200) {
      ApiResponse apiResponse = ApiResponse.fromJson(response.body);
      _teamList = apiResponse.data.content as List<Team>;

      _teamNameList.clear();
      _teamNameList.add('None');
      _teamNameList.addAll(_teamList.map((team) => team.name).toList());

      _selectedTeam = _teamNameList[0];

      _loading = false;
      update();
      return apiResponse.code;
    } else if (kDebugMode) print('TEAM NAME FAIL: $response');

    _loading = false;
    update();
    return -1;
  }

  Future<int> getMemberNameList() async {
    _loading = true;
    update();

    Response response = await repo.getMembers(1, 1000, _selectedTeamId);
    if (response.statusCode == 200) {
      ApiResponse apiResponse = ApiResponse.fromJson(response.body);
      _memberList = apiResponse.data.content as List<Member>;

      _memberNameList.clear();
      _memberNameList.add('None');
      _memberNameList.addAll(_memberList.map((member) => member.name).toList());

      _selectedMember = _memberNameList[0];

      _loading = false;
      update();
      return apiResponse.code;
    } else {
      if (kDebugMode) {
        print('MEMBER NAME FAIL: $response');
      }
    }

    _loading = false;
    update();
    return -1;
  }
}
