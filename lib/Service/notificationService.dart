import 'dart:convert';
import 'package:demopatient/config.dart';

import 'package:http/http.dart' as http;
import 'package:demopatient/model/notificationModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static const _viewUrl = "$apiUrl/get_notification";
  static const _addUrl = "$apiUrl/add_notification";
  static const _addAdminUrl = "$apiUrl/add_admin_notification";
  static const _addAdminPharmaUrl = "$apiUrl/add_noti_pharma";
  static const _addAdminLAId = "$apiUrl/add_notiadmin_labattender";
  static addDataForLabAttender(NotificationModel notificationModel) async {
    print(notificationModel.toJsonAddForAdminLA());
    final res = await http.post(Uri.parse(_addAdminLAId),
        body: notificationModel.toJsonAddForAdminLA());
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }
  static List<NotificationModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<NotificationModel>.from(
        data.map((item) => NotificationModel.fromJson(item)));
  }
  static addDataForPharma(NotificationModel notificationModel) async {
    final res = await http.post(Uri.parse(_addAdminPharmaUrl),
        body: notificationModel.toJsonAddForAdminPharma());
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }
  static Future<List<NotificationModel>> getData(
      int getLimit, String userCreatedDate) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString("uid") ?? "";
    final String limit = getLimit.toString();
    print(userCreatedDate); //2021-04-30 17:38:16
    //2021-04-30 17:44:54
    final response = await http.get(Uri.parse(
        "$_viewUrl?uid=${userId}&limit=$limit&timeStamp=$userCreatedDate"));
    if (response.statusCode == 200) {
      List<NotificationModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static addData(NotificationModel notificationModel) async {
    print(notificationModel);
    final res = await http.post(Uri.parse(_addUrl),
        body: notificationModel.toJsonAdd()
    );
    print(res.statusCode.toString());
    print(res.body.toString());
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }

  static addDataForAdmin(NotificationModel notificationModel) async {
    final res = await http.post(Uri.parse(_addAdminUrl),
        body: notificationModel.toJsonAddForAdmin());
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }
}
