import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:demopatient/config.dart';
import 'package:demopatient/model/reportModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportService {
  static const _viewUrl = "$apiUrl/get_reporst";
  static const _updateData = "$apiUrl/update_report";
  static const _addUrl = "$apiUrl/add_reports";
  static const _deleteUrl = "$apiUrl/deleted_updated";

  static List<ReportModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<ReportModel>.from(
        data.map((item) => ReportModel.fromJson(item)));
  }

  static Future<List<ReportModel>> getData() async {
    SharedPreferences preferences =await SharedPreferences.getInstance();
    final uid=await preferences.getString("uidp")??"";
    print(_viewUrl);

    final response =
    await http.post(Uri.parse(_viewUrl), body: {"uid": uid});
    if (response.statusCode == 200) {
      List<ReportModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static Future updateData(ReportModel prescriptionModel) async {
    final response = await http.post(Uri.parse(_updateData),
        body: prescriptionModel.toJsonUpdate());
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "error"; //if any error occurs then it return a blank list
    }
  }

  static Future addData(ReportModel prescriptionModel) async {
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
    print(id);
    print(_deleteUrl);
    final res = await http
        .post(Uri.parse(_deleteUrl), body: {"id": id, "dbName": "reports"});
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }
}
