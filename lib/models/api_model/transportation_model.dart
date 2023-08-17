class TransportationModel {
  String? message;
  List<Data>? data;

  TransportationModel({this.message, this.data});

  TransportationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? lat;
  String? long;
  String? imagepath;

  Data({this.id, this.name, this.lat, this.long, this.imagepath});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lat = json['lat'];
    long = json['long'];
    imagepath = json['imagepath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['imagepath'] = this.imagepath;
    return data;
  }
}