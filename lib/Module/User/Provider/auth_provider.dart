import 'dart:convert';
import 'package:demopatient/Service/Model/ChatModel.dart';
import 'package:demopatient/config.dart';
import 'package:demopatient/helper/notify.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Screen/home.dart';
import '../../../model/api_call_model.dart';
import '../../../model/userModel.dart';

class AuthProvider with ChangeNotifier {
  // Map<int, List<ChatClass>> selected = {};

  // uId remain same for all profiles
  // String uId = '';

  // create new profile
  String newProfileFirstName = '';
  String newProfileLastName = '';
  String newProfileAge = '';
  String? newProfileGender;

  List<UserModel> users = [];
  bool loading = false;

  UserModel activeUser = UserModel();

  callApi() async {
    loading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uId = prefs.getString("uid");

    var url = Uri.parse('${apiUrlLaravel}/patient/index?uId=${uId}');
    var response = await http.get(url);
    ApiCallModel _apiCallModel = apiCallModelFromJson(response.body);
    users = userModelFromJson(jsonEncode(_apiCallModel.data).toString());

    loading = false;
    notifyListeners();
  }

  callCreateProfileApi() async {
    loading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uId = prefs.getString("uid");

    var headers = {
      'Accept': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://mydoctorjo.com/api/patient/create/child/profile?firstName=${newProfileFirstName}&lastName=${newProfileLastName}&imageUrl=i&uId=${uId}&age=${newProfileAge}&gender=${newProfileGender}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    dynamic json = jsonDecode(await response.stream.bytesToString());
    if (response.statusCode == 200) {

      Get.back();

      successNotify(json['message']);
      UserModel user = userModelFromJsonSingle(jsonEncode(json['data']).toString());
      users.add(user);

    } else {
      // print(response.reasonPhrase);
      errorNotify(json['message']);
    }

    loading = false;
    notifyListeners();
  }

  setActiveProfile(user) async {
    activeUser = user;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("firstName", user.firstName!);
    prefs.setString("lastName", user.lastName!);
    prefs.setString("iuid", user.id??"");
    prefs.setString("uidp", user.id!);
    prefs.setString("id", user.id!);
    prefs.setString("uid", user.uId!);
    prefs.setString("imageUrl", user.imageUrl!);
    prefs.setString("age", user.age!);
    prefs.setString("gender", user.gender!);
    // print(user.id);
    // go to home again
    Get.to(HomeScreen());
  }

  setSingleProfileOnReopenApp() async {
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? firstName = prefs.getString("firstName");
    String? lastName = prefs.getString("lastName");

    String? id = prefs.getString("id"); // we will use this and remove above two as we know is logic
    if(id == null){
      id = prefs.getString("uidp");
      if(id == null){
        id = prefs.getString("iuid");
      }
    }
    // String? iuid = prefs.getString("iuid");
    // String? uidp = prefs.getString("uidp");

    String? imageUrl = prefs.getString("imageUrl");
    String? age = prefs.getString("age");
    String? gender = prefs.getString("gender");

    UserModel user = UserModel(
      id: id.toString(),
      firstName: firstName.toString(),
      lastName: lastName.toString(),
      imageUrl: imageUrl.toString(),
      age: age.toString(),
      gender: gender.toString(),
    );
    setActiveProfile(user);

  }

  setNewProfileFirstName(val){
    newProfileFirstName = val;
    notifyListeners();
  }
  setNewProfileLastName(val){
    newProfileLastName = val;
    notifyListeners();
  }
  setNewProfileAge(val){
    newProfileAge = val;
    notifyListeners();
  }
  setNewProfileGender(val){
    newProfileGender = val;
    notifyListeners();
  }
}
