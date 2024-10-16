
import 'package:demopatient/Screen/CustomUI/picture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_filex/open_filex.dart';
import '../../Service/Model/ChatModel.dart';
import '../appointment/ChatScreen.dart';


class OwnMessageCard extends StatefulWidget {
  ChatClass? data;
  String? widget;
  OwnMessageCard({Key? key, this.data, this.widget}) : super(key: key);

  @override
  State<OwnMessageCard> createState() => _OwnMessageCardState();
}

class _OwnMessageCardState extends State<OwnMessageCard> {

  _launchURL() async {
    var url = widget.data!.message;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  var _openResult = 'Unknown';

  Future<void> openFile() async {
    var filePath = widget.data!.message;
    final result = await OpenFilex.open(filePath);

    setState(() {
      _openResult = "type=${result.type}  message=${result.message}";
    });
  }

  @override
  Widget build(BuildContext context) {

    DateTime? timestamp = widget.data!.createdAt;
    return Align(
      alignment: widget.data!.sender.toString() == "1" ? Alignment.centerRight :  Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 55,
          minWidth: 150,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: widget.data!.sender.toString() == "1" ? Color(0xffdcf8c6) : Color(0xFFFFFFFF),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              if (widget.data!.type.toString() == "1")
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 30,
                    top: 5,
                    bottom: 20,
                  ),
                  child: Text(
                    widget.data!.message.toString(),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              else if (widget.data!.type.toString() == "6")
                InkWell(
                  onTap: (){
                    // _launchURL();
                    AppointmentChatModal.prescriptionModal(context, widget.widget);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 1,
                      // right: 30,
                      top: 1,
                      bottom: 1,
                    ),
                    child:Container(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Container(
                        width: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(9.0),
                          border: Border.all(color: Color(0xffdcf8c6),width: 4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.file_copy_outlined,color: Colors.red,),
                              SizedBox(width: 10,),
                              Text('View Prescription',style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),),

                            ],
                          ),

                        ) ,
                      ),
                    ),
                  ),
                )
              else if (widget.data!.type.toString() == "7")
                InkWell(
                  onTap: (){
                    print(123);
                    print(widget.data!.id);

                    // _launchURL();
                    AppointmentChatModal.labModal(context, widget.data!.appointmentId,widget);

                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 1,
                      // right: 30,
                      top: 1,
                      bottom: 1,
                    ),
                    child:Container(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Container(
                        width: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(9.0),
                          border: Border.all(color: Color(0xffdcf8c6),width: 4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.file_copy_outlined,color: Colors.red,),
                              SizedBox(width: 10,),
                              Text('Lab Test',style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),),
                            ],
                          ),
                        ) ,
                      ),
                    ),
                  ),
                )
              else if (widget.data!.type.toString() == "2")
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 30,
                    top: 5,
                    bottom: 20,
                  ),
                  child: Text(
                    widget.data!.message,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              else if (widget.data!.type.toString() == "3")
                InkWell(
                  onTap: (){
                    _launchURL();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 1,
                      // right: 30,
                      top: 1,
                      bottom: 1,
                    ),
                    child:Container(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Container(
                        width: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(9.0),
                          border: Border.all(color: Color(0xffdcf8c6),width: 4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.file_copy_outlined,color: Colors.red,),
                              SizedBox(width: 10,),
                              Text('Download File',style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),),
                            ],
                          ),
                        ) ,
                      ),
                    ),
                  ),
                )
              else if (widget.data!.type.toString() == "4")

                InkWell(
                  onTap: (){
                    Get.to(Picture(widget.data!.message.toString()));

                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Container(
                      width: 400.0,
                      height: 300.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9.0),
                          border: Border.all(color: Color(0xffdcf8c6),width: 4),
                          image: DecorationImage(
                              image: NetworkImage(
                                widget.data!.message.toString(),
                              ),

                              fit: BoxFit.cover)),
                    ),
                  ),
                )
              else
                Center(),

              Positioned(
                // top: 20,
                bottom: 0,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      DateFormat('hh:mm a').format(timestamp!),
                      // widget.data!.createdAt.toString(),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],

                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    // Icon(
                    //   Icons.done_all,
                    //   color: Colors.grey[600],
                    //   size: 20,
                    // ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

