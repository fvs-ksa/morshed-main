class GetAllOffices {
  String? message;
  List<Offices>? offices;

  GetAllOffices({this.message, this.offices});

  GetAllOffices.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['offices'] != null) {
      offices = <Offices>[];
      json['offices'].forEach((v) {
        offices!.add(new Offices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.offices != null) {
      data['offices'] = this.offices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offices {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? adminName;
  String? phoneNumber;
  String? email;
  String? address;
  double? latitude;
  double? longitude;
  String? password;
  Null? deletedAt;
  Null? rememberToken;
  String? fcmToken;
  String? accountType;

  Offices(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.adminName,
        this.phoneNumber,
        this.email,
        this.address,
        this.latitude,
        this.longitude,
        this.password,
        this.deletedAt,
        this.rememberToken,
        this.fcmToken,
        this.accountType});

  Offices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    adminName = json['admin_name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    password = json['password'];
    deletedAt = json['deleted_at'];
    rememberToken = json['remember_token'];
    fcmToken = json['fcm_token'];
    accountType = json['account_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['admin_name'] = this.adminName;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['password'] = this.password;
    data['deleted_at'] = this.deletedAt;
    data['remember_token'] = this.rememberToken;
    data['fcm_token'] = this.fcmToken;
    data['account_type'] = this.accountType;
    return data;
  }
}