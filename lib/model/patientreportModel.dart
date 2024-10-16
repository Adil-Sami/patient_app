
class PrescriptionsModel {
  String? labTestId;
  // String? prescription;
  // String? patientName; //fcm id
  // String? appointmentId;
  // String? appointmentTime;
  // String? appointmentDate;
  // String? appointmentName;
  // String? drName;
  String? imageUrl;

  PrescriptionsModel({
    this.labTestId,
    // this.appointmentTime,
    // this.appointmentDate,
    // this.appointmentId,
    // this.appointmentName,
    // this.patientName,
    // this.prescription,
    this.imageUrl,
    // this.drName

  });

  factory PrescriptionsModel.fromJson(Map<String,dynamic> json){
    return PrescriptionsModel(
        // appointmentTime: json['appointmentTime'],
        labTestId: json['labTestId'],
        // appointmentDate: json['appointmentDate'],
        // appointmentId: json['appointmentId'],
        // appointmentName: json['appointmentName'],
        // prescription: json['prescription'],
        // patientName: json['patientName'],
        imageUrl: json['imageUrl'],
        // drName: json['drName']

    );
  }
  Map<String,dynamic> toJsonUpdate(){
    return {
      // "prescription":this.prescription,
      "labTestId":this.labTestId,
      // "drName":this.drName,
      // "patientName":this.patientName,
      "imageUrl":this.imageUrl
    };

  }
  Map<String,dynamic> toJsonAdd(){
    return {
      "labTestId":this.labTestId,
      // "patientId":this.patientId,
      // "appointmentTime":this.appointmentTime,
      // "appointmentDate":this.appointmentDate,
      "imageUrl":this.imageUrl,
      // "appointmentName":this.appointmentName,
      // "drName":this.drName,
      // "patientName":this.patientName,
      // "prescription":this.prescription,
    };
  }

}