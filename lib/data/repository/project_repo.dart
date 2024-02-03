import 'package:timesheet/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/app_constants.dart';

class ProjectRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ProjectRepo({required this.apiClient, required this.sharedPreferences});

  Map<String, String> header = {};
  String authorization = '';
  String? languageCode = '';
  String? accessToken = '';

  void init() {
    authorization = "Basic Y29yZV9jbGllbnQ6c2VjcmV0";
    languageCode = sharedPreferences.getString(AppConstants.LANGUAGE_CODE);
    accessToken = sharedPreferences.getString(AppConstants.TOKEN);
    header = {
      'Content-Type': 'application/x-www-form-urlencoded',
      AppConstants.LOCALIZATION_KEY: languageCode ?? AppConstants.languages[0].languageCode,
      'Authorization': accessToken != null ? 'Bearer $accessToken' : authorization
    };
  }

  Future<Response> getProjectList(int pageIndex, int pageSize) async {
    Map<String, String> queries = {
      'pageIndex': pageIndex.toString(),
      'pageSize': pageSize.toString()
    };

    return await apiClient.getData(
        AppConstants.PROJECT,
        query: queries,
        headers: header
    );
  }
}