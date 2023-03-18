class Users {
  bool? accept = false;
  String? checkImage ="";
  String? comment = "";
  String? product = "";
  String? useruid = "";

  Users({this.accept,this.checkImage,this.comment,this.product,this.useruid});

  Users.fromJson(Map<String, dynamic> json) {
    accept = json['accept'];
    checkImage = json['checkImage'];
    comment = json['comment'];
    product = json['product'];
    useruid = json['useruid'];
  }

  Map<String, dynamic> toJson() => {
    "accept": accept,
    "checkImage": checkImage,
    "comment": comment,
    "product": product,
    "useruid": useruid,
  };
}
