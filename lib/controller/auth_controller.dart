import 'package:get/get.dart';
import 'package:timesheet/data/model/body/user.dart';
import 'package:timesheet/data/model/response/token_resposive.dart';
import 'package:timesheet/data/repository/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/route_helper.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo repo;
  final SharedPreferences sharedPreferences;

  AuthController({required this.repo, required this.sharedPreferences});

  bool _loading = false;
  User _user = User();

  bool get loading => _loading;

  User get user => _user;

  Future<int> login(String username, String password) async {
    _loading = true;
    update();
    Response response = await repo.login(username: username, password: password);
    if (response.statusCode == 200) {
      TokenResponsive tokeBody = TokenResponsive.fromJson(response.body);
      repo.saveUserToken(tokeBody.accessToken!);
    } else if (response.statusCode == 401){
      clearData();
      Get.offAllNamed(RouteHelper.getSignInRoute());
    }
    _loading = false;
    update();
    return response.statusCode!;
  }

  Future<int> logOut() async {
    _loading = true;
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

  Future<int> getCurrentUser() async {
    Response response = await repo.getCurrentUser();
    if (response.statusCode == 200) {
      _user = User.fromJson(response.body);
      update();
    } else {
      clearData();
      Get.offAllNamed(RouteHelper.getSignInRoute());
    }
    return response.statusCode!;
  }

  void clearData() {
    _loading = false;
    _user = User();
  }
}
