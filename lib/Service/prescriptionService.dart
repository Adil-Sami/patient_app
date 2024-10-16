import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:demopatient/model/prescriptionModel.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/lablistmodel.dart';
import '../model/patientreportModel.dart';

class PrescriptionService {
  static const _viewUrl = "$apiUrl/get_prescription";
  static const _viewUrlById = "$apiUrl/get_prescription_byid";

  static List<PrescriptionModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<PrescriptionModel>.from(
        data.map((item) => PrescriptionModel.fromJson(item)));
  }

  static Future<List<PrescriptionModel>> getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString("uid") ?? "";

    final response =
        await http.post(Uri.parse(_viewUrl), body: {"uId": userId});
    if (response.statusCode == 200) {
      List<PrescriptionModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static Future<List<PrescriptionModel>> getDataByApId(
      {String? appointmentId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString("uid") ?? "";
    final response = await http.post(Uri.parse(_viewUrlById),
        body: {"uId": userId, "appointmentId": appointmentId});
    if (response.statusCode == 200) {
      List<PrescriptionModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
  static Future<List<Lablistmodel>> getLabTest(
      {dynamic? appointmentId}) async {
    print('id of user');
    print(appointmentId);

    final response = await http.get(Uri.parse('https://mydoctorjo.zahidaz.com/public/api/patient/labtest/index?appointment_id=${appointmentId}'));

    // body: {"appointmentId": appointmentId});
    // print(response.statusCode.toString());
    // print(response.body.toString());

    if (response.statusCode == 200) {
      List<Lablistmodel> list = lablistmodelFromJson(response.body);

      print('list data');
      print(list);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static Future addData(PrescriptionsModel prescriptionsModel) async {
    final response = await http.post(Uri.parse(postlab),
        body: prescriptionsModel.toJsonAdd());
    print(response.statusCode.toString());
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "error"; //if any error occurs then it return a blank list
    }
  }
}
