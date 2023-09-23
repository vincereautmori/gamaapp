import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';

abstract class UploadFileUsecase {
  Future<Result<String, Failure>> call(FormData fileFormData);
}
