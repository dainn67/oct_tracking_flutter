import 'package:timesheet/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}