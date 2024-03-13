import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:practice_test/models/product_model.dart';

import 'app_exception.dart';

class NetWorkApiService {
  dynamic noInternetJson = {
    'status_message': 'No internet connection',
    'status_code': '999'
  };

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        if (kDebugMode) {
          debugPrint(
              "The returnResponse in network_api is ${jsonDecode(response.body)}");
        }
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw BadRequestException(response.body.toString());
      case 500:
        throw BadRequestException(response.body.toString());
      default:
        throw FetchDataException(
            "Error accorded while communicating with server with status code ${response.statusCode}");
    }
  }

  getProductspiResponse(
    String url,
  ) async {
    dynamic responseJson;
    try {
      http.Response response =
      await http.get(Uri.parse(url));
      responseJson = returnResponse(response);
    } on SocketException {
      responseJson = noInternetJson;
      //  throw FetchDataException("No Internet Connection");
    } catch (e) {
      debugPrint("The exception is ${e.toString()}");
      if (e.toString() == 'Software caused connection abort') {
        responseJson = noInternetJson;
      }
    }
    return responseJson;
  }
}
