import 'package:demopatient/Screen/CustomUI/picture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'dart:convert';
import 'dart:io';
import 'package:demopatient/Screen/CustomUI/picture.dart';
import 'package:demopatient/config.dart';
import 'package:demopatient/model/notificationModel.dart';
import 'package:dio/dio.dart' as dios;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as Path;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../Service/Apiservice/chatapi.dart';
import '../../Service/Firebase/updateData.dart';
import '../../Service/Noftification/handleFirebaseNotification.dart';
import '../../Service/notificationService.dart';
import '../../Service/prescriptionService.dart';
import '../../Service/userService.dart';
import '../../model/appointmentModel.dart';
import '../../model/patientreportModel.dart';
import '../../model/prescriptionModel.dart';
import '../../utilities/color.dart';
import '../../utilities/inputfields.dart';
import '../../utilities/toastMsg.dart';


import '../../utilities/color.dart';
class LabDetail extends StatefulWidget {
  final prescriptionDetails;
  dynamic appointmentDetails;

  LabDetail(this.appointmentDetails,{Key? key, required this.prescriptionDetails}) : super(key: key);

  @override
  State<LabDetail> createState() => _LabDetailState();
}

class _LabDetailState extends State<LabDetail> {
  TextEditingController _messageController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  bool _isUploading = false;

  bool _isEnableBtn = true;

  File? _file;

