import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:demopatient/config.dart';
import 'package:demopatient/model/pharma_req_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PharmaReqService {
  static const _viewUrl = "$apiUrl/get_pharma_req";
  static const _updateData = "$apiUrl/update_pharmareq";
  static const _updateStatus = "$apiUrl/udpate_pharamareq_status";
  static const _addUrl = "$apiUrl/add_pharma_req";
  static const _deleteUrl = "$apiUrl/deleted_updated";

  static List<PharmacyReqModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<PharmacyReqModel>.from(
        data.map((item) => PharmacyReqModel.fromJson(item)));
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
  static Future<List<PharmacyReqModel>> getData() async {
    SharedPreferences preferences =await SharedPreferences.getInstance();
    final uid=await preferences.getString("uidp")??"";
 //   print(_viewUrl);

    final response =
    await http.post(Uri.parse(_viewUrl), body: {"uid": uid});
    if (response.statusCode == 200) {
      List<PharmacyReqModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static Future updateData(PharmacyReqModel prescriptionModel) async {
    final response = await http.post(Uri.parse(_updateData),
        body: prescriptionModel.toJsonUpdate());
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "error"; //if any error occurs then it return a blank list
    }
  }

  static Future addData(PharmacyReqModel prescriptionModel) async {
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
