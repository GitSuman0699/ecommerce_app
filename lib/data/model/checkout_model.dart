import 'package:firebase_project/data/model/shipping_address_model.dart';

import 'cart_model.dart';

class CheckoutModel {
  int? status;
  List<Address>? address;
  List<Carts>? carts;
  OrderSummary? orderSummary;
  List<PaymentMethod>? paymentMethod;

  CheckoutModel(
      {this.status,
      this.address,
      this.carts,
      this.orderSummary,
      this.paymentMethod});

  CheckoutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) {
        carts!.add(new Carts.fromJson(v));
      });
    }
    orderSummary = json['order_summary'] != null
        ? new OrderSummary.fromJson(json['order_summary'])
        : null;
    if (json['payment_method'] != null) {
      paymentMethod = <PaymentMethod>[];
      json['payment_method'].forEach((v) {
        paymentMethod!.add(new PaymentMethod.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    if (this.carts != null) {
      data['carts'] = this.carts!.map((v) => v.toJson()).toList();
    }
    if (this.orderSummary != null) {
      data['order_summary'] = this.orderSummary!.toJson();
    }
    if (this.paymentMethod != null) {
      data['payment_method'] =
          this.paymentMethod!.map((v) => v.toJson()).toList();
    }
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

class OrderSummary {
  int? totalItems;
  double? totalAmount;

  OrderSummary({this.totalItems, this.totalAmount});

  OrderSummary.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_items'] = this.totalItems;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class PaymentMethod {
  String? value;
  String? title;

  PaymentMethod({this.value, this.title});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['title'] = this.title;
    return data;
  }
}
