import 'package:firebase_project/data/repository/product_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ratingStarProvider = StateProvider((ref) {
  return 0;
});

final reviewSubmitProvider = FutureProvider.autoDispose
    .family((ref, Map<String, dynamic> reviewData) async {
  try {
    return await ProductDetailRepository.instance
        .submitProductReview(reviewdData: {
      "product_id": reviewData['product_id'],
      "review": reviewData['review'],
      "rating": ref.read(ratingStarProvider),
    });
  } catch (e) {
    rethrow;
  }
});
