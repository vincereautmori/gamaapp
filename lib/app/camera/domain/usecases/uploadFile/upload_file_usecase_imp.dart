import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';
import '../../repositories/camera_repository.dart';
import 'upload_file_usecase.dart';

class UploadFileUsecaseImp implements UploadFileUsecase {
  final CameraRepository repository;

  UploadFileUsecaseImp(this.repository);

  @override
  Future<Result<String, Failure>> call(
    FormData fileFormData, {
    void Function(int, int)? onSendProgress,
  }) =>
      repository.uploadFile(
        fileFormData,
        onSendProgress: onSendProgress,
      );
}
