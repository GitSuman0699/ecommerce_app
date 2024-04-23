import 'package:firebase_project/services/api_service.dart';

abstract class BaseRepository {
  ApiService get api => ApiService();
}
