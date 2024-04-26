class ShippingAddressModel {
  int? statusCode;
  List<Address>? address;
  int? totalAddress;
  int? currentPage;
  int? totalPages;

  ShippingAddressModel(
      {this.statusCode,
      this.address,
      this.totalAddress,
      this.currentPage,
      this.totalPages});

  ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
    totalAddress = json['total_address'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    data['total_address'] = this.totalAddress;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    return data;
  }
}

class Address {
  int? id;
  int? userId;
  String? name;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? country;
  String? phone;
  String? altPhone;
  int? defaultAddress;

  Address(
      {this.id,
      this.userId,
      this.name,
      this.address,
      this.city,
      this.state,
      this.pincode,
      this.country,
      this.phone,
      this.altPhone,
      this.defaultAddress});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    country = json['country'];
    phone = json['phone'];
    altPhone = json['alt_phone'];
    defaultAddress = json['default_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['alt_phone'] = this.altPhone;
    data['default_address'] = this.defaultAddress;
    return data;
  }
}
