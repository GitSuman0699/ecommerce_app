import 'package:firebase_project/data/model/category_model.dart';
import 'package:firebase_project/data/repository/base_repository.dart';

class CatalougeRepository extends BaseRepository {
  CatalougeRepository._();
  static final instance = CatalougeRepository._();

  Future<CategoryModel?> getCatalouge({required int categoryId}) async {
    final response = await api.get("api/category/list/$categoryId");
    if (response.statusCode == 200) {
      return CategoryModel.fromJson(response.data);
    }
    return null;
  }
}
