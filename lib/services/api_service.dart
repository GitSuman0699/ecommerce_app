import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_project/utils/local_storage/storage.dart';

class ApiService extends DioForNative {
  ApiService() {
    options.baseUrl = "http://192.168.0.126:8080/";
    options.connectTimeout = const Duration(seconds: 15);
    options.receiveTimeout = const Duration(seconds: 15);

    interceptors
      ..clear()
      ..add(InterceptorsWrapper());
  }
}

class InterceptorsWrapper extends QueuedInterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      log('send request：${options.baseUrl}${options.path}');

      final accessToken = Prefs.instance.getToken();

      options.headers['X-API-Key'] = "ratiman~ecomm@24~";

      options.headers['auth-user-id'] = '$accessToken';

      super.onRequest(options, handler);
    } catch (e) {
      rethrow;
    }
  }
}
