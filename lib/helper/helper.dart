import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// Future<bool> checkAndRequestCameraPermissions() async {
//   PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
//   if (permission != PermissionStatus.granted) {
//     Map<PermissionGroup, PermissionStatus> permissions =
//     await PermissionHandler().requestPermissions([PermissionGroup.camera]);
//     return permissions[PermissionGroup.camera] == PermissionStatus.granted;
//   } else {
//     return true;
//   }
// }

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}