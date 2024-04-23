import 'package:firebase_project/data/repository/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = FutureProvider.autoDispose((ref) async {
  return await HomeRepository.instance.getHomeData();
});
