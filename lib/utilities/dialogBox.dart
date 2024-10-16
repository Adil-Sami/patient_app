import 'package:demopatient/utilities/color.dart';
import 'package:flutter/material.dart';

class DialogBoxes {
  static Future<String?> openSettingBox(
      context, String title, String subTitle, onPressed) {
    return showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: new Text(title),
          content: new Text(subTitle),
          actions: <Widget>[
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: btnColor,
                ),
                child: const Text("Open Setting"),
                onPressed: () {
                  onPressed();
                  Navigator.of(context).pop();
                }),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: btnColor,
                ),
                child:  const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                })
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }
  static Future<String?> confirmationBox(
      context, String title, String subTitle, onPressed) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: new Text(title),
          content: new Text(subTitle),
          actions: <Widget>[
            new ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: btnColor,
                ),
                child: new Text("OK"),
                onPressed: () {
                  onPressed();
                  Navigator.of(context).pop();
                }),
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }

  static Future<String?> stopBookingAlertBox(
      context, String title, String subTitle) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async {
            // hassan005004
            // Navigator.popUntil(context, ModalRoute.withName('/HomePage'));
            Navigator.pop(context);
            return false;
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: new Text(title),
            content: new Text(subTitle),
          ),
        );
      },
    );
  }

  static Future<String?> technicalIssueAlertBox(
      context, String title, String subTitle) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async {
            return false;
            //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: new Text(title),
            content: new Text(subTitle),
          ),
        );
      },
    );
  }

  static Future<String?> versionUpdateBox(
      context, String title, String btnTitle, String subTitle, onPressed) {
    return showDialog(
      //barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: new Text(title),
          content: new Text(subTitle),
          actions: <Widget>[
            new ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: btnColor,
                ),
                child: new Text(btnTitle),
                onPressed: () {
                  onPressed();
                  Navigator.of(context).pop();
                }),
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }

  static Future<String?> forceUpdateBox(
      context, String title, String btnTitle, String subTitle, onPressed) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async {
            return false;
            //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: new Text(title),
            content: new Text(subTitle),
            actions: <Widget>[
              new ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor,
                  ),
                  child: new Text(btnTitle),
                  onPressed: () {
                    onPressed();
                  }),
              // usually buttons at the bottom of the dialog
            ],
          ),
        );
      },
    );
  }
}
