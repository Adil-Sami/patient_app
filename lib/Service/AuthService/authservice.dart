import 'package:demopatient/Screen/login.dart';
import 'package:demopatient/Screen/registerUserPage.dart';
import 'package:demopatient/Service/userService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return
                //HomeScreen();
                RegisterUserPage();
          } else {
            return
                // HomeScreen();
                LoginPage();
          }
        });
  }

  //Sign out
  static Future<bool> signOut() async {
    bool isSignOut = false;

    await FirebaseAuth.instance.signOut().then((v) {
      isSignOut = true;
    }).catchError((e) {
      print(e); //Invalid otp
      isSignOut = false;
    });

    return isSignOut;
  }

  //SignIn
  Future<bool> signIn(AuthCredential authCreds) async {
    bool isVerified = false;
    CircularProgressIndicator();
    await FirebaseAuth.instance.signInWithCredential(authCreds).then((auth) {
      print("Auth"); //Successfully otp verified
      isVerified = true;
    }).catchError((e) {
      print(e); //Invalid otp
      isVerified = false;
    });
    return isVerified;
  }

  Future<bool> signInWithOTP(smsCode, verId) async {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    bool verified = await signIn(authCreds).catchError((e) {
      print(e);
      return false;
    });
    return verified;
  }
//
//  Future<Widget>  _checkUserIsRegistered() async{
//      SharedPreferences prefs=await SharedPreferences.getInstance();
//      final phn=prefs.getString("phn")??"";
//      final phone=prefs.getString("phone")??"";
//    // final user = FirebaseAuth.instance.currentUser;
//   //  print("=======================${user.uid}===============");
//     String userID="";
//     final res=await UserService.getDataByPhn(phone);
//     if(res.length>0)
//       {userID=res[0].uId.toString();
//       }
// //print("popoopopopopopopopop$phone opopo$userID");
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('usersList')
//             .doc(userID)
//             .snapshots(),
//         builder: (context,AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             // print(snapshot.data.exists);
//             if (snapshot.data!.exists) {
//               setData(userID);
//
//               return HomeScreen();
//             } else
//               return RegisterUserPage(uId: userID, pNo: phn);
//           } else
//             return Scaffold(body: LoadingIndicatorWidget());
//         });
//   }
}

void setData(uId) async {
  String fcm = "";
  try {
    fcm = await FirebaseMessaging.instance.getToken() ?? "";
    await UserService.updateFcmId(uId, fcm);
  } catch (e) {
    print(e);
  }
}
