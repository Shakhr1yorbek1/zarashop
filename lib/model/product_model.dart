class Product {
  String? uid;
  String? content;
  List? imgUrls;
  String? id;
  String? name;
  String? price;
  String? category;
  String? productOwner;
  bool? isAvailable;
  int? buyCount;
  String? date;
  bool isLiked = false;

  Product(
      {this.date,
      this.content,
      this.buyCount,
      this.category,
      this.id,
      this.name,
      this.price,
      this.imgUrls,
      this.isAvailable,
      this.productOwner});

  Product.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    date = json['date'];
    content = json['content'];
    imgUrls = json['imgUrls'];
    id = json['id'];
    name = json['name'];
    price = json['price'];
    productOwner = json["productOwner"];
    category = json['category'];
    isAvailable = json['isAvailable'];
    buyCount = json['buyCount'];
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "content": content,
        "date": date,
        "imgUrls": imgUrls,
        "buyCount": buyCount,
        "id": id,
        "name": name,
        "productOwner": productOwner,
        "price": price,
        "category": category,
        "isAvailable": isAvailable
      };
}
