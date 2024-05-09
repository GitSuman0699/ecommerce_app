class ProductDetailModel {
  int? status;
  Product? product;
  List<Reviews>? reviews;
  String? overallRating;

  ProductDetailModel(
      {this.status, this.product, this.reviews, this.overallRating});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    overallRating = json['overall_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    data['overall_rating'] = this.overallRating;
    return data;
  }
}

class Product {
  int? id;
  String? title;
  String? shortDescription;
  double? price;
  String? image;
  int? stock;
  List<Attributes>? attributes;
  bool? wishlist;
  bool? cart;

  Product(
      {this.id,
      this.title,
      this.shortDescription,
      this.price,
      this.image,
      this.stock,
      this.attributes,
      this.wishlist,
      this.cart});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDescription = json['short_description'];
    price = json['price'];
    image = json['image'];
    stock = json['stock'];
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
    wishlist = json['wishlist'];
    cart = json['cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['short_description'] = this.shortDescription;
    data['price'] = this.price;
    data['image'] = this.image;
    data['stock'] = this.stock;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    data['wishlist'] = this.wishlist;
    data['cart'] = this.cart;
    return data;
  }
}

class Attributes {
  String? name;
  List<String>? values;

  Attributes({this.name, this.values});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    values = json['values'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['values'] = this.values;
    return data;
  }
}

class Reviews {
  String? username;
  String? review;
  int? rating;
  String? date;

  Reviews({this.username, this.review, this.rating, this.date});

  Reviews.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    review = json['review'];
    rating = json['rating'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['date'] = this.date;
    return data;
  }
}
