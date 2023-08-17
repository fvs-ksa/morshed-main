class GetMyCompanions {
  List<Companions>? companions;

  GetMyCompanions({this.companions});

  GetMyCompanions.fromJson(Map<String, dynamic> json) {
    if (json['companions'] != null) {
      companions = <Companions>[];
      json['companions'].forEach((v) {
        companions!.add(new Companions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.companions != null) {
      data['companions'] = this.companions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Companions {
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
  String? agentName;
  String? password;
  String? qrCode;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? companyId;
  bool? disability;
  Null? fcmToken;
  Null? deletedAt;
  Pivot? pivot;

  Companions(
      {this.id,
        this.nameEn,
        this.nameAr,
        this.phoneNumber,
        this.nationality,
        this.birthdate,
        this.email,
        this.passportNumber,
        this.visaNumber,
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
        this.pivot});

  Companions.fromJson(Map<String, dynamic> json) {
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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? pilgrimId;
  int? companionId;

  Pivot({this.pilgrimId, this.companionId});

  Pivot.fromJson(Map<String, dynamic> json) {
    pilgrimId = json['pilgrim_id'];
    companionId = json['companion_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pilgrim_id'] = this.pilgrimId;
    data['companion_id'] = this.companionId;
    return data;
  }
}