import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:task_management_app/data/api_services/network_response.dart';

class NetworkClient {
  static final Logger _logger = Logger();

  // From here Start get request
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      _preRequestLog(url);
      Response response = await get(uri);
      _pastRequestLog(url, response.statusCode,
          headers: response.headers, responseBody: response.body);

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            data: decodedJson);
      } else {
        final decodedJson = jsonDecode(response.body);
        String errorMessage = decodedJson['data'] ?? 'Something wrong';
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: errorMessage);
      }
    } catch (catchError) {
      _pastRequestLog(url, -1);
      return NetworkResponse(
          isSuccess: false,
          statusCode: -1,
          errorMessage: catchError.toString());
    }
  }
  // From here End get request

  // From here Start post request
  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      _preRequestLog(url, body: body);
      Response response = await post(uri,
          headers: {'Content-type': 'Application/json'},
          body: jsonEncode(body));
      _pastRequestLog(url, response.statusCode,
          headers: response.headers, responseBody: response.body);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            data: decodedJson);
      } else {
        final decodedJson = jsonDecode(response.body);
        String errorMessage = decodedJson['data'] ?? 'Something wrong';
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: errorMessage);
      }
    } catch (catchError) {
      _pastRequestLog(url, -1, errorMessage: catchError.toString());
      return NetworkResponse(
          isSuccess: false,
          statusCode: -1,
          errorMessage: catchError.toString());
    }
  }
  // From here End post request

  static _preRequestLog(String url, {Map<String, dynamic>? body}) {
    _logger.i("Url => $url\n"
        "Body => $body\n"); //
  }

  static _pastRequestLog(String url, int statusCode,
      {Map<String, dynamic>? headers,
      dynamic responseBody,
      dynamic errorMessage}) {
    if (errorMessage != null) {
      _logger.e("Url => $url\n"
          "Headers => $headers\n"
          "Error Message => $errorMessage\n");
    } else {
      _logger.i("Url => $url\n"
          "Headers => $headers\n"
          "ResponseBody => $responseBody\n");
    }
  }
}
