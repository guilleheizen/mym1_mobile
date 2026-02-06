import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mym1_mobile/env/env.dart';
import 'package:mym1_mobile/util/index.dart';

final clientProvider = AsyncNotifierProvider<ClientNotifier, Dio>(ClientNotifier.new);

class ClientNotifier extends AsyncNotifier<Dio> {
  @override
  Future<Dio> build() async {
    final options = BaseOptions(
      headers: {
        "KZ-privateKey": Env.privateKey,
        "KZ-publicKey": Env.publicKey,
        "KZ-version": Env.version,
        "KZ-platform": Platform.isAndroid ? 'ANDROID' : 'IOS',
      },
      connectTimeout: const Duration(seconds: 18),
      receiveTimeout: const Duration(seconds: 16),
    );

    final http = Dio(options);

    http.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          Log.http('URL: ${options.method} ${options.uri}');
          Log.http('HEADERS: ${options.headers}');
          Log.http('BODY: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          Log.http('RESPONSE: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) async {
          Log.http('ERROR RESPONSE: ${error.response?.statusCode} ${error.response?.data}');
          return handler.next(error);
        },
      ),
    );

    return http;
  }

  Future<void> setHeader(String key, String? value) async {
    await future;
    final header = {
      key: value,
    };
    state.value!.options.headers.addAll(header);
  }

  Future<Response<dynamic>> get(String url, {Map<String, dynamic>? queryParam}) async {
    await future;
    final response = await state.value!.get(url, queryParameters: queryParam);
    return response;
  }

  Future<Response<dynamic>> post(String url, {Map<String, dynamic>? queryParam, dynamic body}) async {
    await future;
    final response = await state.value!.post(url, queryParameters: queryParam, data: body);
    return response;
  }

  Future<Response<dynamic>> delete(String url, {Map<String, dynamic>? queryParam, dynamic body}) async {
    await future;
    final response = await state.value!.delete(url, queryParameters: queryParam, data: body);
    return response;
  }

  Future<Response<dynamic>> put(String url, {Map<String, dynamic>? queryParam, dynamic body}) async {
    await future;
    final response = await state.value!.put(url, queryParameters: queryParam, data: body);
    return response;
  }
}
