import 'package:timesheet/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:timesheet/data/model/body/user.dart';

import '../../utils/app_constants.dart';

class UserRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  UserRepo({required this.apiClient, required this.sharedPreferences});

  Map<String, String> header = {};
  String authorization = '';
  String? languageCode = '';
  String? accessToken = '';

  void init() {
    authorization = "Basic Y29yZV9jbGllbnQ6c2VjcmV0";
    languageCode = sharedPreferences.getString(AppConstants.LANGUAGE_CODE);
    accessToken = sharedPreferences.getString(AppConstants.TOKEN);
    header = {
      'Content-Type': 'application/json; charset=utf-8',
      AppConstants.LOCALIZATION_KEY:
      languageCode ?? AppConstants.languages[0].languageCode,
      'Authorization':
      accessToken != null ? 'Bearer $accessToken' : authorization
    };
  }

  Future<Response> getUserList(int pageIndex, int pageSize) async {
    Map<String, String> queries = {
      'pageIndex': pageIndex.toString(),
      'pageSize': pageSize.toString()
    };

    return await apiClient.getData(AppConstants.USER,
        query: queries, headers: header);
  }

  Future<Response> addUser(String name, String email, String password,
      String gender, List<String> roles) async {
    int genderNum = 0;
    switch (gender) {
      case 'MALE':
        genderNum = 1;
      case 'FEMALE':
        genderNum = 2;
      case 'LGBT':
        genderNum = 3;
      default:
        genderNum = 4;
    }
    return await apiClient.postData(
        AppConstants.USER.replaceAll('/page', ''),
        UserBody(username: name,
            displayName: '',
            email: email,
            gender: genderNum,
            roles: roles,
            password: password,
            active: true,
            justCreated: true,
            accountNonLocked: true,
            accountNonExpired: true,
            credentialsNonExpired: true,
            confirmPassword: password),
        header);
  }

  Future<Response> deleteUser(int id) async {
    return await apiClient.deleteData(
        '${AppConstants.USER.replaceAll('/page', '')}/$id',
        headers: header);
  }
}
