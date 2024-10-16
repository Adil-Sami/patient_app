// To parse this JSON data, do
//
//     final apiCallModel = apiCallModelFromJson(jsonString);

import 'dart:convert';

ApiCallModel apiCallModelFromJson(String str) => ApiCallModel.fromJson(json.decode(str));

String apiCallModelToJson(ApiCallModel data) => json.encode(data.toJson());

class ApiCallModel {
  String? message;
  String? error;
  int? status;
  dynamic data;

  ApiCallModel({
    this.message,
    this.error,
    this.status,
    this.data,
  });

  factory ApiCallModel.fromJson(Map<String, dynamic> json) => ApiCallModel(
    message: json["message"],
    error: json["error"],
    status: json["status"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "status": status,
    "data": data,
  };
}
