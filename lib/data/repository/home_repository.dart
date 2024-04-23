import 'package:firebase_project/data/model/home_model.dart';
import 'package:firebase_project/data/repository/base_repository.dart';
import 'package:firebase_project/utils/local_storage/storage.dart';

class HomeRepository extends BaseRepository {
  HomeRepository._();
  static final instance = HomeRepository._();

  final userId = Prefs.instance.getToken();

  Future<HomeModel?> getHomeData() async {
    final response = await api.get("api/home/");
    if (response.statusCode == 200) {
      return HomeModel.fromJson(response.data);
    }
    return null;
  }
}
