class CartListModelClass {
  int? status;
  String? message;
  int? totalRecord;
  int? totalPage;
  List<DataList>? data;

  CartListModelClass(
      {this.status, this.message, this.totalRecord, this.totalPage, this.data});

  CartListModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalRecord = json['totalRecord'];
    totalPage = json['totalPage'];
    if (json['data'] != null) {
      data = <DataList>[];
      json['data'].forEach((v) {
        data!.add(DataList.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['totalRecord'] = totalRecord;
    data['totalPage'] = totalPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataList {
  int? id;
  String? slug;
  String? title;
  String? description;
  int? price;
  int? productPrice;
  String? image;
  String? status;

  DataList(
      {
       required this.id,
        required this.slug,
        required this.title,
        required this.description,
        required this.price,
        required this.productPrice,
        required this.image,
        required this.status,
      });

  DataList.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    productPrice = json['productPrice'];
    image = json['featured_image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['slug'] = slug;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['productPrice'] = productPrice;
    data['image'] = image;
    data['status'] = status;
    return data;
  }
}

