import 'package:demopatient/Screen/wallet_page.dart';
import 'package:demopatient/Service/Firebase/readData.dart';
import 'package:demopatient/controller/get_user_controller.dart';
import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HAppBarWidget extends StatelessWidget {
  final String? uId;
  final String? title;

  final GetUserController? getUserController;
  HAppBarWidget({this.title, this.uId,this.getUserController});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(left: 0.0),
        child: Text(
          title ?? "",
          style: kAppbarTitleStyle,
        ),
      ),
      backgroundColor: appBarColor,
      actions: <Widget>[
        Padding(
            padding: const EdgeInsets.only(right: 0.0, bottom: 5.0),
            child: StreamBuilder(
                stream: ReadData.fetchNotificationDotStatus(uId!),
                builder: (context, AsyncSnapshot snapshot) {
                  return !snapshot.hasData
                      ? Container()
                      : IconButton(
                          icon: Stack(
                            children: [
                              Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                              snapshot.data["isAnyNotification"]
                                  ? Positioned(
                                      top: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 5,
                                      ),
                                    )
                                  : Positioned(
                                      top: 0, right: 0, child: Container())
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              "/NotificationPage",
                            );
                          }
                          //

                          );
                })),
        Stack(
          children: [
            IconButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WalletPage(getUserController: getUserController)),
              );
            }, icon:  Icon(Icons.account_balance_wallet)),
            Positioned(
                top: 5,
                right: 0,
                child: Card(
                    color: Colors.red,
                    child:    getUserController==null?
                    Text("\u{20B9}",style: TextStyle(
                        fontSize: 10,
                        color: Colors.white
                    ))
                        : Obx(() {
                      if (!getUserController!.isError.value) { // if no any error
                        if (getUserController!.isLoading.value) {
                          return const    Text("\u{20B9}",style: TextStyle(
                              fontSize: 10,
                              color: Colors.white
                          ));
                        } else if (getUserController!.dataList.isEmpty) {
                          return  Text("\u{20B9}0",style: TextStyle(
                              fontSize: 10,
                              color: Colors.white
                          ));
                        } else {
                          return  Text("\u{20B9}${getUserController?.dataList[0].amount.toString()=="null"?
                          "0":getUserController?.dataList[0].amount.toString()
                          }",style: TextStyle(
                              fontSize: 10,
                              color: Colors.white
                          ));
                        }
                      }else {
                        return  Text("\u{20B9}",style: TextStyle(
                            fontSize: 10,
                            color: Colors.white
                        ));
                      } //Error svg
                    })
                ))
          ],
        )
      ],
    );
  }
}

class CAppBarWidget extends StatefulWidget {
  final String? title;
  CAppBarWidget({this.title});

  @override
  _CAppBarWidgetState createState() => _CAppBarWidgetState();
}

class _CAppBarWidgetState extends State<CAppBarWidget> {
  bool isLoading = false;
  String uid = "";
  @override
  void initState() {
    // TODO: implement initState
    getAndSetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: appBarIconColor //change your color here
          ),
      title: Text(
        widget.title ?? "",
        style: kAppbarTitleStyle,
      ),
      centerTitle: true,
      backgroundColor: appBarColor,
      actions: !isLoading
          ? null
          : <Widget>[
              StreamBuilder(
                  stream: ReadData.fetchNotificationDotStatus(uid),
                  builder: (context, AsyncSnapshot snapshot) {
                    return !snapshot.hasData
                        ? Container()
                        : Padding(
                          padding: const EdgeInsets.only(right: 0.0, bottom: 5.0),
                          child: IconButton(
                              icon: Stack(
                                children: [
                                  Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                  ),
                                  snapshot.data["isAnyNotification"]
                                      ? Positioned(
                                          top: 0,
                                          right: 0,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius: 5,
                                          ),
                                        )
                                      : Positioned(
                                          top: 0, right: 0, child: Container())
                                ],
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  "/NotificationPage",
                                );
                              }
                              //

                              ),
                        );
                  })
            ],
    );
  }

  void getAndSetData() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    uid = preferences.getString("uid") ?? "";
    setState(() {
      isLoading = false;
    });
  }
}
