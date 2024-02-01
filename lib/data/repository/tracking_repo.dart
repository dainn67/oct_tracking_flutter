import 'dart:ffi';

import 'package:flutter/foundation.dart';
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

  void init(){
    authorization = "Basic Y29yZV9jbGllbnQ6c2VjcmV0";
    languageCode = sharedPreferences.getString(AppConstants.LANGUAGE_CODE);
    header = {
      'Content-Type': 'application/x-www-form-urlencoded',
      AppConstants.LOCALIZATION_KEY: languageCode ?? AppConstants.languages[0].languageCode,
      'Authorization': authorization
    };
  }
  
  Future<Response> getWorkingDayList() async {
    //temp
    Map<String, String?> queries = {
      'startDate': '2024-01-01',
      'endDate': '2024-02-28',
      'teamId': null,
      'memberId': null,
      'pageIndex': '1',
      'pageSize': '10'
    };

    queries.removeWhere((key, value) => value == null);

    if(kDebugMode) print('FILTERED QUERY: $queries');

    String accessToken = sharedPreferences.getString(AppConstants.TOKEN) ?? 'abc';
    header['Authorization'] = 'Bearer $accessToken';

    return await apiClient.getData(
      AppConstants.TRACKING,
      query: queries,
      headers: header
    );
  }
}