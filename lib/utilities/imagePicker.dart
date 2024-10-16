


import 'package:image_picker/image_picker.dart';
// import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerOld{

  static Future<List<XFile>> loadAssets(List<XFile> _images,mounted,int maxImages) async {
    List<XFile> _listImages = [];
    final picker = ImagePicker();
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    for (var i = 0; i < xfilePick.length; i++) {
      _listImages.add(xfilePick[i]);
    }

    return _listImages;
    // List<Asset> resultList = <Asset>[];
    // String error = 'No Error Detected';
    //
    // try {
    //   resultList = await MultiImagePicker.pickImages(
    //     maxImages: maxImages,
    //     enableCamera: true,
    //     selectedAssets: _images,
    //     cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
    //     materialOptions: MaterialOptions(
    //       actionBarColor: "#004272",
    //       actionBarTitle: "Select Images",
    //       allViewTitle: "All Photos",
    //       useDetailsView: false,
    //       selectCircleStrokeColor: "#004272",
    //     ),
    //   );
    // } on Exception catch (e) {
    //   error = e.toString();
    //   print(error);
    // }
    //
    // // If the widget was removed from the tree while the asynchronous platform
    // // message was in flight, we want to discard the reply rather than calling
    // // setState to update our non-existent appearance.
    // if (!mounted)
    //   return resultList;
    //
    //
    //
    // return resultList;

  }
}
