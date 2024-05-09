import 'dart:async';
import 'package:firebase_project/data/model/product_detail_model.dart';
import 'package:firebase_project/data/repository/favorite_repository.dart';
import 'package:firebase_project/data/repository/product_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_project/data/model/review_model.dart' as rw;

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

final reviewProvider = AsyncNotifierProvider.autoDispose
    .family<ReviewsList, List<rw.Reviews>, int>(() {
  return ReviewsList();
});

class ReviewsList
    extends AutoDisposeFamilyAsyncNotifier<List<rw.Reviews>, int> {
  int currentPage = 1;
  late int totalPage;
  List<rw.Reviews> reviewList = [];
  int limit = 20;

  @override
  FutureOr<List<rw.Reviews>> build(int arg) {
    return getReviews();
  }

  Future<List<rw.Reviews>> getReviews() async {
    final reviews = await ProductDetailRepository.instance
        .getProductReview(productId: arg, page: currentPage, limit: limit);

    reviewList.addAll(List.from(reviews!.reviews!));

    totalPage = reviews.totalPage!;

    currentPage++;

    return reviewList;
  }
}
