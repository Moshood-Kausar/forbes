import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:forbes/forbes.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  final String _nointernet = "No internet connection";
  final String _timeMsg = "Request timeout, connect to a better network";
  final String msg = "An error occured: ";
  static const String apiKey = "7c760c888117450f9ac628d1e86a7517";
  String newsUrl =
      "https://newsapi.org/v2/everything?q=tesla&from=2021-10-03&sortBy=publishedAt&apiKey=7c760c888117450f9ac628d1e86a7517=$apiKey";
  Future<Forbes> newsApi() async {
    try {
      final response = await http.get(Uri.parse(newsUrl));
      if (response.statusCode == 200) {
        var convert = json.decode(response.body);
        if (convert.toString().isNotEmpty && response.statusCode == 200) {
          Forbes forbes = Forbes.fromJson(convert);
          return forbes;
        }
        return Forbes.fromJson(jsonDecode(response.body));
      } else {
        return Forbes(msg: response.reasonPhrase, status: "Failed");
      }
    } on SocketException catch (_) {
      return Forbes(msg: _nointernet, status: "Failed");
    } on TimeoutException catch (_) {
      return Forbes(msg: _timeMsg, status: "Failed");
    

      }
      // final response1 = await http.post(
      //   Uri.parse(newsUrl),
      //   body: {
      //     'email': "kausar",
      // 'pword': 'fsfhj',
      // });
     catch (e) {
      return Forbes(status: "Failed", msg: msg + '$e');
    }
  }
}
