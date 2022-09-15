// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'exceptions.dart';

class ApiService {
  static const String baseUrl = 'localhost:8080';

  final BaseClient client;
  ApiService({required this.client});

  Future<dynamic> get(String endpoint,
      {Map<String, String>? queryParams}) async {
    dynamic responseJson;
    try {
      final uri = Uri.https(baseUrl, endpoint, queryParams);
      if (kDebugMode) {
        print("URL: ${uri.toString()}");
      }
      final response = await client.get(uri);
      responseJson = _response(response);
    } catch (e) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> post(String endpoint, Map<String, String> params) async {
    dynamic responseJson;
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
      'Accept': 'application/json',
    };
    final prm = jsonEncode(params);
    try {
      final uri = Uri.https(baseUrl, endpoint);
      if (kDebugMode) {
        print("URL: ${uri.toString()}");
      }
      final response =
          await client.post(uri, body: prm, headers: requestHeaders);
      responseJson = _response(response);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    final buffer = StringBuffer();
    final requestBody =
        response.body.toString().isEmpty ? 'Empty' : response.body.toString();
    buffer.write('Body $requestBody');
    buffer.clear();
    switch (response.statusCode) {
      case HttpStatus.ok: //200
      case HttpStatus.created: //201
      case HttpStatus.noContent: // 204
        var responseJson = json.decode(response.body);
        return responseJson;
      case HttpStatus.unauthorized: //401
        throw UnAuthorizedException('UnAuthorizedException');
      case HttpStatus.forbidden: //403
        throw ForbiddenException('ForbiddenException');
      case HttpStatus.unprocessableEntity: //422
        var responseJson = json.decode(response.body) as Map<String, dynamic>;
        final listOfErrors = responseJson['errors'] as Map<String, dynamic>;
        var buffer = StringBuffer();
        listOfErrors.forEach((key, value) {
          final result = value as List;
          for (int i = 0; i < result.length; i++) {
            final element = result[i];
            buffer.write('-');
            buffer.write(element);
            buffer.write('\n');
          }
        });
        throw UnprocessedException(buffer.toString());
      case HttpStatus.notFound:
        throw ApiException('Not found');
      default:
        {
          final builder = StringBuffer();
          builder.write('Response Code: ${response.statusCode}');
          builder.writeln('Result: ${response.body}');
          throw ApiException(response.body.toString());
        }
    }
  }
}
