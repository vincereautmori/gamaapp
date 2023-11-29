import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../auth/domain/errors/errors.dart';

abstract class CameraRepository {
  Future<Result<XFile?, Failure>> takeCameraFile();

  Future<Result<String, Failure>> uploadFile(
    FormData fileFormData, {
    void Function(int, int)? onSendProgress,
  });

  Future<Result<List<int>, Failure>> loadFile(String url);
}
