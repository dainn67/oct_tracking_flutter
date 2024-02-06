import 'package:timesheet/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:timesheet/data/model/body/team_body.dart';
import 'package:timesheet/data/model/response/team.dart';

import '../../utils/app_constants.dart';
import '../model/body/member_body.dart';

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

  Future<Response> getTeamList(int pageIndex, int pageSize) async {
    Map<String, String> queries = {
      'pageIndex': pageIndex.toString(),
      'pageSize': pageSize.toString()
    };

    return await apiClient.getData(AppConstants.TEAM,
        query: queries, headers: header);
  }

  Future<Response> getMemberList(
      String? teamId, int pageIndex, int pageSize) async {
    Map<String, String?> queries = {
      'teamId': teamId,
      'pageIndex': pageIndex.toString(),
      'pageSize': pageSize.toString()
    };

    return await apiClient.getData(AppConstants.MEMBER,
        query: queries, headers: header);
  }

  Future<Response> updateTeam(
      String id, String code, String name, String desc) async {
    return await apiClient.putData(
        '${AppConstants.TEAM.replaceAll('/page', '')}/$id',
        TeamBody(name: name, code: code, description: desc),
        headers: header);
  }

  Future<Response> updateMember(
      String id,
      String code,
      String dateJoin,
      String email,
      String gender,
      String level,
      String name,
      String position,
      String status,
      Team team,
      String type) async {
    return await apiClient.putData(
        '${AppConstants.MEMBER.replaceAll('/page', '')}/$id',
        MemberBody(
            name: name,
            code: code,
            dateJoin: dateJoin,
            status: status,
            team: team,
            email: email,
            level: level,
            gender: gender,
            type: type,
            position: position),
        headers: header);
  }
}
