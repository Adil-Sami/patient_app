
class DrProfileModel{
  String? firstName;
  String? lastName;
  String? email;
  String? pNo1;
  String? pNo2;
  String? description;
  String? whatsAppNo;
  String? subTitle;
  String? profileImageUrl;
  String? address;
  String? latLng;
  String? aboutUs;
  String? fdmId;
  String? deptId;
  String? hName;
  String? id;
  String? lunchOpeningTime;
  String? lunchClosingTime;
  String? closingDate;
  String? opt;
  String? clt;
  String? dayCode;
  String? serviceTime;
  String? stopBooking;
  String? fee;
  var videoConsultationFee;
  String? deptName;
  String? clinicName;
  String? clinicId;
  String? log;
  String? lat;
  var payLater;
  var payNow;
  var active;
  var vspd;
  var walkin_active;
  var video_active;
  var wspd;
  var wspdp;
  String? emergencyCallEnable;
  String? emergencyCallCharges;

  DrProfileModel({
    this.firstName,
    this.lastName,
    this.email,
    this.pNo1,
    this.pNo2,
    this.description,
    this.whatsAppNo,
    this.subTitle,
    this.profileImageUrl,
    this.address,
    this.latLng,
    this.aboutUs,
    this.fdmId,
    this.deptId,
    this.hName,
    this.id,
    this.lunchOpeningTime,
    this.lunchClosingTime,
    this.closingDate,
    this.dayCode,
    this.clt,
    this.opt,
    this.serviceTime,
    this.stopBooking,
    this.fee,
    this.videoConsultationFee,
    this.deptName,
    this.clinicName,
    this.clinicId,
    this.lat,
    this.log,
    this.vspd,
    this.walkin_active,
    this.video_active,
    this.active,
    this.payLater,
    this.payNow,
    this.wspd,
    this.wspdp,
    this.emergencyCallEnable,
    this.emergencyCallCharges,
  });

  factory DrProfileModel.fromJson(Map<String,dynamic> json){
    return DrProfileModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      pNo1: json['pNo1'],
      pNo2: json['pNo2'],
      email: json['email'],
      subTitle: json['subTitle'],
      description: json['description'],
      whatsAppNo: json['whatsAppNo'],
      profileImageUrl: json['profileImageUrl'],
      address: json['address'],
      latLng: json['lat_lng'],
      aboutUs: json['aboutUs'],
      fdmId: json['fcmId'],
      deptId: json['deptId'],
      hName: json['hName'],
      id: json['id'].toString(),
      lunchClosingTime: json["lct"],
      lunchOpeningTime: json['lot'],
      closingDate: json['closingDate'],
      opt: json["opt"],
      clt: json['clt'],
      dayCode: json['dayCode'],
      serviceTime:json['timeInt'],
      stopBooking: json['stopBooking'],
      fee: json['fee'],
      videoConsultationFee: json['video_consultation_fee'].toString(),
      deptName:json['name'],
      clinicId: json['clinic_id'].toString(),
      clinicName: json['location_name'],
      lat: json['latitude']??"0.0",
      log: json['longitude']??"0.0",
      payLater: json['pay_later'],
      payNow: json['pay_now'],
      active: json['active'],
      video_active: json['video_active'],
      vspd: json['vspd'],
      wspd: json['wspd'],
      wspdp: json['wspdp'],
      walkin_active: json['walkin_active'],
      emergencyCallEnable: json['emergency_call_enable'].toString(),
      emergencyCallCharges: json['emergency_call_charges'].toString(),

    );
  }

}

class DrProfileModelLocation{
  String? firstName;
  String? lastName;
  String? email;
  String? pNo1;
  String? pNo2;
  String? description;
  String? whatsAppNo;
  String? subTitle;
  String? profileImageUrl;
  String? address;
  String? latLng;
  String? aboutUs;
  String? fdmId;
  String? deptId;
  String? hName;
  String? id;
  String? lunchOpeningTime;
  String? lunchClosingTime;
  String? closingDate;
  String? opt;
  String? clt;
  String? dayCode;
  String? serviceTime;
  String? stopBooking;
  String? fee;
  var videoConsultationFee;
  String? deptName;
  String? clinicName;
  String? clinicId;
  String? log;
  String? lat;
  String? cityId;
  String? cityName;
  var payLater;
  var payNow;
  var active;
  var vspd;
  var walkin_active;
  var video_active;
  var wspd;
  var wspdp;
  String? emergencyCallEnable;
  String? emergencyCallCharges;

  DrProfileModelLocation({
    this.firstName,
    this.lastName,
    this.email,
    this.pNo1,
    this.pNo2,
    this.description,
    this.whatsAppNo,
    this.subTitle,
    this.profileImageUrl,
    this.address,
    this.latLng,
    this.aboutUs,
    this.fdmId,
    this.deptId,
    this.hName,
    this.id,
    this.lunchOpeningTime,
    this.lunchClosingTime,
    this.closingDate,
    this.dayCode,
    this.clt,
    this.opt,
    this.serviceTime,
    this.stopBooking,
    this.fee,
    this.videoConsultationFee,
    this.deptName,
    this.clinicName,
    this.clinicId,
    this.lat,
    this.log,
    this.cityName,
    this.cityId,
    this.vspd,
    this.walkin_active,
    this.video_active,
    this.active,
    this.payLater,
    this.payNow,
    this.wspd,
    this.wspdp,
    this.emergencyCallEnable,
    this.emergencyCallCharges,
  });

  factory DrProfileModelLocation.fromJson(Map<String,dynamic> json){
    return DrProfileModelLocation(
      firstName: json['firstName'],
      lastName: json['lastName'],
      pNo1: json['pNo1'],
      pNo2: json['pNo2'],
      email: json['email'],
      subTitle: json['subTitle'],
      description: json['description'],
      whatsAppNo: json['whatsAppNo'],
      profileImageUrl: json['profileImageUrl'],
      address: json['address'],
      latLng: json['lat_lng'],
      aboutUs: json['aboutUs'],
      fdmId: json['fcmId'],
      deptId: json['deptId'],
      hName: json['hName'],
      id: json['id'].toString(),
      lunchClosingTime: json["lct"],
      lunchOpeningTime: json['lot'],
      closingDate: json['closingDate'],
      opt: json["opt"],
      clt: json['clt'],
      dayCode: json['dayCode'],
      serviceTime:json['timeInt'],
      stopBooking: json['stopBooking'],
      fee: json['fee'],
      videoConsultationFee: json['video_consultation_fee'].toString(),
      deptName:json['name'],
      clinicId: json['clinic_id'].toString(),
      clinicName: json['location_name'],
      lat: json['latitude']??"0.0",
      log: json['longitude']??"0.0",
      cityName: json['cityName'] ,
      cityId: json['city_id'].toString(),
      payLater: json['pay_later'],
      payNow: json['pay_now'],
      active: json['active'],
      video_active: json['video_active'],
      vspd: json['vspd'],
      walkin_active: json['walkin_active'],
      wspd: json['wspd'],
      wspdp: json['wspdp'],
      emergencyCallEnable: json['emergency_call_enable'].toString(),
      emergencyCallCharges: json['emergency_call_charges'].toString(),
    );
  }

}
