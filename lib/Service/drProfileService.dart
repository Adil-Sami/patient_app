import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:demopatient/model/doctTimeSlotModel.dart';
import 'package:http/http.dart' as http;
import 'package:demopatient/model/drProfielModel.dart';

class DrProfileService {
  static const _viewUrl = "$apiUrl/get_ab";
  static const _viewUrlByDeptId = "$apiUrl/get_drbydeptclinic"; // nwo filter not working
  static const _viewUrlByCity = "$apiUrl/get_dr_bycity";
  static const _checkRevelUrl = "$apiUrl/check_info_reveal";
  static const _getAllDrURl = "$apiUrl/get_all_dr";
  static const _viewUrlByDrId = "$apiUrl/get_dr_byid";
  static const doctTimeSlotUrl = "$apiUrl/get_doct_timelsot";

  static List<DrProfileModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<DrProfileModel>.from(
        data.map((item) => DrProfileModel.fromJson(item)));
  }
  static List<DoctorTimeSlotModel> dataFromJsonTimeSlot(String jsonString) {
    final data = json.decode(jsonString);
    return List<DoctorTimeSlotModel>.from(
        data.map((item) => DoctorTimeSlotModel.fromJson(item)));
  }
  static Future<List<DoctorTimeSlotModel>> getDoctTimeSlot(String doctId) async {
    final response = await http.get(Uri.parse("$doctTimeSlotUrl?doctId=$doctId"));
    if (response.statusCode == 200) {
      List<DoctorTimeSlotModel> list = dataFromJsonTimeSlot(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static List<DrProfileModelLocation> dataFromJsonLocaion(String jsonString) {
    final data = json.decode(jsonString);
    return List<DrProfileModelLocation>.from(
        data.map((item) => DrProfileModelLocation.fromJson(item)));
  }

  static Future<List<DrProfileModel>> getData() async {
    final response = await http.get(Uri.parse(_viewUrl));
    if (response.statusCode == 200) {
      List<DrProfileModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
  static Future<List<DrProfileModelLocation>> getAllDrData() async {
    final response = await http.get(Uri.parse(_getAllDrURl));
    if (response.statusCode == 200) {
      List<DrProfileModelLocation> list = dataFromJsonLocaion(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static Future<List<DrProfileModel>> getDataByCityId(String cityId) async {
    print("$_viewUrlByCity?cityId=$cityId");
    final response =
        await http.get(Uri.parse("$_viewUrlByCity?cityId=$cityId"));
    if (response.statusCode == 200) {
      List<DrProfileModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static Future checkInfoReveal(String clinicId) async {
    final response =
        await http.get(Uri.parse("$_checkRevelUrl?clinicId=$clinicId"));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      return "error"; //if any error occurs then it return a blank list
    }
  }

  static Future<List<DrProfileModel>> getAllDoctors() async {
    final response = await http.get(Uri.parse("$_getAllDrURl"));
    print(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      List<DrProfileModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static Future<List<DrProfileModel>> getDataById(String id, String clinicId, String cityId) async {
    final response = await http.get(Uri.parse(
        "$_viewUrlByDeptId?deptId=$id&clinicId=$clinicId&cityId=$cityId"));

    print(response.body);
    if (response.statusCode == 200) {
      List<DrProfileModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static Future<List<DrProfileModel>> getDataByDrId(String doctId) async {
    final response = await http.get(Uri.parse("$_viewUrlByDrId?id=$doctId"));
    if (response.statusCode == 200) {
      print("response.body");
      print(response.body);
      List<DrProfileModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
}
