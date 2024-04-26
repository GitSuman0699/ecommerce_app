import 'dart:collection';

import 'package:firebase_project/data/model/checkout_model.dart';
import 'package:firebase_project/data/repository/base_repository.dart';

class CheckoutRepository extends BaseRepository {
  CheckoutRepository._();
  static final instance = CheckoutRepository._();

  Future<CheckoutModel?> getCheckout() async {
    final response = await api.get("api/checkout/order/summary");
    if (response.statusCode == 200) {
      return CheckoutModel.fromJson(response.data);
    }
    return null;
  }

  Future placeOrderCOD({required Map<String, dynamic> codData}) async {
    print(codData);
    final response = await api.post("api/checkout/", data: codData);
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }
}
