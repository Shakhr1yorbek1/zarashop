class Users {
  String? Phone;
  String? Name;
  String? LastName;
  String? Gmail;
  String? uid;

  Users({this.Name, this.LastName, this.Phone});

  Users.fromJson(Map<String, dynamic> json) {
    Phone = json['Phone'];
    Name = json['Name'];
    LastName = json['LastName'];
    Gmail = json['Gmail'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() => {
        "Phone": Phone,
        "Name": Name,
        "LastName": LastName,
        "Gmail": Gmail,
        "uid": uid,
      };
}
