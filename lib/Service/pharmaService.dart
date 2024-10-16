import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:demopatient/config.dart';
import 'package:demopatient/model/pharmacyModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PharmacyService {
  static const _viewUrl = "$apiUrl/get_pharma";
  static const _viewUrlById = "$apiUrl/get_pharmacybyid";
  static const _updateData = "$apiUrl/update_pharmacy";
  static const _addUrl = "$apiUrl/add_pharmacy";
  static const _deleteUrl = "$apiUrl/deleted_updated";
  static const _loginUrl = "$apiUrl/pharma_login";
  static const _updatFcm = "$apiUrl/update_fcm_pharma";
  static List<PharmacyModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<PharmacyModel>.from(
        data.map((item) => PharmacyModel.fromJson(item)));
  }

  static Future<List<PharmacyModel>> getData(cityId) async {
    final response =
    await http.get(Uri.parse("$_viewUrl?cityId=$cityId"));
    if (response.statusCode == 200) {
      List<PharmacyModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
  static Future<List<PharmacyModel>> getDataByPid() async {
    SharedPreferences preferences =await SharedPreferences.getInstance();
    final uid=await preferences.getString("uidp")??"";

    final response =
    await http.post(Uri.parse(_viewUrl), body: {"uid": uid});
    if (response.statusCode == 200) {
      List<PharmacyModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static Future<List<PharmacyModel>> getDataByApId(
      { String? pid}) async {
    final response = await http.post(Uri.parse(_viewUrlById),
        body: {"pid":pid});
    if (response.statusCode == 200) {
      List<PharmacyModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static Future updateData(PharmacyModel prescriptionModel) async {
    final response = await http.post(Uri.parse(_updateData),
        body: prescriptionModel.toJsonUpdate());
    print("%%%%%%%${response.body}");
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "error"; //if any error occurs then it return a blank list
    }
  }

  static Future addData(PharmacyModel prescriptionModel) async {
    print(prescriptionModel.toJsonAdd());
    final response = await http.post(Uri.parse(_addUrl),
        body: prescriptionModel.toJsonAdd());
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "error"; //if any error occurs then it return a blank list
    }
  }

  static deleteData(String id) async {
    final res = await http
        .post(Uri.parse(_deleteUrl), body: {"id": id, "dbName": "pharmacy"});
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }
  static Future<List<PharmacyModel>> getCredential(
      String email, String pass) async {
    final response = await http
        .post(Uri.parse(_loginUrl), body: {"email": email, "pass": pass});
    if (response.statusCode == 200) {
      List<PharmacyModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
  static updateFcmId(String fcmId, String id) async {
    final res = await http.post(Uri.parse("$_updatFcm"),
        body: {"fcmId": fcmId, "id": id});
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }

}
