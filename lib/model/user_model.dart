
class Users {
  String? phone;
  String? Name;
  String? LastName;
  String? Gmail;
  String? uid;


  Users({this.Name,this.LastName});

  Users.fromJson(Map<String ,dynamic> json) {
    phone=json['phone'];
    Name=json['Name'];
    LastName=json['LastName'];
    Gmail=json['Gmail'];
    uid=json['uid'];
  }

  Map<String,dynamic> toJson ()=>{
    "phone":phone,
    "Name":Name,
    "LastName":LastName,
    "Gmail":Gmail,
    "uid":uid,
  };
}