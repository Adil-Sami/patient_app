import 'package:demopatient/Module/Doctor/Provider/DoctorProvider.dart';
import 'package:demopatient/Screen/wallet_page.dart';
import 'package:demopatient/Service/AuthService/authservice.dart';
import 'package:demopatient/controller/get_user_controller.dart';
import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/toastMsg.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

import '../Module/Doctor/Screen/DoctorProfileScreen.dart';
import '../Module/User/Provider/auth_provider.dart';
import '../Screen/Invoice_list_screen.dart';
import '../Screen/appointment/ChatScreen.dart';
import '../Screen/appointment/appointmentChatScreen.dart';
import '../Screen/profile/SwitchProfileScreen.dart';
class IDrawer extends StatefulWidget {
  final String? phoneNum;
  final GetUserController? getUserController;
  IDrawer({this.phoneNum,this.getUserController});
  @override
  _IDrawerState createState() => _IDrawerState();
}


class _IDrawerState extends State<IDrawer> {

  // final GetUserController? getUserController;
  GetUserController getUserController = Get.put(GetUserController(),tag: "wallet");

  Locale? locale=Get.locale;
  String _uName = "";
  String _imageUrl = "";
  String packageName = "";
  String _uId = "";

  @override
  void initState() {
    // TODO: implement initState
    _setUserData();
    _setpackgeData();
    super.initState();
  }


