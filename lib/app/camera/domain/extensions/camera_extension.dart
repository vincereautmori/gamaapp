import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

extension AuthStringsExtension on XFile {
  File toFile() => File(path);

  Future<FormData?> toFormData(String fileName) async {
    File file = toFile();

    return FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });
  }
}
