import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vendas/utils/error_handler.dart';

enum RequestType { get, post, put, delete }

class NetworkService {
  static Future<http.Response> createRequest(String url,
      Map<String, String> headers, RequestType type, Object body) async {
    switch (type) {
      case RequestType.get:
        try {
          return await http.get(Uri.parse(url), headers: headers);
        } catch (e) {
          rethrow;
        }
      case RequestType.post:
        try {
          return await http.post(Uri.parse(url), body: body, headers: headers);
        } catch (e) {
          throw ErrorHandler.get(e);
        }
      case RequestType.put:
        try {
          return await http.put(Uri.parse(url), body: body, headers: headers);
        } catch (e) {
          rethrow;
        }
      case RequestType.delete:
        try {
          return await http.delete(Uri.parse(url), headers: headers);
        } catch (e) {
          rethrow;
        }
    }
  }
}
