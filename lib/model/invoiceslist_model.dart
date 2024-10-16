// To parse this JSON data, do
//
//     final invoiceslistModel = invoiceslistModelFromJson(jsonString);

import 'dart:convert';

InvoiceslistModel invoiceslistModelFromJson(String str) => InvoiceslistModel.fromJson(json.decode(str));

String invoiceslistModelToJson(InvoiceslistModel data) => json.encode(data.toJson());

class InvoiceslistModel {
  String st;
  String msg;
  List<Datum> data;

  InvoiceslistModel({
    required this.st,
    required this.msg,
    required this.data,
  });

  factory InvoiceslistModel.fromJson(Map<String, dynamic> json) => InvoiceslistModel(
    st: json["st"],
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "st": st,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String status;
  String description;
  String amount;
  String paymentId;
  String uid;
  DateTime createdTimeStamp;

  Datum({
    required this.id,
    required this.status,
    required this.description,
    required this.amount,
    required this.paymentId,
    required this.uid,
    required this.createdTimeStamp,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    status: json["status"],
    description: json["description"],
    amount: json["amount"],
    paymentId: json["payment_id"],
    uid: json["uid"],
    createdTimeStamp: DateTime.parse(json["created_time_stamp"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "description": description,
    "amount": amount,
    "payment_id": paymentId,
    "uid": uid,
    "created_time_stamp": createdTimeStamp.toIso8601String(),
  };
}
