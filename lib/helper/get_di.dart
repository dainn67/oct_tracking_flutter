import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet/controller/auth_controller.dart';
import 'package:timesheet/controller/personnel_controller.dart';
import 'package:timesheet/controller/tracking_controller.dart';
import 'package:timesheet/data/repository/project_repo.dart';
import 'package:timesheet/data/repository/splash_repo.dart';
import 'package:timesheet/data/repository/tracking_repo.dart';
import '../controller/localization_controller.dart';
import '../controller/project_controller.dart';
import '../controller/splash_controller.dart';
import '../controller/user_controller.dart';
import '../data/api/api_client.dart';
import '../data/model/language_model.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/language_repo.dart';
import '../data/repository/personnel_repo.dart';
import '../data/repository/user_repo.dart';
import '../theme/theme_controller.dart';
import '../utils/app_constants.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  final firstCamera = await availableCameras();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => firstCamera);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashRepo(apiClient: Get.find()));
  Get.lazyPut(() => TrackingRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ProjectRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => PersonnelRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(repo: Get.find()));
  Get.lazyPut(() => TrackingController(repo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ProjectController(repo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthController(repo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => PersonnelController(repo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserController(repo: Get.find(), sharedPreferences: Get.find()));

  if (await Permission.location.isGranted) {
    final newLocalData = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    Get.lazyPut(() => newLocalData);
  }

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};

  for (LanguageModel languageModel in AppConstants.languages) {

    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');

    if(kDebugMode) print('JSONSTRINGVALUE: $jsonStringValues');

    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};

    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });

    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;

    print('SETTING language[${languageModel.languageCode}_${languageModel.countryCode}]');
  }

  print('INIT DI: $languages');
  return languages;
}
