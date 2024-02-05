import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet/data/model/response/member.dart';
import 'package:timesheet/data/model/response/team.dart';

import '../data/model/response/general_response.dart';
import '../data/repository/personnel_repo.dart';

class PersonnelController extends GetxController implements GetxService {
  final PersonnelRepo repo;
  final SharedPreferences sharedPreferences;

  PersonnelController({required this.repo, required this.sharedPreferences});

  bool _loading = false;
  int _pageIndex = 1;
  int _pageSize = 10;
  int _maxPages = -1;
  String? _teamId;
  List<Team> _teamList = [];
  List<Member> _memberList = [];

  int _pageCategory = 0; //0 is team, 1 is member

  bool get loading => _loading;
  List<Team> get teamList => _teamList;
  List<Member> get memberList => _memberList;

  int get pageCategory => _pageCategory;
  set pageCategory(int index) {
    _pageCategory = index;
    update();
    // if(index == 0) {
    //   getTeamList();
    // } else {
    //   getMemberList();
    // }
  }

  int get pageIndex => _pageIndex;
  set pageIndex(int newIndex) {
    _pageIndex = newIndex;
    _pageCategory == 0 ? getTeamList() : getMemberList();
  }

  int get pageSize => _pageSize;
  set pageSize(int newSize) {
    _pageSize = newSize;
    _pageIndex = 1;
    _pageCategory == 0 ? getTeamList() : getMemberList();
  }

  int get maxPages => _maxPages;

  void init() {
    repo.init();
    getTeamList();
    getMemberList();
  }

  void resetTeamOptions(){
    _pageCategory = 0;
    _pageSize = 10;
    _pageIndex = 1;
    getTeamList();
  }

  void resetMemberOptions(){
    _pageCategory = 1;
    _pageSize = 10;
    _pageIndex = 1;
    _teamId = null;
    getMemberList();
  }

  Future<int> getTeamList() async {
    _loading = true;
    update();

    try {
      Response response = await repo.getTeamList(_pageIndex, _pageSize);
      if (response.statusCode == 200) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body);
        _teamList = apiResponse.data.content as List<Team>;
        _maxPages = apiResponse.data.totalPages;
        print('MAX PAGE: $_maxPages');
      } else {
        if (kDebugMode) {
          print(
              'GET TEAM LIST FAILED: ${response.statusCode}\n${response.body}');
        }
      }

      _loading = false;
      update();
      return response.statusCode ?? -1;
    } catch (e) {
      if (kDebugMode) print('GET TEAM LIST ERROR: $e');
      _loading = false;
      update();
      return -1;
    }
  }

  Future<int> getMemberList() async {
    _loading = true;
    update();

    try {
      Response response = await repo.getMemberList(_teamId, _pageIndex, _pageSize);
      if (response.statusCode == 200) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body);
        _memberList = apiResponse.data.content as List<Member>;
        _maxPages = apiResponse.data.totalPages;
        print('MAX PAGE: $_maxPages');
      } else {
        if (kDebugMode) {
          print(
              'GET MEMBER LIST FAILED: ${response.statusCode}\n${response.body}');
        }
      }

      _loading = false;
      update();
      return response.statusCode ?? -1;
    } catch (e) {
      if (kDebugMode) print('GET MEMBER LIST ERROR: $e');
      _loading = false;
      update();
      return -1;
    }
  }
}