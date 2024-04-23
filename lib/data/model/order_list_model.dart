class OrderListModel {
  int? status;
  List<Orders>? orders;

  OrderListModel({this.status, this.orders});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int? id;
  String? orderNumber;
  int? userId;
  String? title;
  double? price;
  int? quantity;
  double? totalAmount;
  String? status;
  String? image;
  String? createdAt;

  Orders(
      {this.id,
      this.orderNumber,
      this.userId,
      this.title,
      this.price,
      this.quantity,
      this.totalAmount,
      this.status,
      this.image,
      this.createdAt});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    userId = json['user_id'];
    title = json['title'];
    price = json['price'];
    quantity = json['quantity'];
    totalAmount = json['total_amount'];
    status = json['status'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_number'] = this.orderNumber;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['total_amount'] = this.totalAmount;
    data['status'] = this.status;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}
