import 'package:demopatient/config.dart';
// import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UploadImageService {
//uploadImages method upload the image using asset
  static Future<String> uploadImages(image) async {
    final imagePath = await getFilePath(image); //get image path
    final uri = Uri.parse("$apiUrl/upload_image.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = image.name;
    var pic = await http.MultipartFile.fromPath("image", imagePath);
    request.files.add(pic);
    var response = await request.send();
    final responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return responseBody;
    } else {
      return "error";
    }
  }

  static getFilePath(images) async {
    return images.path;
    File file = await getImageFileFromAssets(images);
    return file.path;
  }
}
Future<File> getImageFileFromAssets(asset) async {
  final byteData = await asset.getByteData();

  final tempFile =
  File("${(await getTemporaryDirectory()).path}/${asset.name}");
  final file = await tempFile.writeAsBytes(
    byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),);

  return file;
}


