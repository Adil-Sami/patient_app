import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/invoiceslist_model.dart';

class GetInvoicesController extends GetxController {
  var isLoading = false.obs;
  InvoiceslistModel? invoiceslistModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Uid = prefs.getString('uid');
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse(
          'https://mydoctorjo.com/api/patient/invoices?uid=${Uid}')!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        invoiceslistModel = InvoiceslistModel.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }
}
