import 'package:dio/src/form_data.dart';
import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/cop/domain/repositories/traffic_fine_repository.dart';
import 'package:gamaapp/app/cop/domain/usecases/uploadFile/upload_file_usecase.dart';
import 'package:multiple_result/src/result.dart';

class UploadFileUsecaseImp implements UploadFileUsecase {
  final TrafficFineRepository repository;

  UploadFileUsecaseImp(this.repository);

  @override
  Future<Result<String, Failure>> call(FormData fileFormData) =>
      repository.uploadFile(fileFormData);
}
