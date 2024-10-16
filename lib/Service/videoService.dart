import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:demopatient/model/videoModel.dart';
import 'package:http/http.dart' as http;

class VideoService {
  static const _viewUrl = "$apiUrl/getVideoUrl";

  static List<VideoModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<VideoModel>.from(data.map((item) => VideoModel.fromJson(item)));
  }

  static Future<List<VideoModel>> getData(getLimit) async {
    final limit = getLimit.toString();
    final response = await http.get(Uri.parse("$_viewUrl?limit=$limit"));
    if (response.statusCode == 200) {
      List<VideoModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
}
