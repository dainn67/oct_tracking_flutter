import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet/data/model/response/user.dart';

import '../data/model/response/general_response.dart';
import '../data/repository/user_repo.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo repo;
  final SharedPreferences sharedPreferences;

  UserController({required this.repo, required this.sharedPreferences});

  bool _loading = false;
  int _pageIndex = 1;
  int _pageSize = 10;
  int _maxPages = -1;
  List<User> _userList = [];

  bool get loading => _loading;
  List<User> get userList => _userList;

  int get pageIndex => _pageIndex;
  List<User> get projectList => _userList;
  set pageIndex(int newIndex) {
    _pageIndex = newIndex;
    getUserList();
  }

  int get pageSize => _pageSize;
  set pageSize(int newSize) {
    _pageSize = newSize;
    _pageIndex = 1;
    getUserList();
  }

  int get maxPages => _maxPages;

  void init() {
    repo.init();
    getUserList();
  }

  Future<int> getUserList() async {
    _loading = true;
    update();

    try {
      Response response = await repo.getUserList(_pageIndex, _pageSize);

      if (response.statusCode == 200) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body);
        _userList = apiResponse.data.content as List<User>;
        _maxPages = apiResponse.data.totalPages;
      } else {
        if (kDebugMode) {
          print('GET USER LIST FAILED: ${response.statusCode}\n${response.body}');
        }
      }

      _loading = false;
      update();
      return response.statusCode ?? 404;
    } catch (e) {
      if (kDebugMode) print('GET USER LIST ERROR: $e');
      _loading = false;
      update();
      return -1;
    }
  }

  Future<void> addUser(String name, String email, String password, String gender, List<bool> roles) async {
    _loading = true;
    update();

    try {
      List<String> roleBody = [];
      if(roles[0]) roleBody.add('ROLE_ADMIN');
      if(roles[1]) roleBody.add('ROLE_ACCOUNTANT');
      if(roles[2]) roleBody.add('ROLE_MANAGER');
      if(roles[3]) roleBody.add('ROLE_STAFF');

      Response response = await repo.addUser(name, email, password, gender, roleBody);
      if(response.statusCode == 200){
        getUserList();
      } else {
        if (kDebugMode) {
          print('ADD USER FAILED WITH CODE: ${response.statusCode}');
          print('BODY: ${response.statusCode}');
        }

        _loading = false;
        update();
      }
    } catch (e) {
      if (kDebugMode) print('ADD USER ERROR: $e');
      _loading = false;
      update();
    }
  }

  Future<void> deleteUser(int id) async {
    _loading = true;
    update();

    try {
      Response response = await repo.deleteUser(id);
      if(response.statusCode == 200){
        getUserList();
      } else {
        if (kDebugMode) {
          print('DELETE USER FAILED WITH CODE: ${response.statusCode}');
          print('BODY: ${response.statusCode}');
        }

        _loading = false;
        update();
      }
    } catch (e) {
      if (kDebugMode) print('DELETE USER ERROR: $e');
      _loading = false;
      update();
    }
  }
}