import 'dart:async';
import 'dart:convert';

import 'package:boggle_flutter/constants/constants.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> httpPost({
  required String uri,
  required Map<String, dynamic> body,
}) async {
  final encodedBody = json.encode(body);

  final response = await http.post(
    Uri.parse(uri),
    headers: sendHeaders,
    body: encodedBody,
  );

  final responseBody = json.decode(response.body) as Map<String, dynamic>;

  return responseBody;
}
