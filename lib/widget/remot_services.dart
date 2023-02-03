import 'dart:convert';
import 'package:googleapis/calendar/v3.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

class RemoteServices {
  static var client = http.Client();
  static final scopes = [
    CalendarApi.calendarScope,
    'https://www.googleapis.com/auth/calendar',
    'https://www.googleapis.com/auth/calendar.events',
    'https://www.googleapis.com/auth/calendar.readonly',
    'https://www.googleapis.com/auth/plus.login'
  ];

  static const accessToken = "ya29.a0AVvZVsoZ1zYcRZ8fkRldByHLf-uARDs6QZ9QJH8DHnDQ-yxak3tVMbuXEmtBFxGyBwi_xdHRnzz52Tw1AOmqL0lTr_c6ls22LKzJPB8IpG94DUIyU-ytCDTHsInSO1Xc-EEKFwm7qzcacXpp6vQq6n__ZpXueAaCgYKAdUSARMSFQGbdwaIPgxExrnthZqGTJKnKB8gjg0165";
  static const eventId = "Nm9zMzBlMWg3NHM2NGJiNDZnc2owYjlrY2hqM2diOXA2NWgzY2I5bjZrbzZhYzFsNmdzamVwYjM2Y18xOTcwMDEwMVQwMDAwMDBaIG1heXVydGhlb25ldGVjaDFAbQ";


  static void printResponse(
      Map<String, String> header, dynamic body, http.Response response) {
    print('Header: $header');
    print('Body : $body');
    print('URL: ${response.request!.url}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  static Future<http.Response> insertEvent(
      clientID, ApiKey, title, startDate, endDate
      ) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    String postBody = json.encode({
      "apiKey": ApiKey,
      "clientID": clientID,
      "title" : title.toString(),
      "startDate" : startDate.toString(),
      "endDate" : endDate.toString(),
      "scope" : scopes,
      "type" :"default",
      "refresh_token":"1//04293Rn759WbkCgYIARAAGAQSNwF-L9Ir6bt-McqrmjhNGTGK658tvlasug255R0RdllSgm0Ox4aUTWEX4pvoGp_Ko3jhOluaHL8"
    });
    http.Response response = await http.post(
      Uri.parse("${Apis.baseAPI}${Apis.insertAPI}"),
      headers: header,
      body: postBody,
    );
    printResponse(header, postBody, response);
    return response;
  }

  // static Future<http.Response> getData() async {
  //   Map<String, String> header = {
  //     'Content-Type': 'application/json',
  //     //'Authorization': 'Bearer $accessToken',
  //     'Accept-Encoding': 'gzip, deflate, br',
  //   };
  //   String postBody = json.encode({
  //     "title": null,
  //     "startTime": null,
  //     "endTime": null,
  //   });
  //   http.Response response = await http.get(
  //     Uri.parse(Apis.getEvent2),
  //     headers: header,
  //   );
  //   printResponse(header, postBody, response);
  //   return response;
  // }

  static Future<http.Response> getCalData() async {
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken',
    };
    http.Response response = await http.get(
        Uri.parse("https://www.google.com/calendar/events?eid=Nm9zMzBlMWg3NHM2NGJiNDZnc2owYjlrY2hqM2diOXA2NWgzY2I5bjZrbzZhYzFsNmdzamVwYjM2Y18xOTcwMDEwMVQwMDAwMDBaIG1heXVydGhlb25ldGVjaDFAbQ"),
        //Uri.parse("${Apis.baseAPI}${Apis.insertAPI}/$eventId"),
        headers: header);
    printResponse(header, null, response);
    return response;
  }
}