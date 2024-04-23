import 'dart:async';

import 'package:firebase_project/data/model/favorite_model.dart';
import 'package:firebase_project/data/repository/favorite_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/src/async_notifier.dart';

final favoriteProvider =
    AsyncNotifierProvider.autoDispose<FavoriteData, FavoriteModel?>(
  () {
    return FavoriteData();
  },
);

class FavoriteData extends AutoDisposeAsyncNotifier<FavoriteModel?> {
  @override
  FutureOr<FavoriteModel?> build() {
    return getFavorite();
  }

  Future<FavoriteModel?> getFavorite() async {
    return await FavoriteRepository.instance.getFavorite();
  }

  Future deleteFavorite({required int productId}) async {
    return await FavoriteRepository.instance
        .deleteFavorite(productId: productId);
  }
}
