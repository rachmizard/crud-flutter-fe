import 'package:http/http.dart' as http;

class RequestAdapterService {
  final http.Client _httpClient = http.Client();

  String baseURL = 'localhost:4000';

  Future<http.Response> sendGetRequest(
      String url, Map<String, dynamic>? params) async {
    final response = await _httpClient.get(Uri.http(baseURL, url, params));
    return response;
  }

  Future<http.Response> sendPostRequest(String url,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    final response = await _httpClient.post(Uri.http(baseURL, url),
        body: body, headers: headers);

    return response;
  }

  Future<http.Response> sendPutRequest(
      String url, Map<String, dynamic>? body) async {
    final response = await _httpClient.put(Uri.http(baseURL, url), body: body);
    return response;
  }

  Future<http.Response> sendDeleteRequest(
      String url, Map<String, dynamic>? params) async {
    final response = await _httpClient.delete(Uri.http(baseURL, url, params));
    return response;
  }
}
