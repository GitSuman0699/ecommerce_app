class ReviewModel {
  int? status;
  List<Reviews>? reviews;
  int? totalRecords;
  int? currentPage;
  int? totalPage;

  ReviewModel(
      {this.status,
      this.reviews,
      this.totalRecords,
      this.currentPage,
      this.totalPage});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    totalRecords = json['total_records'];
    currentPage = json['current_page'];
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    data['total_records'] = this.totalRecords;
    data['current_page'] = this.currentPage;
    data['total_page'] = this.totalPage;
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
