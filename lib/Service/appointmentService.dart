import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:demopatient/model/token_model.dart';
import 'package:http/http.dart' as http;
import 'package:demopatient/model/appointmentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentService {
  static const _viewUrl = "$apiUrl/get_appointment_by_status";
  static const _viewUrlAll = "$apiUrl/get_appointment_by_Uid";
  static const _addUrl = "$apiUrlLaravel/patient/appointment/insert"; //"$apiUrl/add_appointment";
  static const _updateStatusUrl = "$apiUrlLaravel/patient/appointment/update-status"; //"$apiUrl/update_appointment_status";
  static const _checkUrl = "$apiUrl/check_app";
  static const _checkPDUrl = "$apiUrl/check_app_perday";
  static const _updateReschUrl = "$apiUrl/update_appointment_resch";
  static const _updateVBUUrl = "$apiUrl/update_app_vbu";
  static const _get_token_appid = "$apiUrl/get_token_appid";
  static const _deleteTokenUrl = "$apiUrl/delete_token";
  static const _checkDrWalkinUrl = "$apiUrl/check_dr_walkin";
  static List<AppointmentModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<AppointmentModel>.from(
        data.map((item) => AppointmentModel.fromJson(item)));
  }

  static Future<List<AppointmentModel>> getDrWalkinCheck(
      String doctId, String date) async {
    final response = await http
        .get(Uri.parse("$_checkDrWalkinUrl?doctId=$doctId&date=$date"));
    if (response.statusCode == 200) {
      List<AppointmentModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
  static Future<List<TokenModel>> getTokenByAppId(String appid) async {
    final response =
        await http.get(Uri.parse("$_get_token_appid?app_id=$appid"));
    if (response.statusCode == 200) {
      List<TokenModel> list = dataFromJsonToekn(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static List<TokenModel> dataFromJsonToekn(String jsonString) {
    final data = json.decode(jsonString);
    return List<TokenModel>.from(data.map((item) => TokenModel.fromJson(item)));
  }

  static Future<List<AppointmentModel>> getDataAll() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString("uid");

    final response =
        await http.get(Uri.parse("$_viewUrlAll?uid=$userId"));

    if (response.statusCode == 200) {
      List<AppointmentModel> list = dataFromJson(response.body);
      print("kkkkkkkkkkkkkk$list");

      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static Future<List<AppointmentModel>> getData(String forStatus) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString("uid");
    final status = forStatus;

    final response =
    await http.get(Uri.parse("$_viewUrl?uid=$userId&status=$status"));

    if (response.statusCode == 200) {
      List<AppointmentModel> list = dataFromJson(response.body);
      print("kkkkkkkkkkkkkk$list");

      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }


  static Future<List<AppointmentModel>> getCheck(
      String doctId, String date, String time) async {
    print("$_checkUrl?doctId=$doctId&time=$time&date=$date");
    final response = await http
        .get(Uri.parse("$_checkUrl?doctId=$doctId&time=$time&date=$date"));
    if (response.statusCode == 200) {
      List<AppointmentModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
  static Future getCheckPD(
      String doctId, String date,String isOnline) async {
    print("$_checkPDUrl?doctId=$doctId&date=$date&isOnline=$isOnline");
    final response = await http
        .get(Uri.parse("$_checkPDUrl?doctId=$doctId&date=$date&isOnline=$isOnline"));
    if (response.statusCode == 200) {
      final jsonRes=await jsonDecode(response.body);
      return jsonRes;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }


  static addData(AppointmentModel appointmentModel) async {
    final res =
        await http.post(Uri.parse(_addUrl), body: appointmentModel.toJsonAdd());
    print(appointmentModel.toJsonAdd());
    print("Myyyyyyyybbbbbody${res.body}");
    if (res.statusCode == 200) {
      print(res.body);
      return res.body;
    } else
      return "error";
  }

  static updateDataResch(AppointmentModel appointmentModel) async {
    final res = await http.post(Uri.parse(_updateReschUrl),
        body: appointmentModel.toJsonUpdateResch());
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }
  static updateDataVBY(String id,String status) async {
    final res = await http.post(Uri.parse(_updateVBUUrl),
        body: {
      "     id":id,
          "appointmentStatus":status
        });
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }

  static updateStatus(AppointmentModel appointmentModel) async {
    final res = await http.post(Uri.parse(_updateStatusUrl),
        body: appointmentModel.toJsonUpdateStatus(),
        headers: {
          'Accept': 'application/json',
        }
    );

    print(res.statusCode);
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }

  static deleteTokenData(String appid) async {
    print("ttttttttttttttttttddddddddddddddddlllllllllllll$appid ll");
    final res = await http.post(Uri.parse(_deleteTokenUrl),
        body: {"appid": appid, "dbName": "clinic"});
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }
  static getPayStackAcceessCodeData(email,amount) async {
    final res = await http.post(Uri.parse("https://api.paystack.co/transaction/initialize"),
        body: {
           "email": email, "amount": amount.toString()
        },
      headers: {
      "Authorization": "Bearer $payStackSecretKey"
      }
    );
    if (res.statusCode == 200) {
      final jsonRes=await jsonDecode( res.body);
      return jsonRes;
    } else
      return "error";
  }
}
