import 'dart:convert';
import 'dart:io';

import 'notificationModel.dart';


List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

UserModel userModelFromJsonSingle(String str) => UserModel.fromJson(json.decode(str));

class UserModel{
  String? firstName;
  String? lastName;
  String? uId;
  String? city;
  String? email;
  String? fcmId;
  String? imageUrl;
  String? pNo;
  String? searchByName;
  String? age;
  String? gender;
  String? createdDate;
  String? id;
  var mrd;
  var phone;
  String? amount;
  NotificationModel? latestNotification;

  UserModel({
    this.firstName,
    this.lastName,
    this.uId,//firebase uid
    this.city,
    this.email,
    this.fcmId,
    this.imageUrl,
    this.pNo,
    this.searchByName,
    this.age,
    this.gender,
    this.createdDate,
    this.id,
    this.mrd,
    this.phone,
    this.amount,
    this.latestNotification,
  });

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      firstName:json['firstName'],
      lastName:json['lastName'],
      uId:json['uId'],
      city:json['city'],
      email:json['email'],
      fcmId:json['fcmId'],
      imageUrl:json['imageUrl'],
      pNo:json['pNo'],
      searchByName:json['searchByName'],
      age:json['age'],
      gender: json['gender'],
      createdDate:json['createdTimeStamp'],
      mrd: json['mrd'],
      id: json['id'].toString(),
      amount: json['amount'],
      latestNotification: json['latest_notification'] != null ? NotificationModel.fromJson(json['latest_notification']): null,
    );
  }
  Map<String,dynamic> toJsonAdd(){
    return {
      "firstName": this.firstName,
      "lastName": this.lastName,
      "uId": this.uId, //firebase uid
      "city": this.city,
      "email": this.email,
      "fcmId": this.fcmId,
      "imageUrl": this.imageUrl,
      "pNo": this.pNo,
      "searchByName":this.searchByName,
      "age": this.age,
      "gender":this.gender,
      "phone":this.phone
    };

  }
  Map<String,dynamic> toUpdateJson(){
    return {
      "firstName": this.firstName,
      "lastName": this.lastName,
      "city": this.city,
      "age": this.age,
      "email": this.email,
      "imageUrl": this.imageUrl,
      "searchByName":this.searchByName,
      "uId": this.uId,
      "gender":this.gender,
      "mrd":this.mrd
    };
  }
}
