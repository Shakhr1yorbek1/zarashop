class Member {
  String uid = "";
  String? fullName = "";
  String device_id = "";
  String device_type = "";
  String device_token = "";


  Member({this.fullName});

  Member.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        fullName = json['fullName'],
        device_id = json['device_id'],
        device_type = json['device_type'],
        device_token = json['device_token'];

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'fullName': fullName,
    'device_id': device_id,
    'device_type': device_type,
    'device_token': device_token,
  };
}