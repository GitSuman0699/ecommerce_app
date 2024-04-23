import 'package:firebase_project/data/model/favorite_model.dart';
import 'package:firebase_project/data/repository/base_repository.dart';

class FavoriteRepository extends BaseRepository {
  FavoriteRepository._();
  static final instance = FavoriteRepository._();

  Future<FavoriteModel?> getFavorite() async {
    final response = await api.get("api/wishlist/");
    if (response.statusCode == 200) {
      return FavoriteModel.fromJson(response.data);
    }
    return null;
  }

  Future deleteFavorite({required int productId}) async {
    final response =
        await api.delete("api/wishlist/delete", data: {"id": productId});
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }

  Future addFavorite({required int productId}) async {
    final response =
        await api.post("api/wishlist/add", data: {"product_id": productId});
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }
}
