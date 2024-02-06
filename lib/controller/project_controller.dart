import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet/data/model/response/Task.dart';

import '../data/model/response/general_response.dart';
import '../data/repository/project_repo.dart';

class ProjectController extends GetxController implements GetxService {
  final ProjectRepo repo;
  final SharedPreferences sharedPreferences;

  ProjectController({required this.repo, required this.sharedPreferences});

  bool _loading = false;
  int _pageIndex = 1;
  int _pageSize = 10;
  int _maxPages = -1;
  List<Project> _projectList = [];

  bool get loading => _loading;

  int get pageIndex => _pageIndex;
  List<Project> get projectList => _projectList;
  set pageIndex(int newIndex) {
    _pageIndex = newIndex;
    getProjectList();
  }

  int get pageSize => _pageSize;
  set pageSize(int newSize) {
    _pageSize = newSize;
    _pageIndex = 1;
    getProjectList();
  }

  int get maxPages => _maxPages;

  void init() {
    repo.init();
    getProjectList();
  }

  Future<int> getProjectList() async {
    _loading = true;
    update();

    try {
      Response response = await repo.getProjectList(_pageIndex, _pageSize);

      if (response.statusCode == 200) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body);
        _projectList = apiResponse.data.content as List<Project>;
        _maxPages = apiResponse.data.totalPages;
      } else {
        if (kDebugMode) {
          print(
              'GET PROJECT LIST FAILED: ${response.statusCode}\n${response.body}');
        }
      }

      _loading = false;
      update();
      return response.statusCode ?? 404;
    } catch (e) {
      if (kDebugMode) print('GET PROJECT LIST ERROR: $e');
      _loading = false;
      update();
      return -1;
    }
  }

  Future<void> addNewProject(String name, String code, String status, String desc) async {
    _loading = true;
    update();

    Response response = await repo.addNewProject(name, code, status, desc);
    if (response.statusCode == 200) {
      getProjectList();
    } else {
      if (kDebugMode) {
        print('ADD PROJECT LIST FAILED WITH CODE: ${response.statusCode}');
        print('BODY: ${response.statusCode}');
      }

      _loading = false;
      update();
    }
  }

  Future<void> updateProject(
      String id, String code, String name, String desc, String status) async {
    _loading = true;
    update();

    Response response = await repo.updateProject(id, code, name, desc, status);
    if (response.statusCode == 200) {
      getProjectList();
    } else {
      if (kDebugMode) {
        print('UPDATE PROJECT FAILED WITH CODE: ${response.statusCode}');
        print('BODY: ${response.statusCode}');
      }

      _loading = false;
      update();
    }
  }

  Future<void> deleteProject(String id) async {
    _loading = true;
    update();

    try {
      Response response = await repo.deleteProject(id);
      if(response.statusCode == 200){
        getProjectList();
      } else {
        if (kDebugMode) {
          print('DELETE PROJECT FAILED WITH CODE: ${response.statusCode}');
          print('BODY: ${response.statusCode}');
        }

        _loading = false;
        update();
    }
    } catch (e) {
      if (kDebugMode) print('DELETE PROJECT LIST ERROR: $e');
      _loading = false;
      update();
    }
  }
}
