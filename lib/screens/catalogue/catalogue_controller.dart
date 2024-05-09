import 'package:firebase_project/data/repository/catalouge_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final catalougeProvider =
    FutureProvider.autoDispose.family((ref, int categoryId) async {
  return await CatalougeRepository.instance
      .getCatalouge(categoryId: categoryId);
});
