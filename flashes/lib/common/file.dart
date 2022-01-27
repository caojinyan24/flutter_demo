import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

FileUploader fileUploader = FileUploader();

class FileUploader {
  Future<List<String?>> selectFiles() async {
    List<String?> result = [];
    FilePickerResult? pickerResult =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (pickerResult != null) {
      result = pickerResult.paths;
      log("files picked=" + result.toString());
    } else {
      log("user aborted！！");
    }
    return result;
  }


}
