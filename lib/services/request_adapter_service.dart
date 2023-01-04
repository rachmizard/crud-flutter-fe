import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RequestAdapterService {
  final http.Client _httpClient = http.Client();

  String baseURL = 'localhost:4000';

  interceptToken() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final token = sharedPrefs.getString('token');

    return token ?? '';
  }

  Future<http.Response> sendGetRequest(String url,
      {Map<String, dynamic>? params}) async {
    final token = await interceptToken();

    final response = await _httpClient
        .get(Uri.http(baseURL, url, params), headers: {'Authorization': token});

    return response;
  }

  Future<http.Response> sendPostRequest(String url,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    final token = await interceptToken();

    final response = await _httpClient.post(Uri.http(baseURL, url),
        body: body, headers: {'Authorization': token});

    return response;
  }

  Future<http.Response> sendPutRequest(String url, {Map? body}) async {
    final token = await interceptToken();

    final response = await _httpClient.put(Uri.http(baseURL, url),
        body: body, headers: {'Authorization': token});

    return response;
  }

  Future<http.Response> sendDeleteRequest(String url,
      {Map<String, dynamic>? params}) async {
    final token = await interceptToken();
    final response =
        await _httpClient.delete(Uri.http(baseURL, url, params), headers: {
      HttpHeaders.authorizationHeader: token,
    });

    return response;
  }
}
