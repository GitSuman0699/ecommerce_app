import 'dart:async';

import 'package:firebase_project/data/model/order_list_model.dart';
import 'package:firebase_project/data/repository/order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderListProvider =
    AsyncNotifierProvider.autoDispose<OrderList, OrderListModel?>(() {
  return OrderList();
});

class OrderList extends AutoDisposeAsyncNotifier<OrderListModel?> {
  @override
  FutureOr<OrderListModel?> build() {
    return getOrderList();
  }

  Future<OrderListModel?> getOrderList() async {
    try {
      final orderList = await OrderRepository.instance.getOrderList();
      return orderList;
    } catch (e) {
      rethrow;
    }
  }
}