  _setpackgeData() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageName = packageInfo.packageName;
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      height: MediaQuery.of(context).size.height,
      color: bgColor,
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
            color: appBarColor,
            height: 40,
          ),
          Container(color: appBarColor, child: _profileListTiles()),
          Container(
            color: appBarColor,
            height: 20,
          ),
          /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: locale!.languageCode=="en"?btnColor:Colors.grey,
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onPressed:(){
                    Get.updateLocale(Locale('en'));
                    locale = Get.locale;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("English", style: TextStyle(fontSize: 14)),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: locale!.languageCode=="ar"?btnColor:Colors.grey,
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onPressed:(){
                    Get.updateLocale(Locale('ar'));
                    locale = Get.locale;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("عربي", style: TextStyle(fontSize: 14)),

                  ),
                ),
              ]),*/
          // Divider(),
          _iButton(
              "Profile".tr,
              Icon(
                Icons.person,
                color: iconsColor,
              ), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/EditUserProfilePage");
          }),
          _divider2(),
          _iButton(
              "Switch a Profile".tr,
              Icon(
                Icons.supervised_user_circle_rounded,
                color: iconsColor,
              ), () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, "/EditUserProfilePage");
            Get.to(
                SwitchProfileScreen()
            );
          }),
          _divider2(),
          _iButton(
              "My Wallet".tr,
              Icon(
                Icons.account_balance_wallet,
                color: iconsColor,
              ), () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WalletPage(getUserController: getUserController)),
            );
          },
            trailing: Card(
              color: Colors.red,
              child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: getUserController == null?
                    Text("\u{20B9}",style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                    ))
                      : Obx(() {
                    if (!getUserController!.isError.value) { // if no any error
                      if (getUserController!.isLoading.value) {
                        return const Text("\u{20B9}",style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                        ));
                      } else if (getUserController!.dataList.isEmpty) {
                        return  Text("\u{20B9}0",style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                        ));
                      } else {
                        return  Text("\u{20B9}${getUserController?.dataList[0].amount.toString()=="null"?
                        "0" : getUserController?.dataList[0].amount.toString()
                        }",style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                        ));
                      }
                    }else {
                      return  Text("\u{20B9}",style: TextStyle(
                          fontSize: 12,
                          color: Colors.white
                      ));
                    } //Error svg
                  })
              ),
            )
          ),
          _divider2(),
          _iButton(
              "Prescriptions".tr,
              Icon(
                Icons.file_copy,
                color: iconsColor,
              ), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/PrescriptionListPage");
          }),
          _divider2(),
          _iButton(
              "My Appointments".tr,
              Icon(
                Icons.content_paste,
                color: iconsColor,
              ), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/Appointmentstatus");
          }),
          _divider2(),
          _iButton(
              "Chat".tr,
              Icon(
                Icons.chat,
                color: iconsColor,
              ), () {
            Navigator.pop(context);
            DoctorProvider doctorProvider = Provider.of<DoctorProvider>(context, listen: false);

            Get.to(ChatScreen(null,
                doctorProvider.doctor!.id.toString(),
                '${doctorProvider.doctor!.firstName} ${doctorProvider.doctor!.lastName}',
                Provider.of<AuthProvider>(context, listen: false).activeUser.id.toString(),
                _uId
            ));
          }),
          _divider2(),
          _iButton(
              "Bills".tr,
              Icon(
                Icons.file_copy,
                color: iconsColor,
              ), () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, "/TestimonialsPage");
            Get.to(InvoiceListPage());
          }),
          /*_divider2(),
          _iButton(
              "Testimonials".tr,
              Icon(
                Icons.assignment,
                color: iconsColor,
              ), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/TestimonialsPage");
          }),*/
          _divider2(),
          _iButton(
              "Availability".tr,
              Icon(
                Icons.location_on,
                color: iconsColor,
              ), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/AvaliblityPage");
          }),
          _divider2(),
          _iButton(
              "Videos".tr,
              Icon(
                Icons.video_collection_rounded,
                color: iconsColor,
              ), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/VideoListPage");
          }),
          _divider2(),
          _iButton(
              "Reach Us".tr,
            Icon(
              Icons.timer,
              color: iconsColor,
            ), () async {
              Navigator.pop(context);
              try {
                await launchUrl(Uri.parse('https://www.google.com/maps/search/?api=1&query=${Provider.of<DoctorProvider>(context, listen: false).doctor!.latLng.toString()}'));
              } catch (e) {
                print(e);
              }
              // Navigator.pushNamed(context, "/CityListReachUsPage");
            }),
          _divider2(),
          _iButton(
              "About".tr,
              Icon(
                Icons.location_on,
                color: iconsColor,
              ), () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, "/AvaliblityPage");
            Get.to(DoctorProfileScreen());
          }),
          // _divider2(),
          // _iButton(
          //     "Feedback".tr,
          //     Icon(
          //       Icons.feedback,
          //       color: iconsColor,
          //     ), () {
          //   Navigator.pop(context);
          //   Navigator.pushNamed(context, "/FeedBackPage");
          // }),

          /*_divider2(),
          _iButton(
              "Feedback".tr,
              Icon(
                Icons.star,
                color: iconsColor,
              ), () async {
            Navigator.pop(context);
            final _url =
                "https://play.google.com/store/apps/details?id=" + packageName; // chagne by hassan005004
            await canLaunchUrl(Uri.parse(_url))
                ? await launchUrl(Uri.parse(_url), mode: LaunchMode.externalApplication)
                : throw 'Could not launch $_url';
          }),*/
          _divider2(),
          _iButton("Share the app".tr, Icon(Icons.share, color: iconsColor), () {
            Navigator.pop(context);
            Share.share(
                'Check out doctor appointemnt app https://play.google.com/store/apps/details?id=' + packageName, // chagne by hassan005004
                subject: "Look that's very helpful!");
          }),
          _divider2(),

          _iButton(
              "Log Out".tr,
              Icon(
                Icons.logout,
                color: iconsColor,
              ),
              _handleSignOut),
          // _divider2(),
          // _iButton(
          //     "Privacy Policy ",
          //     Icon(
          //       Icons.file_copy,
          //       color: iconsColor,
          //     ), () {
          //   Navigator.pop(context);
          //   Navigator.pushNamed(context, "/PrivacyPage");
          // }),
          // _iButton(
          //     "Refund Policy ",
          //     Icon(
          //       Icons.file_copy,
          //       color: iconsColor,
          //     ), () {
          //   Navigator.pop(context);
          //   Navigator.pushNamed(context, "/RefundPolicyPage");
          // }),
          // _iButton(
          //     "Contact us",
          //     Icon(
          //       Icons.file_copy,
          //       color: iconsColor,
          //     ), () {
          //   Navigator.pop(context);
          //   Navigator.pushNamed(context, "/Contactuspage");
          // }),

          _divider2(),

          /*Container(
            // color: Colors.red,
              child: Align(
                  alignment: Alignment.bottomCenter, child: _profileSvg()))*/
          // _enquireBtn()
        ],
      ),
    ));
  }

  Widget _iButton(String titleText, Icon icon, onTap, {Widget? trailing}) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: icon,
        trailing: trailing != null? trailing : SizedBox.shrink(),
        title: Text(
          titleText,
          style: TextStyle(
            fontFamily: 'OpenSans-SemiBold',
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  _profileListTiles() {
    return Row(
      children: [
        SizedBox(width: 20),
        _profileImage(),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_uName,
                  style: TextStyle(
                      fontFamily: 'OpenSans-Bold',
                      fontSize: 18,
                      color: Colors.white)),
              Text(
                widget.phoneNum!,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        //subtitle: Text(widget.phoneNum),
      ],
    );
  }

  _divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Divider(),
    );
  }

  _divider2() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Divider(height: 0,),
    );
  }

  void _setUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _uName = prefs.getString("firstName")! + " " + prefs.getString("lastName")!;
      _imageUrl = prefs.getString("imageUrl")!;
      _uId = prefs.getString("uid")!;
    });
  }

  _profileSvg() {
    return SizedBox(
      height: 300,
      width: 300,
      child:
          //Container(color: Colors.red,)
          SvgPicture.asset("assets/icon/editProfile.svg",
              semanticsLabel: 'Acme Logo'),
    );
  }

  Widget _profileImage() {
    return Container(
      //  color: Colors.green,
      child: ClipOval(
          child: _imageUrl == ""
              ? Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 40,
                )
              : SizedBox(
                  height: 80,
                  width: 80,
                  child: ImageBoxFillWidget(imageUrl: _imageUrl))),
    );

    //   ClipRRect(
    //     borderRadius: //BorderRadius.circular(8.0),
    //     child:  Image.network( )
    // );
  }

  _handleSignOut() async {
    bool isSignOut = await AuthService.signOut();
    if (isSignOut) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/LoginPage', (Route<dynamic> route) => false);
      ToastMsg.showToastMsg("Logged Out");
    }
  }
}
