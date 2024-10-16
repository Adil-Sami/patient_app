
import 'dart:convert';

AppointmentModel appointmentModelFromJsonSingle(String str) => AppointmentModel.fromJson(json.decode(str));

class AppointmentModel{
  var appointmentDate;
  var appointmentStatus;
  var appointmentTime;
  var pCity;
  var age;
  var pEmail;
  var pFirstName;
  var pLastName;
  var serviceName;
  var serviceTimeMin;
  var uId;
  var userId;
  var pPhn;
  var description;
  var searchByName;
  var uName;
  var id;
  var createdTimeStamp;
  var updatedTimeStamp;
  var gender;
  var doctName;
  var department;
  var hName;
  var doctId;
  var  paymentStatus;
  var paymentDate;
  var oderId;
  var  amount;
  var  paymentMode;
  var isOnline;
  var gMeetLink;
  var  clinicId;
  var deptId;
  var cityId;
  var clinicName;
  var cityName;
  var dateC;
  var walkin;
  var vByUser;
  var type;
  AppointmentModel({
    this.appointmentDate,
    this.appointmentStatus,
    this.appointmentTime,
    this.pCity,
    this.age,
    this.pEmail,
    this.pFirstName,
    this.pLastName,
    this.serviceName,
    this.serviceTimeMin,
    this.uId,
    this.userId,
    this.pPhn,
    this.description,
    this.searchByName,
    this.uName,
    this.id,
    this.createdTimeStamp,
    this.updatedTimeStamp,
    this.gender,
    this.doctName,
    this.hName,
    this.department,
    this.doctId,
    this.amount,
    this.oderId,
    this.paymentMode,
    this.isOnline,
    this.gMeetLink,
    this.paymentStatus,
    this.paymentDate,
    this.clinicId,
    this.cityId,
    this.deptId,
    this.clinicName,
    this.cityName,
    this.dateC,
    this.walkin,
    this.vByUser,
    this.type,

  });

  factory AppointmentModel.fromJson(Map<String,dynamic> json){
    return AppointmentModel(
      appointmentDate:json['appointmentDate'],
      appointmentStatus:json['appointmentStatus'],
      appointmentTime:json['appointmentTime'],
      pCity:json['pCity'],
      age:json['age'],
      pEmail:json['pEmail'],
      pFirstName:json['pFirstName'],
      pLastName:json['pLastName'],
      serviceName:json['serviceName'],
      serviceTimeMin:json['serviceTimeMin'] != '' ? json['serviceTimeMin'] : '30' ,
      uId:json['uId'],
      userId:json['user_id'],
      pPhn:json['pPhn'],
      description:json['description'],
      searchByName:json['searchByName'],
      uName:json['uName'],
        id:json['id'],
        createdTimeStamp:json['createdTimeStamp'],
        updatedTimeStamp:json['updatedTimeStamp'],
      gender: json['gender'],
        department:json['department'],
        doctName:json['doctName'],
        hName: json['hName'],
      doctId: json['doctId'],
        amount: json['amount'],
        paymentMode:json['paymentMode'],
        oderId: json["orderId"],
        paymentDate:json['paymentDate'],
        paymentStatus: json['paymentStatus'],
        isOnline: json['isOnline'],
        gMeetLink:json['gmeetLink'],
      clinicName: json['title'],
      cityName: json['cityName'],
      cityId: json['cityId'],
      clinicId: json['clinicId'],
      deptId: json['deptId'],
      walkin: json['walkin'],
        vByUser: json['visited_by_user'],
        type: json['type']
    );
  }
   Map<String,dynamic> toJsonAdd(){
    return {
      "appointmentDate":this.appointmentDate.toString(),
      "appointmentStatus":this.appointmentStatus.toString(),
      "appointmentTime":this.appointmentTime.toString(),
      "pCity":this.pCity.toString(),
      "age":this.age.toString(),
      "pEmail":this.pEmail.toString(),
      "pFirstName":this.pFirstName.toString(),
      'pLastName':this.pLastName.toString(),
      "serviceName":this.serviceName.toString(),
      "serviceTimeMin":(this.serviceTimeMin).toString(),
      "uId":this.uId.toString(),
      "user_id":this.userId.toString(),
      "pPhn":this.pPhn.toString(),
      "description":this.description.toString(),
      "searchByName":this.searchByName.toString(),
      "uName":this.uName.toString(),
      "gender":this.gender.toString(),
      "doctName":this.doctName.toString(),
      "department":this.department.toString(),
      "hName":this.hName.toString(),
      "doctId":this.doctId.toString(),
      "orderId":this.oderId.toString(),
      "paymentStatus":this.paymentStatus.toString(),
      "amount":this.amount.toString(),
      "paymentMode":this.paymentMode.toString(),
      "isOnline":this.isOnline.toString(),
      "clinicId":this.clinicId.toString(),
      "cityId":this.cityId.toString(),
      "deptId":this.deptId.toString(),
      "date_c":this.dateC.toString(),
      "type":this.type.toString(),

        };


  }
  Map<String,dynamic> toJsonUpdateStatus(){
    return {

      "appointmentStatus":this.appointmentStatus,
      "id":this.id,

    };

  }
  Map<String,dynamic> toJsonUpdateResch(){
    return {
      "appointmentStatus":this.appointmentStatus,
      "id":this.id,
      "appointmentDate":this.appointmentDate,
      "appointmentTime":this.appointmentTime,
      "date_c":this.dateC

    };

  }
}
