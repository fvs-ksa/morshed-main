class GetProvidersModel {
  String? message;
  List<Providers>? providers;

  GetProvidersModel({this.message, this.providers});

  GetProvidersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['Providers'] != null) {
      providers = <Providers>[];
      json['Providers'].forEach((v) {
        providers!.add(new Providers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.providers != null) {
      data['Providers'] = this.providers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Providers {
  int? id;
  String? name;
  String? gender;
  String? nationality;
  var serviceProviderType;
  int? companyId;
  String? preferredLanguage;
  String? birthdate;
  String? phoneNumber;
  String? passportNumber;
  var residenceCity;
  String? lat;
  String? lng;
  String? email;
  var fcmToken;
  var deletedAt;
  var createdAt;
  var updatedAt;
  var location;

  Providers(
      {this.id,
        this.name,
        this.gender,
        this.lat,
        this.lng,
        this.nationality,
        this.serviceProviderType,
        this.companyId,
        this.preferredLanguage,
        this.birthdate,
        this.phoneNumber,
        this.passportNumber,
        this.residenceCity,
        this.email,
        this.fcmToken,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.location});

  Providers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    nationality = json['nationality'];
    serviceProviderType = json['service_provider_type'];
    companyId = json['company_id'];
    preferredLanguage = json['preferred_language'];
    birthdate = json['birthdate'];
    phoneNumber = json['phone_number'];
    passportNumber = json['passport_number'];
    residenceCity = json['residence_city'];
    email = json['email'];
    fcmToken = json['fcm_token'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    location = json['location'];
    lat=json['latitude'];
    lng=json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['nationality'] = this.nationality;
    data['service_provider_type'] = this.serviceProviderType;
    data['company_id'] = this.companyId;
    data['preferred_language'] = this.preferredLanguage;
    data['birthdate'] = this.birthdate;
    data['phone_number'] = this.phoneNumber;
    data['passport_number'] = this.passportNumber;
    data['residence_city'] = this.residenceCity;
    data['email'] = this.email;
    data['fcm_token'] = this.fcmToken;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['location'] = this.location;
    data['longitude']=this.lng;
    data['latitude']=this.lat;
    return data;
  }
}