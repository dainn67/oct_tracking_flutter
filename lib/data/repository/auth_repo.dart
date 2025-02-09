import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet/data/model/body/token_request.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Map<String, String> header = {};
  String authorization = '';
  String? languageCode = '';

  void init() {
    authorization = "Basic Y29yZV9jbGllbnQ6c2VjcmV0";
    languageCode = sharedPreferences.getString(AppConstants.LANGUAGE_CODE);
    header = {
      'Content-Type': 'application/x-www-form-urlencoded',
      AppConstants.LOCALIZATION_KEY:
          languageCode ?? AppConstants.languages[0].languageCode,
      'Authorization': authorization
    };
  }

  Future<Response> login({required String username, required String password}) async {
    return await apiClient.postDataLogin(
        AppConstants.LOGIN_URI,
        TokenRequest(
                username: username,
                password: password,
                clientId: "core_client",
                clientSecret: "secret",
                grantType: "password")
            .toJson(),
        header);
  }

  Future<Response> logOut() async {
    return await apiClient.deleteData(AppConstants.LOG_OUT);
  }

  Future<Response> getCurrentUser() async {
    return await apiClient.getData(AppConstants.GET_USER);
  }

  Future<Response> checkToken() async {
    var token = sharedPreferences.getString(AppConstants.TOKEN) ?? '@';

    if(kDebugMode) print('TOKEN FROM SHARED: $token');
    return await apiClient.postCheckDataLogin(
        AppConstants.CHECK_TOKEN, token, header);
  }

  // for user token
  Future<bool> saveUserToken(String token) async {
    apiClient.token = "Bearer $token";
    apiClient.updateHeader("Bearer $token", null,
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi", 0);

    if(kDebugMode) print('SAVING THIS TOKEN: $token');
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<bool> clearUserToken() async {
    return await sharedPreferences.remove(AppConstants.TOKEN);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  bool clearSharedAddress() {
    sharedPreferences.remove(AppConstants.USER_ADDRESS);
    return true;
  }

  // for  Remember Email
  Future<void> saveUserNumberAndPassword(
      String number, String password, String countryCode) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_NUMBER, number);
      await sharedPreferences.setString(
          AppConstants.USER_COUNTRY_CODE, countryCode);
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserNumber(String number, String countryCode) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_NUMBER, number);
      await sharedPreferences.setString(
          AppConstants.USER_COUNTRY_CODE, countryCode);
    } catch (e) {
      throw e;
    }
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.USER_NUMBER) ?? "";
  }

  String getUserCountryCode() {
    return sharedPreferences.getString(AppConstants.USER_COUNTRY_CODE) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  bool isNotificationActive() {
    return sharedPreferences.getBool(AppConstants.NOTIFICATION) ?? true;
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    await sharedPreferences.remove(AppConstants.USER_COUNTRY_CODE);
    return await sharedPreferences.remove(AppConstants.USER_NUMBER);
  }
}
