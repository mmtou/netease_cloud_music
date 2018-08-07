import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Http {
  static const defaultContentType = 'application/x-www-form-urlencoded';

  static Dio getDioInstant() {
    Dio dio = new Dio();
    dio.interceptor.request.onSend = (Options options) {
      // Do something before request is sent
      print('http request: ${options}');
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    };
    dio.interceptor.response.onSuccess = (Response response) {
      // Do something with response data
      print('http response success: statusCode: ${response.statusCode}, response: ${response}');

      return response; // continue
    };
    dio.interceptor.response.onError = (DioError e) {
      // Do something with response error
      print('http response error: ${e}');
      return DioError; //continue
    };
    return dio;
  }

  static Future<Response<T>> post<T>(String url, Map data,
      {String contentType: defaultContentType}) async {
    Dio dio = getDioInstant();
    Future<Response<T>> response = dio.post(url,
        data: data,
        options: new Options(contentType: ContentType.parse(contentType)));
    return response;
  }
}
