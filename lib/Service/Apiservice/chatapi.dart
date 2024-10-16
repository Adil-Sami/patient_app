import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import '../../config.dart';
import '../Model/ChatModel.dart';
import '../Model/PatientsendmessageModel.dart';
import 'dart:io';

class ChatApi {
  GetPatientMessages(dynamic appointment_id) async {
    final loginUrl = Uri.parse(
        '$apiUrlLaravel/patient/chat/index?appointment_id=${appointment_id}');
    final response = await http.get(
      loginUrl, headers: {},
      // 'email': email.toString(),
      // 'password': password.toString(),
    );
    // print(response.statusCode.toString());
    // print(response.body.toString());

    ChatModel model = chatModelFromJson(response.body.toString());
    // print('after model');
    if (model.st == 1) {
      return model.data;
    } else {
      return [];
    }
    // return json.decode(response.body);
  }

  Future<PatientsendmessageModel> PatinetSendMessage(
    dynamic appointment_id,
    dynamic userList_id,
    dynamic user_id,
    dynamic drprofile_id,
    dynamic sender,
    dynamic type,
    dynamic message,
    file, {
    prescriptionModel = null,
    labtestModel = null,
  }) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiUrlLaravel/patient/chat/store'));

    request.fields['appointment_id'] = appointment_id.toString();
    request.fields['userList_id'] = userList_id.toString();
    request.fields['user_id'] = user_id.toString();
    request.fields['drprofile_id'] = drprofile_id.toString();
    request.fields['sender'] = sender.toString();
    request.fields['type'] = type.toString();

    if (type == 1) {
      // simple chat message
      request.fields['message'] = message;
    }

    if (type == 2) {
      // simple audio message + no work
    }

    if (type == 3) {
      // send attachment
      request.files.add(http.MultipartFile(
          'message',
          File(file.path).readAsBytes().asStream(),
          File(file.path).lengthSync(),
          filename: file.path.split("/").last));
    }

    if (type == 4) {
      // send images
      request.files.add(http.MultipartFile(
          'message',
          File(file.path).readAsBytes().asStream(),
          File(file.path).lengthSync(),
          filename: file.path.split("/").last));
    }

    if (type == 5) {
      // send location + no work for this
      request.fields['message'] = message;
    }

    if (type == 6) {
      // send prescription
      request.fields['message'] = message;

      // send prescription data + to maintain old functionality
      dynamic map = prescriptionModel.toJsonAdd();
      map.forEach((k, v) => request.fields['prescription[$k]'] = v);
    }

    if (type == 7) {
      // send lab test
      request.fields['message'] = message;

      // send labtest data + to maintain old functionality
      dynamic map = labtestModel.toJsonAdd();
      map.forEach((k, v) => request.fields['labtest[$k]'] = v);
    }

    var response = await request.send();
    //
    print('STREAM');
    print(response.stream);
    print(response.stream.toString());
    final respStr = await response.stream.bytesToString();
    PatientsendmessageModel model = patientsendmessageModelFromJson(respStr);
    return model;

    // return json.decode(response.body);
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      // Show the download progress percentage
      Get.snackbar(
          'Downloading', '${(received / total * 100).toStringAsFixed(0)}%',
          showProgressIndicator: true,
          progressIndicatorBackgroundColor: Colors.blueAccent);
    }
  }

  Future<void> download(String url, String filename, {type:'invoice'}) async {
    try {
      var dio = Dio();
      dio.interceptors.add(LogInterceptor());

      String msg_d = '';
      if(type == 'invoice'){
        msg_d = 'Invoice download has started';
      }else if(type == 'prescription'){
        msg_d = 'Prescription download has started';
      }

      Get.snackbar('Downloading',
          msg_d,
          showProgressIndicator: true,
          progressIndicatorBackgroundColor: Colors.blueAccent);

      var response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );

      // Get the external storage directory
      Directory? savePath = await getExternalStorageDirectory();
      var file = File('${savePath!.path}/$filename');

      // Write the downloaded data to the file
      await file.writeAsBytes(response.data);

      OpenFilex.open(file.path);

      String msg = '';
      if(type == 'invoice'){
        msg = 'Invoice has been downloaded to ${file.path}';
      }else if(type == 'prescription'){
        msg = 'Prescription has been downloaded to ${file.path}';
      }


      Get.snackbar(
        'Download Completed',
        msg.toString(),
        duration: Duration(seconds: 5),
      );

    } catch (e) {
      debugPrint('Error while downloading: $e');
    }
  }
}
