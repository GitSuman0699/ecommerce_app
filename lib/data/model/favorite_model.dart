class FavoriteModel {
  int? statusCode;
  List<Wishlist>? wishlist;
  int? totalItems;
  int? currentPage;
  int? totalPages;

  FavoriteModel(
      {this.statusCode,
      this.wishlist,
      this.totalItems,
      this.currentPage,
      this.totalPages});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['wishlist'] != null) {
      wishlist = <Wishlist>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(new Wishlist.fromJson(v));
      });
    }
    totalItems = json['total_items'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.wishlist != null) {
      data['wishlist'] = this.wishlist!.map((v) => v.toJson()).toList();
    }
    data['total_items'] = this.totalItems;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    return data;
  }
}

class Wishlist {
  int? id;
  int? productId;
  String? title;
  double? price;
  String? image;

  Wishlist({this.id, this.productId, this.title, this.price, this.image});

  Wishlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    title = json['title'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}
