import 'dart:async';
import 'dart:convert';

import 'package:boggle_flutter/constants/constants.dart';
import 'package:http/http.dart' as http;

class Http {
  static Future<http.Response> post({
    required String uri,
    required Map<String, dynamic> body,
  }) async {
    final encodedBody = json.encode(body);
    final response = await http.post(
      Uri.parse(uri),
      headers: sendHeaders,
      body: encodedBody,
    );

    return response;
  }

  static Map<String, dynamic> jsonDecode(String data) {
    return json.decode(data) as Map<String, dynamic>;
  }
}
