import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api.dart';

class RemoteServices {
  static var client = http.Client();

  static void printResponse(
      Map<String, String> header, dynamic body, http.Response response) {
    print('Header: $header');
    print('Body : $body');
    print('URL: ${response.request!.url}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  static Future<http.Response> insertEvent(
      clientID, title, startDate, endDate
      ) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      //'Authorization': 'Bearer $accessToken',
    };
    String postBody = json.encode({
      "clientID": clientID,
      "title" : title.toString(),
      "startDate" : startDate.toString(),
      "endDate" : endDate.toString(),
    });
    http.Response response = await http.post(
      Uri.parse("${Apis.baseAPI}${Apis.insertAPI}"),
      headers: header,
      body: postBody,
    );
    printResponse(header, postBody, response);
    return response;
  }

  static Future<http.Response> getData() async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      //'Authorization': 'Bearer $accessToken',
      'Accept-Encoding': 'gzip, deflate, br',
    };
    String postBody = json.encode({
      "title": null,
      "startTime": null,
      "endTime": null,
    });
    http.Response response = await http.post(
      Uri.parse(Apis.insertAPI),
      headers: header,
      body: postBody,
    );
    printResponse(header, postBody, response);
    return response;
  }
}