import 'package:firebase_project/data/model/cart_model.dart';
import 'package:firebase_project/data/repository/base_repository.dart';

class CartRepository extends BaseRepository {
  CartRepository._();
  static final instance = CartRepository._();

  Future<CartModel?> getCart() async {
    final response = await api.get("api/cart/all");
    if (response.statusCode == 200) {
      return CartModel.fromJson(response.data);
    }
    return null;
  }

  Future updateQuantity({required Map<String, dynamic> data}) async {
    final response = await api.put("api/cart/update", data: data);
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }

  Future deleteCartItem({required Map<String, dynamic> data}) async {
    final response = await api.delete("api/cart/delete", data: data);
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }
}
