import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/camera/domain/repositories/camera_repository.dart';
import 'package:gamaapp/app/camera/domain/usecases/getMetadataFromCamera/get_metadata_from_camera_usecase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_result/multiple_result.dart';

class GetMetadataFromCameraUsecaseImp implements GetMetadataFromCameraUsecase {
  final CameraRepository repository;

  GetMetadataFromCameraUsecaseImp(this.repository);

// TODO implementar validações de permissões
  @override
  Future<Result<XFile, Failure>> call() => repository.takeCameraFile();
}