  List _imageUrls = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // centerTitle: true,
        title: Text(widget.prescriptionDetails.labName,
            style: TextStyle(
              fontFamily: 'OpenSans-Bold',
              fontSize: 14.0,
            )),
        backgroundColor: appBarColor,
        automaticallyImplyLeading: true,
        actions: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: IconButton(onPressed: (){
          //
          //     Get.back();
          //   }, icon: Icon(Icons.close,color: Colors.white,size: 30,)),
          // )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(widget.prescriptionDetails.labTestAttachments.length == 0)
              Container(
                  margin: EdgeInsets.all(10),
                  child: Text('No Report uploaded by patient',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                      )
                  )
              ),

            for(int i=0;i<widget.prescriptionDetails.labTestAttachments.length;i++)
              InkWell(
                onTap: (){
                  Get.to(Picture(widget.prescriptionDetails.labTestAttachments[i].attachment));
                  // PinchZoom(
                  //   child: Image.network(prescriptionDetails.labTestAttachments[i].attachment),
                  //   resetDuration: const Duration(milliseconds: 100),
                  //   maxScale: 3,
                  //   onZoomStart: (){print('Start zooming');},
                  //   onZoomEnd: (){print('Stop zooming');},
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      child: Container(
                        width: 400.0,
                        height: 300.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9.0),
                            border: Border.all(color: Color(0xffdcf8c6),width: 4),
                            image: DecorationImage(
                                image: NetworkImage(
                                  widget.prescriptionDetails.labTestAttachments[i].attachment,
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                ),
              )
            // PinchZoom(
            //   child: Image.network(prescriptionDetails.labTestAttachments.toList()[1].attachment),
            //   resetDuration: const Duration(milliseconds: 100),
            //   maxScale: 3,
            //   onZoomStart: (){print('Start zooming');},
            //   onZoomEnd: (){print('Stop zooming');},
            // ),
          ],

        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appBarColor,
        onPressed: () async {

          ProgressDialog pd = ProgressDialog(context: context);

          await _handleFilePicker(pd);
          Get.back();
          // Bottomsheet(context);
        },
        child: Icon(Icons.image,),
      ),
    );
  }

  _buildImageList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: _imageUrls.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
                child: Row(
                  children: [
                    Flexible(
                        child: Text(
                          _imageUrls[index]['fileName'],
                        )),
                    Flexible(
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              print('mnoorjdjjd');
                              setState(() {
                                _imageUrls.removeAt(index);
                              });
                            });
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.redAccent,
                          )),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
  _handleFilePicker(pd) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final fileSize = result.files[0].size * 0.000001;
      if (fileSize > 20) {
        result = null;
        ToastMsg.showToastMsg("File size must be less then 20MB");
      } else {
        File? file = File(result.files.single.path ?? "");
        setState(() {
          _file = file;
          //_filePath = result!.files.single.path??"";
        });
        print('file picker');
        // print(_filePath);
        _handleUpload(result.files[0].name, _file,
            // widget.prescriptionDetails.id,
            pd);
        print('file picker bottom');
      }
    } else {
      // User canceled the picker
    }
  }

  _handleUpload(fileName, filePath,
      // lab_test_id,
      pd,) async {
    setState(() {
      _isUploading = true;
    });
    pd.show(
      max: 100,
      msg: 'File Uploading...',
      progressType: ProgressType.valuable,
    );
    final fileName = Path.basename(filePath.path);
    print("****************File Base Name: $fileName");
    try {

      dios.FormData formData = dios.FormData.fromMap({
        'lab_test_id': widget.prescriptionDetails.id.toString(),
        "picture": await dios.MultipartFile.fromFile(filePath.path,
            filename: fileName),

      });
      print("start uploading");

      final res = await dios.Dio().post(
        "$postlab",
        data: formData,
        onSendProgress: (int sent, int total) {
          int progress = (((sent / total) * 100).toInt());
          pd.update(value: progress);
        },
      );
      print(123);
      print(res.toString());
      print('uploading start');

      if(res.toString() == 'success'){
        ToastMsg.showToastMsg("Uploading Success");
        if (res.toString() == "success") {
          ToastMsg.showToastMsg("Successfully Added");
          await _sendNotification();
          Navigator.of(this.context).pushNamedAndRemoveUntil(
              '/AppointmentListPage', ModalRoute.withName('/HomePage'));
        } else
          ToastMsg.showToastMsg("Something went wrong");
        //
        //   // print(body["fileName"]);
        // _imageUrls.add({"fileName": fileName,"url": "$fileUrl/${body["fileName"]}"});
        //   setState(() {
        //     _isUploading = false;
        //   });
        //
        //   // await _handleSendFileMsg(body["fileName"], body["message"], pd);
      } else {
        ToastMsg.showToastMsg("Uploading Error, try again");
      }
    } catch (e) {
      ToastMsg.showToastMsg("Uploading Error, try again");

      print("Error on uploading: $e");
      setState(() {
        _isUploading = false;
      });
    } finally {
      pd.close();
    }
  }


  _handleUpdate() async {
    setState(() {
      _isUploading = true;
      _isEnableBtn = false;
    });
    // if (_listImages.length == 0) {
    String imageUrl = "";
    if (_imageUrls.length != 0) {
      for (var e in _imageUrls) {
        if (imageUrl == "") {
          imageUrl = e['url'];
        } else {
          imageUrl = imageUrl + "," + e['url'];
        }
      }
    }
    print(imageUrl);

    String formattedDate = DateFormat.Hms().format(DateTime.now());

    // PrescriptionsModel prescriptionsModel = PrescriptionsModel(
    //   labTestId:widget.prescriptionDetails.id.toString(),
    //     // appointmentId: widget.appointmentDetails.id,
    //     // patientId: widget.appointmentDetails.uId,
    //     // appointmentTime: formattedDate,
    //     // appointmentDate: DateTime.now().toString(),
    //     // appointmentName: widget.appointmentDetails.serviceName,
    //     // drName: widget.appointmentDetails.doctName,
    //     // patientName: widget.appointmentDetails.pFirstName,
    //     // imageUrl: imageUrl,
    //     imageUrl: imageUrl,
    //     // prescription: _messageController.text);
    // );
    // final res = await PrescriptionService.addData(prescriptionsModel);


    setState(() {
      _isUploading = false;
      _isEnableBtn = true;
    });
  }


  _sendNotification() async {
    String title = "Prescription Added";
    String body =
        "New Prescription has been added for ${widget.appointmentDetails!.serviceName} please check it";
    final notificationModel = NotificationModel(
        title: title,
        body: body,
        uId: widget.appointmentDetails!.uId,
        routeTo: "/LoginPage",
        sendBy: "patient",
        sendFrom: "Patient",
        sendTo: "Doctor");
    final msgAdded = await NotificationService.addData(notificationModel);
    if (msgAdded == "success") {
      final res = await UserService.getUserById(
          widget.appointmentDetails!.uId); //get fcm id of specific user

      HandleFirebaseNotification.sendPushMessage(res[0].fcmId.toString(), title, body);
      await UpdateData.updateIsAnyNotification(
          "usersList", widget.appointmentDetails!.uId, true);

    }
  }
}

