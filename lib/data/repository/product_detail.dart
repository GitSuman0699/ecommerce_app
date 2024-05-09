import 'package:firebase_project/data/model/product_detail_model.dart';
import 'package:firebase_project/data/model/review_model.dart';
import 'package:firebase_project/data/repository/base_repository.dart';

class ProductDetailRepository extends BaseRepository {
  ProductDetailRepository._();
  static final instance = ProductDetailRepository._();

  Future<ProductDetailModel?> getProductDetail({required int productId}) async {
    final response = await api.get("api/products/details/$productId");
    if (response.statusCode == 200) {
      return ProductDetailModel.fromJson(response.data);
    }
    return null;
  }

  Future<ReviewModel?> getProductReview({
    required int productId,
    required int page,
    required int limit,
  }) async {
    final response = await api
        .get("api/products/reviews/$productId?page=$page&limit=$limit");
    if (response.statusCode == 200) {
      return ReviewModel.fromJson(response.data);
    }
    return null;
  }

  Future submitProductReview(
      {required Map<String, dynamic> reviewdData}) async {
    final response = await api.post("api/review/add", data: reviewdData);
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }
}
