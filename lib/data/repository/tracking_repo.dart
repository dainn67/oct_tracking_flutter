import 'package:timesheet/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/app_constants.dart';

class TrackingRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  TrackingRepo({required this.apiClient, required this.sharedPreferences});
  
  bool loading = false;
  
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
  
  Future<Response> getWorkingDayList(DateTime fromDate, DateTime toDate, int pageIndex, int pageSize, {String? teamId, String? memberId}) async {
    Map<String, String?> queries = {
      'startDate': '${fromDate.year}-${fromDate.month < 10 ? '0${fromDate.month}' : fromDate.month}-${fromDate.day < 10 ? '0${fromDate.day}' : fromDate.day}',
      'endDate': '${toDate.year}-${toDate.month < 10 ? '0${toDate.month}' : toDate.month}-${toDate.day < 10 ? '0${toDate.day}' : toDate.day}',
      'teamId': teamId,
      'memberId': memberId,
      'pageIndex': pageIndex.toString(),
      'pageSize': pageSize.toString()
    };
    queries.removeWhere((key, value) => value == null);

    return await apiClient.getData(
      AppConstants.TRACKING,
      query: queries,
      headers: header
    );
  }

  Future<Response> getTeams(int pageIndex, int pageSize) async {
    Map<String, String> queries = {
      'pageIndex': pageIndex.toString(),
      'pageSize': pageSize.toString()
    };

    return await apiClient.getData(
      AppConstants.TEAM,
      query: queries,
      headers: header
    );
  }

  Future<Response> getMembers(int pageIndex, int pageSize, String? teamId) async {
    Map<String, String?> queries = {
      'pageIndex': pageIndex.toString(),
      'pageSize': pageSize.toString(),
      'teamId': teamId
    };

    return await apiClient.getData(
      AppConstants.MEMBER,
      query: queries,
      headers: header
    );
  }
}