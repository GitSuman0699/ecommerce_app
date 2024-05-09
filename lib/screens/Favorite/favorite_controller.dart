import 'dart:async';

import 'package:firebase_project/data/model/favorite_model.dart';
import 'package:firebase_project/data/repository/favorite_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/src/async_notifier.dart';

final favoriteProvider =
    AsyncNotifierProvider.autoDispose<FavoriteData, List<Wishlist>>(() {
  return FavoriteData();
});

class FavoriteData extends AutoDisposeAsyncNotifier<List<Wishlist>> {
  List<Wishlist> wishlist = [];
  int currentPage = 1;
  int totalPage = 0;
  int limit = 20;

  @override
  FutureOr<List<Wishlist>> build() {
    return getFavorite();
  }

  Future<List<Wishlist>> getFavorite() async {
    final favoriteData = await FavoriteRepository.instance.getFavorite(
      currentPage: currentPage,
      limit: limit,
    );

    wishlist.addAll(favoriteData!.wishlist!);

    totalPage = favoriteData.totalPages!;

    currentPage++;

    return wishlist;
  }

  Future deleteFavorite({required int productId}) async {
    return await FavoriteRepository.instance
        .deleteFavorite(productId: productId);
  }
}
