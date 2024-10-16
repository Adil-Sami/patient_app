import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:demopatient/helper/notify.dart';
import 'package:demopatient/model/wallet_history_model.dart';
import 'package:http/http.dart' as http;
import 'package:demopatient/model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/api_call_model.dart';

class UserService {
  static const _viewUrl = "$apiUrlLaravel/patient/show"; //"""$apiUrl/get_user";
  static const _addUrl = "$apiUrlLaravel/patient/create";//"$apiUrl/add_user";
  static const _update = "$apiUrl/update_user_fcm";
  static const _updateLUrl = "$apiUrl/update_user_location";
  static const _updateUrl = "$apiUrl/update_user";
  static const _searchByIdUrl = "$apiUrl/search_by_id";
  static const _getubyphnUrl = "$apiUrl/get_user_by_phn";
  static const _addWalletUrl = "$apiUrl/add_wallet";
  static const _getWHUrl = "$apiUrl/get_user_wallet_history";

  static List<UserModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<UserModel>.from(data.map((item) => UserModel.fromJson(item)));
  }
  static List<UserWalletHistoryModel> dataFromJsonWallet(String jsonString) {
    final data = json.decode(jsonString);
    return List<UserWalletHistoryModel>.from(data.map((item) => UserWalletHistoryModel.fromJson(item)));
  }

  static Future<List<UserModel>> getDataByPhn(phn) async {
    final response =
        await http.post(Uri.parse("$_getubyphnUrl"), body: {"phn": phn});
    if (response.statusCode == 200) {
      List<UserModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static Future<List<UserModel>> getUserById(String id) async {
    final response = await http
        .get(Uri.parse("$_searchByIdUrl?db=userList&idName=uId&id=$id"));
    print(response.body.toString());
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      List<UserModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static Future<List<UserModel>> getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString("uid") ?? "";
    // print("$_viewUrl?uid=$userId");

    final response = await http.get(Uri.parse("$_viewUrl?uId=$userId"));
    print("response.body");
    print("$_viewUrl?uid=$userId");
    ApiCallModel _apiCallModel = apiCallModelFromJson(response.body);

    if (response.statusCode == 200) {
      List<UserModel> list = userModelFromJson(jsonEncode(_apiCallModel.data).toString());
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static addData(UserModel appointmentModel) async {
    print(_addUrl);
    var headers = {
      'Accept': 'application/json'
    };

    final res = await http.post(Uri.parse(_addUrl), headers: headers,body: appointmentModel.toJsonAdd());
    if (res.statusCode == 200) {
      // return res.body;
      // save profile into active user and no need to call api again on signup
      dynamic jd = jsonDecode(res.body);
      successNotify(jd["message"]);

      return "success";
    } else{
      dynamic jd = jsonDecode(res.body);
      errorNotify(jd["message"]);

      return "error";
    }
  }

  static updateFcmId(String uId, String fcmId) async {
    final res = await http
        .post(Uri.parse("$_update"), body: {"fcmId": fcmId, "uid": uId});
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }

  static updateLocation(String uId, String long,String lat) async {
    final res = await http
        .post(Uri.parse("$_updateLUrl"), body: {"lat": lat, "long":long,"uid": uId});
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }

  static updateData(UserModel userModel) async {
    final res =
        await http.post(Uri.parse(_updateUrl), body: userModel.toUpdateJson());
    print(">>>>>>>>>>>>>>>>>>>>>>${res.body}");
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }

  static addDataWallet({
    required String payment_id,
    required String amount,
    required String status,
    required String desc,
    required String prAmount,

  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString("uid") ?? "";
    print({      "payment_id":payment_id,
      "uid":userId,
      "amount":amount,
      "desc":desc,
      "pr_amount":prAmount,
      "status":status});
    final res =
    await http.post(Uri.parse(_addWalletUrl), body: {
      "payment_id":payment_id,
      "uid":userId,
      "amount":amount,
      "desc":desc,
      "pr_amount":prAmount,
      "status":status
    });
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }
  static Future<List<UserWalletHistoryModel>> getWalletHistory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString("uid") ?? "";
    final response =
    await http.get(Uri.parse("$_getWHUrl?uid=$userId"),);
    if (response.statusCode == 200) {

      List<UserWalletHistoryModel> list = dataFromJsonWallet(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
}
