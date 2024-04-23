import 'dart:async';
import 'package:firebase_project/data/model/product_detail_model.dart';
import 'package:firebase_project/data/repository/favorite_repository.dart';
import 'package:firebase_project/data/repository/product_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productDetailProvider = AsyncNotifierProvider.autoDispose
    .family<ProductDetail, ProductDetailModel?, int>(() {
  return ProductDetail();
});

class ProductDetail
    extends AutoDisposeFamilyAsyncNotifier<ProductDetailModel?, int> {
  @override
  FutureOr<ProductDetailModel?> build(int arg) {
    return getProductDetail();
  }

  Future<ProductDetailModel?> getProductDetail() async {
    try {
      final productDetail = await ProductDetailRepository.instance
          .getProductDetail(productId: arg);

      return productDetail;
    } catch (e) {
      rethrow;
    }
  }

  Future addFavorite({required int productId}) async {
    try {
      final favorite =
          await FavoriteRepository.instance.addFavorite(productId: productId);
      return favorite;
    } catch (e) {
      rethrow;
    }
  }
}
