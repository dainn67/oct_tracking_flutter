import 'package:timesheet/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/app_constants.dart';

class PersonnelRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PersonnelRepo({required this.apiClient, required this.sharedPreferences});

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

  Future<Response> getTeamList (int pageIndex, int pageSize) async {
    Map<String, String> queries = {
      'pageIndex': pageIndex.toString(),
      'pageSize': pageSize.toString()
    };

    return await apiClient.getData(
        AppConstants.TEAM,
        query: queries,
        headers: header);
  }

  Future<Response> getMemberList (String? teamId, int pageIndex, int pageSize) async {
    Map<String, String?> queries = {
      'teamId': teamId,
      'pageIndex': pageIndex.toString(),
      'pageSize': pageSize.toString()
    };

    return await apiClient.getData(
        AppConstants.MEMBER,
      query: queries,
      headers: header
    );
  }
}