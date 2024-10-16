import 'package:az_ui/helper/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Module/Doctor/Provider/DoctorProvider.dart';
import '../Module/Doctor/Screen/AppointmentConfirmationScreen.dart';
import '../Screen/appointment/appointment.dart';
import '../Screen/chooseDoctorsPage.dart';
import '../utilities/color.dart';
import '../utilities/style.dart';
import 'notify.dart';

bookAnAppointment(context){
  return Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 12.0, bottom: 12.0), // top bottom old value is 8 + left right old value is 20 + hassan005004
      child: Container(
          height: 45, // old value is 35 + hassan005004
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: btnColor,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: InkWell(
            onTap:(){
              showModalBottomSheet(
                context: context,
                isDismissible: true,
                enableDrag: true,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)
                  ),
                ),
                builder: (context){
                  return Container(
                      child: Consumer<DoctorProvider>(
                        builder: (context, provider, _) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Choose Anyone').azText().fs(20).bold(),
                                Table(
                                  children: [
                                    TableRow(
                                      children: [
                                        cardImgNew(context, "assets/icon/clinic-visit.png", "Book a Clinic Visit".tr, onTap: (){
                                          Get.back();
                                          Get.to(AppointmentPage(
                                              doctId: provider.doctor!.id,
                                              deptName: provider.doctor!.deptName,
                                              hospitalName: provider.doctor!.hName,
                                              doctName: provider.doctor!.firstName.toString() + " " + provider.doctor!.lastName.toString(),
                                              stopBooking: provider.doctor!.stopBooking,
                                              fee: provider.doctor!.fee,
                                              clinicId: provider.doctor!.clinicId,
                                              cityId: 1,
                                              deptId: provider.doctor!.deptId,
                                              cityName: 'city',
                                              clinicName: provider.doctor!.clinicName,
                                              payLaterActive: provider.doctor!.payLater,
                                              payNowActive: provider.doctor!.payNow,
                                              videoActive: provider.doctor!.video_active,
                                              walkinActive: provider.doctor!.walkin_active,
                                              vspd: provider.doctor!.vspd,
                                              wspd: provider.doctor!.wspdp,
                                              appointmentType: 1
                                          ));
                                        }),
                                        cardImgNew(context, "assets/icon/video-consultation.png", "Video Consultation".tr, onTap: (){
                                          Get.back();
                                          Get.to(AppointmentPage(
                                              doctId: provider.doctor!.id,
                                              deptName: provider.doctor!.deptName,
                                              hospitalName: provider.doctor!.hName,
                                              doctName: provider.doctor!.firstName.toString() + " " + provider.doctor!.lastName.toString(),
                                              stopBooking: provider.doctor!.stopBooking,
                                              fee: provider.doctor!.videoConsultationFee,
                                              clinicId: provider.doctor!.clinicId,
                                              cityId: 1,
                                              deptId: provider.doctor!.deptId,
                                              cityName: 'city',
                                              clinicName: provider.doctor!.clinicName,
                                              payLaterActive: provider.doctor!.payLater,
                                              payNowActive: provider.doctor!.payNow,
                                              videoActive: provider.doctor!.video_active,
                                              walkinActive: provider.doctor!.walkin_active,
                                              vspd: provider.doctor!.vspd,
                                              wspd: provider.doctor!.wspdp,
                                              appointmentType: 0
                                          ));
                                        }),
                                        cardImgNew(context, "assets/icon/emergency.png", "Emergency Call".tr, onTap: (){
                                          // Get.back();
                                          if(provider.doctor?.emergencyCallEnable.toString() == "0"){
                                            errorNotify("Emergence call not available at the moment");
                                            return;
                                          }

                                          print(provider.doctor!.subTitle);
                                          dynamic amount = provider.doctor!.emergencyCallCharges;
                                          if(amount == null || amount == 'null'){
                                            amount = '0';
                                          }
                                          Get.to(AppointmentConfirmationScreen(type: 3, serviceName: "Emergency Call", amount: double.parse(amount)));

                                          Get.to(AppointmentPage(
                                              doctId: provider.doctor!.id,
                                              deptName: provider.doctor!.deptName,
                                              hospitalName: provider.doctor!.hName,
                                              doctName: provider.doctor!.firstName.toString() + " " + provider.doctor!.lastName.toString(),
                                              stopBooking: provider.doctor!.stopBooking,
                                              fee: provider.doctor!.emergencyCallCharges,
                                              clinicId: provider.doctor!.clinicId,
                                              cityId: 1,
                                              deptId: provider.doctor!.deptId,
                                              cityName: 'city',
                                              clinicName: provider.doctor!.clinicName,
                                              payLaterActive: provider.doctor!.payLater,
                                              payNowActive: provider.doctor!.payNow,
                                              videoActive: provider.doctor!.video_active,
                                              walkinActive: provider.doctor!.walkin_active,
                                              vspd: provider.doctor!.vspd,
                                              wspd: provider.doctor!.wspdp,
                                              appointmentType: 2
                                          ));
                                        }),
                                      ]
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }
                      )
                  );
                },
              );
              /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChooseDoctorsPage(
                      cityName: 'city',
                      cityId: '1',
                      clinicLocationName: 'location',
                      clinicId: '1',
                      clinicName: 'clinic',
                      deptId: '1',
                      deptName: 'department',
                    ),
                  )
              );*/
            },
            child: Center(
              child: Text("Book an appointment".tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
      ),
    ),
  );
}



Widget cardImgNew(context, String path, String title, {Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: MediaQuery.of(context).size.height * .15,
      //width: MediaQuery.of(context).size.width * .1,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0.0, // elevation old vale is 5 + hassan005004
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 45,
              width: 45,
              child: Image.asset(path),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: kTitleStyle,
              ),
            )
          ],
        ),
      ),
    ),
  );
}


Widget appointmentDate(date) {
  var appointmentDate = date.split("-");
  var appointmentMonth;
  switch (appointmentDate[1]) {
    case "01":
      appointmentMonth = "JAN";
      break;
    case "02":
      appointmentMonth = "FEB";
      break;
    case "03":
      appointmentMonth = "MARCH";
      break;
    case "04":
      appointmentMonth = "APRIL";
      break;
    case "05":
      appointmentMonth = "MAY";
      break;
    case "06":
      appointmentMonth = "JUN";
      break;
    case "07":
      appointmentMonth = "JULY";
      break;
    case "08":
      appointmentMonth = "AUG";
      break;
    case "09":
      appointmentMonth = "SEP";
      break;
    case "10":
      appointmentMonth = "OCT";
      break;
    case "11":
      appointmentMonth = "NOV";
      break;
    case "12":
      appointmentMonth = "DEC";
      break;
    default:
      appointmentMonth = appointmentDate[1];
  }

  return Column(
    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Text(appointmentMonth,
          style: const TextStyle(
            fontFamily: 'OpenSans-SemiBold',
            fontSize: 12,
          )),
      Text(appointmentDate[1],
          style: TextStyle(
            fontFamily: 'OpenSans-SemiBold',
            color: btnColor,
            fontSize: 25,
          )),
      Text(appointmentDate[0],
          style: const TextStyle(
            fontFamily: 'OpenSans-SemiBold',
            fontSize: 12,
          )),
    ],
  );
}
