import 'dart:convert';

PrescriptionModel prescriptionModelFromJson(String str) => PrescriptionModel.fromJson(json.decode(str));
String prescriptionModelToJson(PrescriptionModel data) => json.encode(data.toJsonAdd());
class PrescriptionModel {
  String? id;
  String? prescription;
  String? patientName; //fcm id
  dynamic patientId;
  String? appointmentId;
  String? appointmentTime;
  String? appointmentDate;
  String? appointmentName;
  String? drName;
  String? imageUrl;

  PrescriptionModel({
    this.id,
    this.appointmentTime,
    this.appointmentDate,
    this.patientId,
    this.appointmentId,
    this.appointmentName,
    this.patientName,
    this.prescription,
    this.imageUrl,
    this.drName

  });

  factory PrescriptionModel.fromJson(Map<String,dynamic> json){
    return PrescriptionModel(
        id: json['id'],
        appointmentTime: json['appointmentTime'],
      appointmentDate: json['appointmentDate'],
      appointmentId: json['appointmentId'],
      patientId: json['patientId'],
      appointmentName: json['appointmentName'],
      prescription: json['prescription'],
      patientName: json['patientName'],
      imageUrl: json['imageUrl'],
      drName: json['drName']

    );
  }
  Map<String,dynamic> toJsonAdd(){
    return {
      "id":this.id,
      "appointmentId":this.appointmentId,
      "patientId":this.patientId,
      "appointmentTime":this.appointmentTime,
      "appointmentDate":this.appointmentDate,
      "imageUrl":this.imageUrl,
      "appointmentName":this.appointmentName,
      "drName":this.drName,
      "patientName":this.patientName,
      "prescription":this.prescription,
    };
  }

}
