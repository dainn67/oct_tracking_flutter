import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:timesheet/data/model/body/user.dart';
import 'package:timesheet/data/model/response/token_resposive.dart';
import 'package:timesheet/data/repository/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/response/work_day.dart';
import '../helper/route_helper.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo repo;
  final SharedPreferences sharedPreferences;

  AuthController({required this.repo, required this.sharedPreferences});

  bool _loading = false;

  bool get loading => _loading;

  Future<int> login(String username, String password) async {
    _loading = true;
    update();

    Response response = await repo.login(username: username, password: password);
    if (response.statusCode == 200) {
      TokenResponsive tokenBody = TokenResponsive.fromJson(response.body);

      if (kDebugMode) print('NEW ACCESS TOKEN: ${tokenBody.accessToken}');
      repo.saveUserToken(tokenBody.accessToken!);
    } else if (response.statusCode == 401) {
      clearData();
      Get.offAllNamed(RouteHelper.getSignInRoute());
    }

    _loading = false;
    update();

    return response.statusCode!;
  }

  Future<int> logOut() async {
    _loading = true;
    update();

    Response response = await repo.logOut();
    if (response.statusCode == 200) {
      repo.clearUserToken();
    } else {
      clearData();
      Get.offAllNamed(RouteHelper.getSignInRoute());
    }

    _loading = false;
    update();

    return response.statusCode!;
  }

  Future<int> checkToken() async {
    Response response = await repo.checkToken();
    if (response.statusCode == 200) {
      update();
    } else {}

    return response.statusCode ?? 404;
  }

  void clearData() {
    _loading = false;
    update();
  }
}
