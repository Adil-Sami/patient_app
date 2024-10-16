import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:demopatient/config.dart';
import 'package:demopatient/model/lab_test_app_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LabTestAppService {
  static const _viewUrl = "$apiUrl/get_lab_test_app";
  static const _updateData = "$apiUrl/update_labapp";
  static const _updateStatus = "$apiUrl/udpate_pharamareq_status";
  static const _addUrl = "$apiUrl/add_labtestapp";
  static const _deleteUrl = "$apiUrl/deleted_updated";

  static List<LabTestAppModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<LabTestAppModel>.from(
        data.map((item) => LabTestAppModel.fromJson(item)));
  }
  static Future updateStatus(String status,String prId) async {
    final response = await http.post(Uri.parse(_updateStatus),
        body: {"status":status,
          "prid":prId
        });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "error"; //if any error occurs then it return a blank list
    }
  }
  static Future<List<LabTestAppModel>> getData() async {
    SharedPreferences preferences =await SharedPreferences.getInstance();
    final uid=await preferences.getString("uidp")??"";
    //   print(_viewUrl);

    final response =
    await http.post(Uri.parse(_viewUrl), body: {"uid": uid});
    if (response.statusCode == 200) {
      List<LabTestAppModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static Future updateStatusData(id,status) async {
    final response = await http.post(Uri.parse(_updateData),
        body: {
      "id":id,
          'status':status

        });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "error"; //if any error occurs then it return a blank list
    }
  }

  static Future addData(LabTestAppModel prescriptionModel) async {
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
        .post(Uri.parse(_deleteUrl), body: {"id": id, "dbName": "pharma_request"});
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }
}