//
// class LabDetails extends StatefulWidget {
//   final prescriptionDetails;
//   dynamic appointmentDetails;
//
//
//   LabDetails(this.appointmentDetails, {Key? key, required this.prescriptionDetails}) : super(key: key);
//
//   @override
//   State<LabDetail> createState() => _LabDetailState();
// }
//
// class _LabDetailsState extends State<LabDetails> {
//   TextEditingController _messageController = TextEditingController();
//   ScrollController _scrollController = ScrollController();
//   bool _isUploading = false;
//   bool _isEnableBtn = true;
//   File? _file;
//   List _imageUrls = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(widget.prescriptionDetails.labName,
//             style: TextStyle(
//               fontFamily: 'OpenSans-Bold',
//               fontSize: 14.0,
//             )),
//         backgroundColor: appBarColor,
//         automaticallyImplyLeading: true,
//         actions: [
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             for(int i=0;i<widget.prescriptionDetails.labTestAttachments.length;i++)
//               InkWell(
//                 onTap: (){
//
//                   Get.to(Picture(widget.prescriptionDetails.labTestAttachments[i].attachment));
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 2.0,right: 2,top: 3,bottom: 20),
//                   child: Center(
//                     child: Container(
//                       child: Container(
//                         width: 400.0,
//                         height: 300.0,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(9.0),
//                             border: Border.all(color: Color(0xffdcf8c6),width: 4),
//                             image: DecorationImage(
//                                 image: NetworkImage(
//                                   widget.prescriptionDetails.labTestAttachments[i].attachment,
//                                 ),
//
//                                 fit: BoxFit.cover)),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: appBarColor,
//         onPressed: () async {
//
//           ProgressDialog pd = ProgressDialog(context: context);
//           await _handleFilePicker(pd);
//           Get.back();
//           // Bottomsheet(context);
//         },
//         child: Icon(Icons.image,),
//       ),
//     );
//   }
//
//   // Future Bottomsheet(context) {
//   //    ProgressDialog pd = ProgressDialog(context: context);
//   //   return showModalBottomSheet(
//   //       backgroundColor: Colors.transparent,
//   //       context: context,
//   //       builder: (builder) => Container(
//   //         // height: 1000,
//   //         height: 600,
//   //         width: MediaQuery.of(context).size.width,
//   //         child: Card(
//   //           margin: const EdgeInsets.all(18.0),
//   //           shape: RoundedRectangleBorder(
//   //               borderRadius: BorderRadius.circular(15)),
//   //           child: Padding(
//   //             padding:
//   //             const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//   //             child: Column(
//   //               children: [
//   //                 // InputFields.commonInputField(
//   //                 //     _messageController, "Message", (item) {
//   //                 //   return item.length > 0 ? null : "Enter message ";
//   //                 // }, TextInputType.text, 3),
//   //                 _imageUrls.length == 0
//   //                     ? Container()
//   //                     : Padding(
//   //                   padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
//   //                   child: Text(
//   //                     "Attached Files",
//   //                     style: TextStyle(
//   //                         fontFamily: "OpenSans-SemiBold",
//   //                         fontSize: 14),
//   //                   ),
//   //                 ),
//   //                 _buildImageList(),
//   //                 Spacer(),
//   //                 Padding(
//   //                   padding: const EdgeInsets.only(left: 250),
//   //                   child: IconButton(
//   //                       icon: Icon(Icons.file_copy),
//   //                       onPressed: () async {
//   //                         print('user id ');
//   //                         print(widget.prescriptionDetails.id);
//   //                         await _handleFilePicker(pd);
//   //                       }),
//   //                 ),
//   //                 Container(
//   //                   width: MediaQuery.of(context).size.width,
//   //                   child: ElevatedButton(
//   //                       onPressed: () async {
//   //                         print("hassan");
//   //                         // print(widget.appointmentDetails.id);
//   //
//   //                         _handleUpdate();
//   //                         print('list data from precrption');
//   //                         print(1234);
//   //
//   //                         // final login = await ChatApi().PatinetSendMessage(
//   //                         //     widget.appointmentDetails!.id.toString(),
//   //                         //     widget.appointmentDetails!.uId.toString(),
//   //                         //     widget.appointmentDetails!.doctId.toString(),
//   //                         //     2,
//   //                         //     6,
//   //                         //     _messageController.text,
//   //                         //     '');
//   //
//   //                         print('send');
//   //                       },
//   //                       child: Text(
//   //                         'Send',
//   //                         style: TextStyle(
//   //                             fontFamily: "OpenSans-SemiBold",
//   //                             fontSize: 14),
//   //                       )),
//   //                 )
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ));
//   // }
//
//   _buildImageList() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ListView.builder(
//           padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
//           shrinkWrap: true,
//           controller: _scrollController,
//           itemCount: _imageUrls.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 10.0),
//               child: GestureDetector(
//                 child: Row(
//                   children: [
//                     Flexible(
//                         child: Text(
//                           _imageUrls[index]['fileName'],
//                         )),
//                     Flexible(
//                       child: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               print('mnoorjdjjd');
//                               setState(() {
//                                 _imageUrls.removeAt(index);
//                               });
//                             });
//                           },
//                           icon: Icon(
//                             Icons.close,
//                             color: Colors.redAccent,
//                           )),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }),
//     );
//   }
//   _handleFilePicker(pd) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null) {
//       final fileSize = result.files[0].size * 0.000001;
//       if (fileSize > 20) {
//         result = null;
//         ToastMsg.showToastMsg("File size must be less then 20MB");
//       } else {
//         File? file = File(result.files.single.path ?? "");
//         setState(() {
//           _file = file;
//           //_filePath = result!.files.single.path??"";
//         });
//         print('file picker');
//         // print(_filePath);
//         _handleUpload(result.files[0].name, _file,
//             // widget.prescriptionDetails.id,
//             pd);
//         print('file picker bottom');
//       }
//     } else {
//       // User canceled the picker
//     }
//   }
//   _handleUpload(fileName, filePath,
//       // lab_test_id,
//       pd,) async {
//     setState(() {
//       _isUploading = true;
//     });
//     pd.show(
//       max: 100,
//       msg: 'File Uploading...',
//       progressType: ProgressType.valuable,
//     );
//     final fileName = Path.basename(filePath.path);
//     print("****************File Base Name: $fileName");
//     try {
//
//       dios.FormData formData = dios.FormData.fromMap({
//         'lab_test_id': widget.prescriptionDetails.id.toString(),
//         "picture": await dios.MultipartFile.fromFile(filePath.path,
//             filename: fileName),
//
//       });
//       print("start uploading");
//
//       final res = await dios.Dio().post(
//         "$postlab",
//         data: formData,
//         onSendProgress: (int sent, int total) {
//           int progress = (((sent / total) * 100).toInt());
//           pd.update(value: progress);
//         },
//       );
//       print(123);
//       print(res.toString());
//       print('uploading start');
//
//       if(res.toString() == 'success'){
//         ToastMsg.showToastMsg("Uploading Success");
//         if (res.toString() == "success") {
//           ToastMsg.showToastMsg("Successfully Added");
//           await _sendNotification();
//           Navigator.of(this.context).pushNamedAndRemoveUntil(
//               '/AppointmentListPage', ModalRoute.withName('/HomePage'));
//         } else
//           ToastMsg.showToastMsg("Something went wrong");
//         //
//         //   // print(body["fileName"]);
//         // _imageUrls.add({"fileName": fileName,"url": "$fileUrl/${body["fileName"]}"});
//         //   setState(() {
//         //     _isUploading = false;
//         //   });
//         //
//         //   // await _handleSendFileMsg(body["fileName"], body["message"], pd);
//       } else {
//         ToastMsg.showToastMsg("Uploading Error, try again");
//       }
//     } catch (e) {
//       ToastMsg.showToastMsg("Uploading Error, try again");
//       print("Error on uploading: $e");
//       setState(() {
//         _isUploading = false;
//       });
//     } finally {
//       pd.close();
//     }
//   }
//   _handleUpdate() async {
//     setState(() {
//       _isUploading = true;
//       _isEnableBtn = false;
//     });
//     // if (_listImages.length == 0) {
//     String imageUrl = "";
//     if (_imageUrls.length != 0) {
//       for (var e in _imageUrls) {
//         if (imageUrl == "") {
//           imageUrl = e['url'];
//         } else {
//           imageUrl = imageUrl + "," + e['url'];
//         }
//       }
//     }
//     print(imageUrl);
//
//     String formattedDate = DateFormat.Hms().format(DateTime.now());
//
//     // PrescriptionsModel prescriptionsModel = PrescriptionsModel(
//     //   labTestId:widget.prescriptionDetails.id.toString(),
//     //     // appointmentId: widget.appointmentDetails.id,
//     //     // patientId: widget.appointmentDetails.uId,
//     //     // appointmentTime: formattedDate,
//     //     // appointmentDate: DateTime.now().toString(),
//     //     // appointmentName: widget.appointmentDetails.serviceName,
//     //     // drName: widget.appointmentDetails.doctName,
//     //     // patientName: widget.appointmentDetails.pFirstName,
//     //     // imageUrl: imageUrl,
//     //     imageUrl: imageUrl,
//     //     // prescription: _messageController.text);
//     // );
//     // final res = await PrescriptionService.addData(prescriptionsModel);
//
//
//     setState(() {
//       _isUploading = false;
//       _isEnableBtn = true;
//     });
//   }
//   _sendNotification() async {
//     String title = "Prescription Added";
//     String body =
//         "New Prescription has been added for ${widget.appointmentDetails!.serviceName} please check it";
//     final notificationModel = NotificationModel(
//         title: title,
//         body: body,
//         uId: widget.appointmentDetails!.uId,
//         routeTo: "/PrescriptionListPage",
//         sendBy: "patient",
//         sendFrom: "Patient",
//         sendTo: widget.appointmentDetails!.pFirstName);
//     final msgAdded = await NotificationService.addData(notificationModel);
//     if (msgAdded == "success") {
//       final res = await UserService.getUserById(
//           widget.appointmentDetails!.uId); //get fcm id of specific user
//
//       HandleFirebaseNotification.sendPushMessage(res[0].fcmId.toString(), title, body);
//       await UpdateData.updateIsAnyNotification(
//           "usersList", widget.appointmentDetails!.uId, true);
//     }
//   }
// }

