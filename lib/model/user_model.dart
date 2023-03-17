class Users {
  String? phone;
  String? name;
  String? lastName = "";
  String? gmail = "";
  String? uid;

  Users({this.name, this.lastName, this.phone});

  Users.fromJson(Map<String, dynamic> json) {
    phone = json['Phone'];
    name = json['Name'];
    lastName = json['LastName'];
    gmail = json['Gmail'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() => {
        "Phone": phone,
        "Name": name,
        "LastName": lastName,
        "Gmail": gmail,
        "uid": uid,
      };
}
