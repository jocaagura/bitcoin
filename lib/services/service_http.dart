import 'dart:convert';

import 'package:dio/dio.dart';

import '../helpers.dart';

/// this main service will provide the management of http request using som package

class ServiceHttp {
  static Future<Map<String, dynamic>> jsonGetRequestHttp(
      {required String url, Map<String, String> parameters = const {}}) async {
    Map<String, dynamic> tmpMap = {};
    final dio = Dio();
    if (Helpers.validateUrl(url)) {
      try {
        /// BlocCentral is singleton class we wouldn't a new instance Here
        final response =
            await dio.get(url, queryParameters: parameters);
        if (response.data.runtimeType == String) {
          tmpMap = jsonDecode(response.data);
        } else if (response.data is Map<String, dynamic>) {
          tmpMap = response.data;
        }
      } on DioError catch (e) {
        print(e);
        tmpMap = {};
        throw(e);
      }catch(e){
        print(e);
        tmpMap = {};
        throw(e);
      }
    }
    return tmpMap;
  }

  static Future<Map<String, dynamic>> jsonPostRequestHttp(
      {required String url, Map<String, dynamic> parameters = const {}}) async {
    Map<String, dynamic> tmpMap = {};
    final dio = Dio();
    if (Helpers.validateUrl(url)) {
      try {
        /// BlocCentral is singleton class we wouldn't a new instance Here
        final response = await dio.post(url, queryParameters: parameters);
        if (response.data.runtimeType == String) {
          tmpMap = jsonDecode(response.data);
        }
        if (response.data is Map<String, dynamic>) {
          tmpMap = response.data;
        }
      } on DioError catch (e) {
        print(e);
        tmpMap = {};
        throw(e);
      }catch(e){
        print(e);
        tmpMap = {};
        throw(e);
      }
    }
    return tmpMap;
  }
}
