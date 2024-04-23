import 'package:firebase_project/data/model/order_list_model.dart';
import 'package:firebase_project/data/repository/base_repository.dart';

class OrderRepository extends BaseRepository {
  OrderRepository._();
  static final instance = OrderRepository._();

  Future<OrderListModel?> getOrderList() async {
    final response = await api.get("api/orders/");
    if (response.statusCode == 200) {
      return OrderListModel.fromJson(response.data);
    }
    return null;
  }
}
