import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/exceptions.dart';

Future<File?> pickFile(BuildContext context) async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );

    String? path = result?.files.single.path;
    return path == null ? null : File(path);
  } on PlatformException catch (e) {
    if (e.code == 'read_external_storage_denied') {
      throw ExternalStorageAccessException();
    }
    return null;
  }
}
