import 'package:firebase_project/data/repository/base_repository.dart';
import 'package:dio/dio.dart' as dio;

class AuthRepository extends BaseRepository {
  AuthRepository._();
  static final instance = AuthRepository._();

  Future postUserAuthData({required dio.FormData userData}) async {
    try {
      final response = await api.post("api/auth/login", data: userData);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      rethrow;
    }
  }
}
