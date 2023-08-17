class LoginModel {
  String? message;
  Data? data;
  String? token;

  LoginModel({this.message, this.data, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  int? id;
  String? nameEn;
  String? nameAr;
  String? phoneNumber;
  String? nationality;
  String? birthdate;
  String? email;
  String? passportNumber;
  String? visaNumber;
  String? borderNumber;
  String? arrivalDate;
  String? departureDate;
  String? locationMina;
  String? locationMozdalifa;
  String? locationArfat;
  String? typeOfDisability;
  String? accountType;
  String? agentName;
  String? password;
  String? qrCode;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? companyId;
  bool? disability;
  var fcmToken;
  var deletedAt;
  var hotel;
  var gender;
  String? latitudeMina;
  String? longitudeMina;
  String? latitudeMozdalifa;
  String? longitudeMozdalifa;
  String? latitudeArfat;
  String? longitudeArfat;
  String? hotelMakkah;
  String? latitudeMakkah;
  String? longitudeMakkah;
  String? hotelMadinah;
  String? latitudeMadinah;
  String? longitudeMadinah;
  String? locationMakkahHotel;
  String? locationMadinahHotel;
  String? companyName;
  Company? company;

  Data(
      {this.id,
        this.nameEn,
        this.nameAr,
        this.phoneNumber,
        this.nationality,
        this.birthdate,
        this.email,
        this.passportNumber,
        this.visaNumber,
        this.accountType,
        this.borderNumber,
        this.arrivalDate,
        this.departureDate,
        this.locationMina,
        this.locationMozdalifa,
        this.locationArfat,
        this.typeOfDisability,
        this.agentName,
        this.password,
        this.qrCode,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.companyId,
        this.disability,
        this.fcmToken,
        this.deletedAt,
        this.hotel,
        this.gender,
        this.latitudeMina,
        this.longitudeMina,
        this.latitudeMozdalifa,
        this.longitudeMozdalifa,
        this.latitudeArfat,
        this.longitudeArfat,
        this.hotelMakkah,
        this.latitudeMakkah,
        this.longitudeMakkah,
        this.hotelMadinah,
        this.latitudeMadinah,
        this.longitudeMadinah,
        this.locationMakkahHotel,
        this.locationMadinahHotel,
        this.companyName,
        this.company});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    phoneNumber = json['phone_number'];
    nationality = json['nationality'];
    birthdate = json['birthdate'];
    email = json['email'];
    passportNumber = json['passport_number'];
    visaNumber = json['visa_number'];
    borderNumber = json['border_number'];
    arrivalDate = json['arrival_date'];
    departureDate = json['departure_date'];
    locationMina = json['location_mina'];
    accountType=json['account_type'];
    locationMozdalifa = json['location_mozdalifa'];
    locationArfat = json['location_arfat'];
    typeOfDisability = json['type_of_disability'];
    agentName = json['agent_name'];
    password = json['password'];
    qrCode = json['qr_code'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    companyId = json['company_id'];
    disability = json['disability'];
    fcmToken = json['fcm_token'];
    deletedAt = json['deleted_at'];
    hotel = json['hotel'];
    gender = json['gender'];
    latitudeMina = json['latitude_mina'];
    longitudeMina = json['longitude_mina'];
    latitudeMozdalifa = json['latitude_mozdalifa'];
    longitudeMozdalifa = json['longitude__mozdalifa'];
    latitudeArfat = json['latitude_arfat'];
    longitudeArfat = json['longitude__arfat'];
    hotelMakkah = json['hotel_makkah'];
    latitudeMakkah = json['latitude_makkah'];
    longitudeMakkah = json['longitude__makkah'];
    hotelMadinah = json['hotel_madinah'];
    latitudeMadinah = json['latitude_madinah'];
    longitudeMadinah = json['longitude__madinah'];
    locationMakkahHotel = json['location_makkah_hotel'];
    locationMadinahHotel = json['location_madinah_hotel'];
    companyName = json['company_name'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['phone_number'] = this.phoneNumber;
    data['nationality'] = this.nationality;
    data['birthdate'] = this.birthdate;
    data['email'] = this.email;
    data['passport_number'] = this.passportNumber;
    data['visa_number'] = this.visaNumber;
    data['border_number'] = this.borderNumber;
    data['account_type']=this.accountType;
    data['arrival_date'] = this.arrivalDate;
    data['departure_date'] = this.departureDate;
    data['location_mina'] = this.locationMina;
    data['location_mozdalifa'] = this.locationMozdalifa;
    data['location_arfat'] = this.locationArfat;
    data['type_of_disability'] = this.typeOfDisability;
    data['agent_name'] = this.agentName;
    data['password'] = this.password;
    data['qr_code'] = this.qrCode;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['company_id'] = this.companyId;
    data['disability'] = this.disability;
    data['fcm_token'] = this.fcmToken;
    data['deleted_at'] = this.deletedAt;
    data['hotel'] = this.hotel;
    data['gender'] = this.gender;
    data['latitude_mina'] = this.latitudeMina;
    data['longitude_mina'] = this.longitudeMina;
    data['latitude_mozdalifa'] = this.latitudeMozdalifa;
    data['longitude__mozdalifa'] = this.longitudeMozdalifa;
    data['latitude_arfat'] = this.latitudeArfat;
    data['longitude__arfat'] = this.longitudeArfat;
    data['hotel_makkah'] = this.hotelMakkah;
    data['latitude_makkah'] = this.latitudeMakkah;
    data['longitude__makkah'] = this.longitudeMakkah;
    data['hotel_madinah'] = this.hotelMadinah;
    data['latitude_madinah'] = this.latitudeMadinah;
    data['longitude__madinah'] = this.longitudeMadinah;
    data['location_makkah_hotel'] = this.locationMakkahHotel;
    data['location_madinah_hotel'] = this.locationMadinahHotel;
    data['company_name'] = this.companyName;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}

class Company {
  int? id;
  String? type;
  String? country;
  String? city;
  String? responsibleName;
  String? responsiblePhone;
  String? companyPhone;
  String? email;
  String? companyName;
  String? licenseNumber;
  String? location;
  String? password;
  var rememberToken;
  String? createdAt;
  String? updatedAt;
  var fcmToken;
  var deletedAt;
  String? accountType;

  Company(
      {this.id,
        this.type,
        this.country,
        this.city,
        this.responsibleName,
        this.responsiblePhone,
        this.companyPhone,
        this.email,
        this.companyName,
        this.licenseNumber,
        this.location,
        this.password,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
        this.fcmToken,
        this.deletedAt,
        this.accountType});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    country = json['country'];
    city = json['city'];
    responsibleName = json['responsible_name'];
    responsiblePhone = json['responsible_phone'];
    companyPhone = json['company_phone'];
    email = json['email'];
    companyName = json['company_name'];
    licenseNumber = json['license_number'];
    location = json['location'];
    password = json['password'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fcmToken = json['fcm_token'];
    deletedAt = json['deleted_at'];
    accountType = json['account_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['country'] = this.country;
    data['city'] = this.city;
    data['responsible_name'] = this.responsibleName;
    data['responsible_phone'] = this.responsiblePhone;
    data['company_phone'] = this.companyPhone;
    data['email'] = this.email;
    data['company_name'] = this.companyName;
    data['license_number'] = this.licenseNumber;
    data['location'] = this.location;
    data['password'] = this.password;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['fcm_token'] = this.fcmToken;
    data['deleted_at'] = this.deletedAt;
    data['account_type'] = this.accountType;
    return data;
  }
}