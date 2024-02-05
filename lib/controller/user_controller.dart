import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet/data/model/body/user.dart';

import '../data/repository/project_repo.dart';

class UserController extends GetxController implements GetxService {
  final ProjectRepo repo;
  final SharedPreferences sharedPreferences;

  UserController({required this.repo, required this.sharedPreferences});

  bool _loading = false;
  int _pageIndex = 1;
  int _pageSize = 10;
  int _maxPages = -1;
  List<User> _userList = [];
}