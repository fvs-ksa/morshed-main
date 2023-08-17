class CompanyModel {
  String? message;
  List<Companies>? companies;

  CompanyModel({this.message, this.companies});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['companies'] != null) {
      companies = <Companies>[];
      json['companies'].forEach((v) {
        companies!.add(new Companies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.companies != null) {
      data['companies'] = this.companies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Companies {
  int? id;
  String? companyName;

  Companies({this.id, this.companyName});

  Companies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    return data;
  }
}