import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:demopatient/Service/reporstService.dart';
import 'package:demopatient/Service/uploadImageService.dart';
import 'package:demopatient/model/reportModel.dart';
import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/decoration.dart';
import 'package:demopatient/utilities/dialogBox.dart';
import 'package:demopatient/utilities/inputfields.dart';
import 'package:demopatient/utilities/toastMsg.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/bottomNavigationBarWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({Key? key}) : super(key: key);

  @override
  _AddReportPageState createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  ScrollController _scrollController = new ScrollController();
  TextEditingController reportTitleController = TextEditingController();
  List<String> _imageUrls = [];
  List<XFile> _listImages = [];
  int _successUploaded = 1;
  bool _isUploading = false;
  bool _isEnableBtn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationStateWidget(
          title: "Add".tr,
          onPressed: _takeUpdateConfirmation,
          clickable: _isEnableBtn ? "true" : ""),
      floatingActionButton: _isUploading
          ? null
          : FloatingActionButton(
              elevation: 0.0,
              child: IconButton(
                  icon: Icon(Icons.add_a_photo),
                  onPressed: () async {
                    await _loadAssets();
                  }),
              backgroundColor: btnColor,
              onPressed: () {}),
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          CAppBarWidget(title: "Add Reports".tr),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: IBoxDecoration.upperBoxDecoration(),
              child: _isUploading ? LoadingIndicatorWidget() : buildBody(),
            ),
          ),
        ],
      ),
    );
  }

  _takeUpdateConfirmation() {
    if (_listImages.length == 0) {
      ToastMsg.showToastMsg("Please add at least one image".tr);
    } else
      DialogBoxes.confirmationBox(context, "Update".tr,
          "Are you sure want to update details".tr, _handleUpdate);
  }

  _handleUpdate() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isUploading = true;
        _isEnableBtn = false;
      });
      if (_listImages.length == 0) {
        String imageUrl = "";
        // if (_imageUrls.length != 0) {
        //   for (var e in _imageUrls) {
        //     if (imageUrl == "") {
        //       imageUrl = e;
        //     } else {
        //       imageUrl = imageUrl + "," + e;
        //     }
        //   }
        // }
        SharedPreferences preferences = await SharedPreferences.getInstance();
        final uid = await preferences.getString("uidp") ?? "";

        ReportModel prescriptionModel = ReportModel(
          uid: uid,
          title: reportTitleController.text,
          imageUrl: imageUrl,
        );
        final res = await ReportService.addData(prescriptionModel);
        if (res == "success") {
          ToastMsg.showToastMsg("Successfully Added".tr);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/ReportListPage', ModalRoute.withName('/HomePage'));
        } else if (res == "already exists") {
          setState(() {
            _imageUrls.clear();
            _listImages.clear();
          });
          ToastMsg.showToastMsg("Title name already exists".tr);
        } else {
          setState(() {
            _imageUrls.clear();
            _listImages.clear();
          });
          ToastMsg.showToastMsg("Something went wrong".tr);
        }
      } else {
        await _startUploading();
      }

      setState(() {
        _isUploading = false;
        _isEnableBtn = true;
      });
    }
  }

  _startUploading() async {
    int index = _successUploaded - 1;
    // setState(() {
    //   _imageName = _listImages[index].name;
    // });

    if (_successUploaded <= _listImages.length) {
      final res = await UploadImageService.uploadImages(
          _listImages[index]); //  represent the progress of uploading task
      if (res == "0") {
        ToastMsg.showToastMsg(
            "Sorry, ${_listImages[index].name} is not in format only JPG, JPEG, PNG, & GIF files are allowed to upload");
        if (_successUploaded < _listImages.length) {
          //check more images for upload
          setState(() {
            _successUploaded = _successUploaded + 1;
          });
          _startUploading(); //if images is remain to upload then again run this task

        } else {}
      } else if (res == "1") {
        ToastMsg.showToastMsg(
            "Image ${_listImages[index].name} size must be less the 2MB");
        if (_successUploaded < _listImages.length) {
          //check more images for upload
          setState(() {
            _successUploaded = _successUploaded + 1;
          });
          _startUploading(); //if images is remain to upload then again run this task

        } else {}
      } else if (res == "2") {
        ToastMsg.showToastMsg(
            "Image ${_listImages[index].name} size must be less the 2MB");
        if (_successUploaded < _listImages.length) {
          //check more images for upload
          setState(() {
            _successUploaded = _successUploaded + 1;
          });
          _startUploading(); //if images is remain to upload then again run this task

        } else {}
      } else if (res == "3" || res == "error") {
        ToastMsg.showToastMsg("Something went wrong".tr);
        if (_successUploaded < _listImages.length) {
          //check more images for upload
          setState(() {
            _successUploaded = _successUploaded + 1;
          });
          _startUploading(); //if images is remain to upload then again run this task

        } else {}
      } else if (res == "") {
        ToastMsg.showToastMsg("Something went wrong".tr);
        if (_successUploaded < _listImages.length) {
          //check more images for upload
          setState(() {
            _successUploaded = _successUploaded + 1;
          });
          _startUploading(); //if images is remain to upload then again run this task

        } else {}
      } else {
        setState(() {
          _imageUrls.add(res);
        });

        if (_successUploaded < _listImages.length) {
          //check more images for upload
          setState(() {
            _successUploaded = _successUploaded + 1;
          });
          _startUploading(); //if images is remain to upload then again run this task

        } else {
          // print("***********${_imageUrls.length}");
          String imageUrl = "";
          if (_imageUrls.length != 0) {
            for (var e in _imageUrls) {
              if (imageUrl == "") {
                imageUrl = e;
              } else {
                imageUrl = imageUrl + "," + e;
              }
            }
          }
          SharedPreferences preferences = await SharedPreferences.getInstance();
          final uid = await preferences.getString("uidp") ?? "";
          ReportModel reportModel = ReportModel(
              title: reportTitleController.text, imageUrl: imageUrl, uid: uid);
          final res = await ReportService.addData(reportModel);
          if (res == "success") {
            ToastMsg.showToastMsg("Successfully Added".tr);
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/ReportListPage', ModalRoute.withName('/HomePage'));
          } else if (res == "already exists") {
            setState(() {
              _imageUrls.clear();
              _listImages.clear();
            });
            ToastMsg.showToastMsg("Title name already exists".tr);
          } else {
            setState(() {
              _imageUrls.clear();
              _listImages.clear();
            });
            ToastMsg.showToastMsg("Something went wrong".tr);
          }
        }
      }
    }
    setState(() {
      _isUploading = false;
      _isEnableBtn = true;
    });
  }

  Future<void> _loadAssets() async {
    // List<Asset> resultList = <Asset>[];
    // //String error = 'No Error Detected';
    // try {
    //   resultList = await MultiImagePicker.pickImages(
    //     maxImages: 5,
    //     enableCamera: true,
    //     selectedAssets: _listImages,
    //     cupertinoOptions: CupertinoOptions(
    //       takePhotoIcon: "chat",
    //       doneButtonTitle: "Fatto",
    //     ),
    //     materialOptions: MaterialOptions(
    //       actionBarColor: "#abcdef",
    //       actionBarTitle: "Example App",
    //       allViewTitle: "All Photos",
    //       useDetailsView: false,
    //       selectCircleStrokeColor: "#000000",
    //     ),
    //   );
    // } on Exception catch (e) {
    //   print(e);
    //   // error = e.toString();
    // }
    //
    // // If the widget was removed from the tree while the asynchronous platform
    // // message was in flight, we want to discard the reply rather than calling
    // // setState to update our non-existent appearance.
    // if (!mounted) return;
    // setState(() {
    //   _listImages = resultList;
    //   if (resultList.length > 0)
    //     _isEnableBtn = true;
    //   else
    //     _isEnableBtn = false;
    // });
    //
    // // setState(() {
    // //   // _listImages = resultList;
    // //   _error = error;
    // // });
  }

  buildBody() {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          InputFields.commonInputField(reportTitleController, "Report Title".tr,
              (item) {
            return item.length > 0 ? null : "Enter report title".tr;
          }, TextInputType.text, 1),

          // _imageUrls.length == 0
          //     ? Container()
          //     : Padding(
          //   padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          //   child: Text(
          //     "Previous attached image",
          //     style: TextStyle(
          //         fontFamily: "OpenSans-SemiBold", fontSize: 14),
          //   ),
          // ),
          //  _buildImageList(),
          _listImages.length == 0
              ? Container()
              : Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: Text(
                    "New attached image".tr,
                    style: TextStyle(
                        fontFamily: "OpenSans-SemiBold", fontSize: 14),
                  ),
                ),
          _buildNewImageList(),
        ],
      ),
    );
  }

  _buildNewImageList() {
    // in this section assets convert into file
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: _listImages.length,
          itemBuilder: (context, index) {
            File asset = File(_listImages[index].path);
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GestureDetector(
                onLongPress: () {
                  DialogBoxes.confirmationBox(context, "Delete".tr,
                      "Are you sure want to delete selected image".tr, () {
                    setState(() {
                      _listImages.removeAt(index);
                    });
                  });
                },
                child: Image.file(asset,
                  width: 300,
                  height: 300,
                ),
              ),
            );
          }),
    );
  }
}
