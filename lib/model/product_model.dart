class Product {
  String? id;
  String? name;
  String? content;
  bool? isAvailable;
  List<String>? imgUrls;
  String? price;
  String? category;


  Product({this.id, this.name, this.content,this.isAvailable, this.imgUrls, this.category, this.price});

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json["name"],
        content = json['content'],
        isAvailable = json['isAvailable'],
        price = json['price'],
        category = json["category"],
        imgUrls = json['imgUrls'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name' : name,
    'content': content,
    "isAvailable" : isAvailable,
    'imgUrls': imgUrls,
    'category' : category,
    'price': price,
  };
}