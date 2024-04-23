import 'package:firebase_project/data/model/product_detail_model.dart';
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
}
