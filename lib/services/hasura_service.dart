import 'package:flutter/foundation.dart';
import 'package:hasura_cache_interceptor/hasura_cache_interceptor.dart';
import 'package:hasura_connect/hasura_connect.dart';

const String accessToken =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwibmFtZSI6IlVzZXIiLCJhZG1pbiI6ZmFsc2UsImhhc3VyYSI6eyJjbGFpbXMiOnsieC1oYXN1cmEtYWxsb3dlZC1yb2xlcyI6WyJ1c2VyIl0sIngtaGFzdXJhLWRlZmF1bHQtcm9sZSI6InVzZXIiLCJ4LWhhc3VyYS11c2VyLWlkIjoiMSIsIngtaGFzdXJhLW9yZy1pZCI6IjEyMyIsIngtaGFzdXJhLWN1c3RvbSI6ImN1c3RvbS1zc3ZhbHVlIn19LCJleHBpcmVzIjoxODIyMjAxMjE5LjAzMjEyODh9.HLcnFVzG0JSYB1OTRFEK0ISdnlnB3QH89p963yxolTk";

Map<String, String> header = {
  'content-type': 'application/json',
  'x-hasura-admin-secret': 'myadminsecretkey',
  // 'x-hasura-role': 'user',
  // 'x-hasura-user-id': '1',
};

String url = 'https://e-commerce-graphql.hasura.app/v1/graphql';
final storage = MemoryStorageService();
final cacheInterceptor = CacheInterceptor(storage);
HasuraConnect hasuraConnect = HasuraConnect(
  url,
  headers: header,
  interceptors: [cacheInterceptor, TokenInterceptor()],
);

/// TOKEN INTERCENPTOR
class TokenInterceptor extends InterceptorBase {
  @override
  Future? onRequest(Request request, HasuraConnect connect) async {
    request.headers['Authorization'] = 'Bearer $accessToken';
    return request;
  }

  @override
  Future? onResponse(Response data, HasuraConnect connect) async {
    debugPrint(data.toString(), wrapWidth: 9999);
    return data;
  }
}
