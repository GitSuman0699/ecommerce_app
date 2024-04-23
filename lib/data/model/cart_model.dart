class CartModel {
  int? status;
  List<Carts>? carts;
  double? totalAmount;
  int? totalQuanity;

  CartModel({this.status, this.carts, this.totalAmount, this.totalQuanity});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) {
        carts!.add(new Carts.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    totalQuanity = json['total_quanity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.carts != null) {
      data['carts'] = this.carts!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = this.totalAmount;
    data['total_quanity'] = this.totalQuanity;
    return data;
  }
}

class Carts {
  int? id;
  int? productId;
  String? title;
  String? description;
  String? image;
  List<Attributes>? attributes;
  double? price;
  int? quantity;
  int? stock;
  double? totalAmount;
  String? createdAt;

  Carts(
      {this.id,
      this.productId,
      this.title,
      this.description,
      this.image,
      this.attributes,
      this.price,
      this.quantity,
      this.stock,
      this.totalAmount,
      this.createdAt});

  Carts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
    price = json['price'];
    quantity = json['quantity'];
    stock = json['stock'];
    totalAmount = json['total_amount'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['stock'] = this.stock;
    data['total_amount'] = this.totalAmount;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Attributes {
  String? name;
  String? values;

  Attributes({this.name, this.values});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    values = json['values'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['values'] = this.values;
    return data;
  }
}
