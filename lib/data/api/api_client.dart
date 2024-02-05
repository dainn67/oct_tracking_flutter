import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';
import '../model/error_response.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 90;

  String token = "";
  Map<String, String> _mainHeaders = {};

  //Constructor
  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.TOKEN) ??
        "Basic Y29yZV9jbGllbnQ6c2VjcmV0";
    if (Foundation.kDebugMode) print('Token: $token');

    updateHeader(
      token,
      null,
      sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      0,
    );
  }

  void updateHeader(
      String token, List<int>? zoneIDs, String? languageCode, int moduleID) {
    Map<String, String> _header = {
      'Content-Type': 'application/json; charset=utf-8',
      AppConstants.LOCALIZATION_KEY:
          languageCode ?? AppConstants.languages[0].languageCode,
      'Authorization': token
    };
    _header.addAll({AppConstants.MODULE_ID: moduleID.toString()});
    _mainHeaders = _header;
  }

  Future<Response> getData(
      String uri,
      {
        Map<String, dynamic>? query,
        Map<String, String>? headers,
        String? accessToken
      }) async {
    try {
      if (Foundation.kDebugMode) {
        if(kDebugMode) {
          print('====> API Call: ${appBaseUrl + uri}');
          print('Header: ${headers ?? _mainHeaders}');
          if(query != null) {
            print('Query: $query');
            print('>> New uri: ${Uri.parse(appBaseUrl + uri).replace(queryParameters: query)}');
          }
        }
      }
      Http.Response response = await Http.get(
        Uri.parse(appBaseUrl + uri).replace(queryParameters: query),
        headers: headers ?? _mainHeaders,

      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      if(kDebugMode) print('------------ERROR: $e');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(
      String uri, dynamic body, Map<String, String>? headers) async {
    try {
      String requestBody = jsonEncode(body);
      if (Foundation.kDebugMode) {
        print('====> API Call: ${appBaseUrl + uri}');
        print('====> Header: $headers');
        print('====> API Body: $requestBody');
      }
      Http.Response _response = await Http.post(
        Uri.parse(appBaseUrl + uri),
        body: requestBody,
        headers: headers,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postDataLogin(
      String uri, dynamic body, Map<String, String>? headers) async {
    try {
      if (Foundation.kDebugMode) {
        print(
            '====> API Call: ${appBaseUrl + uri}\nHeader: ${headers ?? _mainHeaders}');
        print('====> API Body: $body');
      }
      Http.Response response = await Http.post(
        Uri.parse(appBaseUrl + uri),
        body: body,
        headers: headers,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postCheckDataLogin(
      String path, String token, Map<String, String>? headers) async {
    try {
      Uri uriWithTokenParam = Uri.parse(appBaseUrl + path)
          .replace(queryParameters: {'token': token});
      if (kDebugMode)
        print(
            '====> API Call: $uriWithTokenParam\nHeader: ${headers ?? _mainHeaders}');

      Http.Response response = await Http.post(
        uriWithTokenParam,
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, path);
    } catch (e) {
      if (kDebugMode) print('### Check login error: $e');
      return Response(statusCode: 404, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(
      String uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {required Map<String, String>? headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body with ${multipartBody.length} picture');
      }
      Http.MultipartRequest _request =
          Http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      _request.headers.addAll(headers ?? _mainHeaders);
      for (MultipartBody multipart in multipartBody) {
        if (multipart.file != null) {
          Uint8List _list = await multipart.file.readAsBytes();
          _request.files.add(Http.MultipartFile(
            multipart.key,
            multipart.file.readAsBytes().asStream(),
            _list.length,
            filename: '${DateTime.now().toString()}.png',
          ));
        }
      }
      _request.fields.addAll(body);
      Http.Response _response =
          await Http.Response.fromStream(await _request.send());
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: ${appBaseUrl + uri}\nHeader: ${headers ?? _mainHeaders}');
        print('HII');
        print('====> API Body: ${jsonEncode(body)}');
        print('HIII');
      }

      Http.Response response = await Http.put(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      print('PUT DATA ERROR: $e');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri,
      {Map<String, String>? headers}) async {
    try {
      if (Foundation.kDebugMode) {
        if(kDebugMode) print('====> API Call: ${appBaseUrl + uri}\nHeader: $_mainHeaders');
      }
      Http.Response response = await Http.delete(
        Uri.parse(appBaseUrl + uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response receivedResponse, String uri) {
    dynamic body;
    try {
      body = jsonDecode(receivedResponse.body);
    } catch (e) {}

    Response response = Response(
      body: body ?? receivedResponse.body,
      bodyString: receivedResponse.body.toString(),
      request: Request(
          headers: receivedResponse.request!.headers,
          method: receivedResponse.request!.method,
          url: receivedResponse.request!.url),
      headers: receivedResponse.headers,
      statusCode: receivedResponse.statusCode,
      statusText: receivedResponse.reasonPhrase,
    );

    if (response.statusCode != 200 &&
        response.body != null &&
        response.body is! String) {
      if (response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
        response = Response(
            statusCode: response.statusCode,
            body: response.body,
            statusText: errorResponse.errors![0].message);
      } else if (response.body.toString().startsWith('{message')) {
        response = Response(
            statusCode: response.statusCode,
            body: response.body,
            statusText: response.body['message']);
      }
    } else if (response.statusCode != 200 && response.body == null) {
      response = Response(statusCode: 0, statusText: noInternetMessage);
    }

    if (kDebugMode) print('<==== API Response: [${response.statusCode}] $uri \n ${response.body}');

    return response;
  }
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}
