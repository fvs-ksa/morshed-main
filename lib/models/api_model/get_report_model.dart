class GetMyReportsModel {
  String? message;
  List<Reports>? reports;

  GetMyReportsModel({this.message, this.reports});

  GetMyReportsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['reports'] != null) {
      reports = <Reports>[];
      json['reports'].forEach((v) {
        reports!.add(new Reports.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.reports != null) {
      data['reports'] = this.reports!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reports {
  int? id;
  int? pilgrimId;
  int? reporterId;
  String? location;
  String? assistanceMethod;
  String? reportDetails;
  String? status;
  String? createdAt;
  String? updatedAt;
  var receiverId;
  bool? accepted;
  bool? generalization;
  String? latitude;
  String? longitude;
  var closedAt;
  var receiverName;
  var receiverMobile;
  var passportNumber;

  Reports(
      {this.id,
      this.pilgrimId,
      this.reporterId,
      this.location,
      this.assistanceMethod,
      this.reportDetails,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.receiverId,
      this.accepted,
      this.generalization,
      this.latitude,
      this.longitude,
      this.passportNumber,
      this.receiverMobile,
      this.receiverName,
      this.closedAt});

  Reports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pilgrimId = json['pilgrim_id'];
    reporterId = json['reporter_id'];
    location = json['location'];
    assistanceMethod = json['assistance_method'];
    reportDetails = json['report_details'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    receiverId = json['receiver_id'];
    accepted = json['accepted'];
    generalization = json['generalization'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    closedAt = json['closed_at'];
    receiverMobile = json['receiver_mobile'];
    receiverName = json['receiver_name'];
    passportNumber = json['passport_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pilgrim_id'] = this.pilgrimId;
    data['reporter_id'] = this.reporterId;
    data['location'] = this.location;
    data['assistance_method'] = this.assistanceMethod;
    data['report_details'] = this.reportDetails;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['receiver_id'] = this.receiverId;
    data['accepted'] = this.accepted;
    data['generalization'] = this.generalization;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['closed_at'] = this.closedAt;
    data['receiver_name'] = this.receiverName;
    data['receiver_mobile'] = this.receiverMobile;
    data['passport_number'] = this.passportNumber;
    return data;
  }
}
