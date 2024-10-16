// To parse this JSON data, do
//
//     final reportsModel = reportsModelFromJson(jsonString);

import 'dart:convert';

List<ReportsModel> reportsModelFromJson(String str) => List<ReportsModel>.from(json.decode(str).map((x) => ReportsModel.fromJson(x)));

String reportsModelToJson(List<ReportsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReportsModel {
  int id;
  String uId;
  int userId;
  String appointmentId;
  String title;
  String imageUrl;
  DateTime createdTimeStamp;
  int isDeleted;
  Appointment? appointment;

  ReportsModel({
    required this.id,
    required this.uId,
    required this.userId,
    required this.appointmentId,
    required this.title,
    required this.imageUrl,
    required this.createdTimeStamp,
    required this.isDeleted,
    this.appointment,
  });

  factory ReportsModel.fromJson(Map<String, dynamic> json) => ReportsModel(
    id: json["id"],
    uId: json["u_id"],
    userId: json["user_id"],
    appointmentId: json["appointment_id"],
    title: json["title"],
    imageUrl: json["image_url"],
    createdTimeStamp: DateTime.parse(json["created_time_stamp"]),
    isDeleted: json["is_deleted"],
    appointment: json["appointment"] != null ? Appointment.fromJson(json["appointment"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "u_id": uId,
    "user_id": userId,
    "appointment_id": appointmentId,
    "title": title,
    "image_url": imageUrl,
    "created_time_stamp": "${createdTimeStamp.year.toString().padLeft(4, '0')}-${createdTimeStamp.month.toString().padLeft(2, '0')}-${createdTimeStamp.day.toString().padLeft(2, '0')}",
    "is_deleted": isDeleted,
    "appointment": appointment != null ? appointment!.toJson() : null,
  };
}

class Appointment {
  int id;
  String appointmentDate;
  String appointmentTime;
  String description;

  Appointment({
    required this.id,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.description,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json["id"],
    appointmentDate: json["appointmentDate"],
    appointmentTime: json["appointmentTime"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "appointmentDate": appointmentDate,
    "appointmentTime": appointmentTime,
    "description": description,
  };
}
