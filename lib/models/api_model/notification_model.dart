class GetNotificationModel {
  String? message;
  List<Notifications>? notifications;

  GetNotificationModel({this.message, this.notifications});

  GetNotificationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['Notifications'] != null) {
      notifications = <Notifications>[];
      json['Notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.notifications != null) {
      data['Notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int? id;
  int? pilgrimId;
  String? title;
  String? message;
  String? icon;
  bool? read;
  String? createdAt;
  String? updatedAt;

  Notifications(
      {this.id,
        this.pilgrimId,
        this.title,
        this.message,
        this.icon,
        this.read,
        this.createdAt,
        this.updatedAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pilgrimId = json['pilgrim_id'];
    title = json['title'];
    message = json['message'];
    icon = json['icon'];
    read = json['read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pilgrim_id'] = this.pilgrimId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['icon'] = this.icon;
    data['read'] = this.read;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}