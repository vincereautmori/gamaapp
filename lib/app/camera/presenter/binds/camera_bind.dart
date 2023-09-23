import 'package:gamaapp/app/camera/domain/repositories/camera_repository.dart';
import 'package:gamaapp/app/camera/domain/usecases/getMetadataFromCamera/get_metadata_from_camera_usecase.dart';
import 'package:gamaapp/app/camera/domain/usecases/getMetadataFromCamera/get_metadata_from_camera_usecase_imp.dart';
import 'package:gamaapp/app/camera/external/datasources/camera_datasource_imp.dart';
import 'package:gamaapp/app/camera/infra/datasources/camera_datasource.dart';
import 'package:gamaapp/app/camera/infra/repositories/camera_repository_imp.dart';
import 'package:gamaapp/app/camera/presenter/controllers/camera_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CameraBind implements Bindings {
  final ImagePicker imagePicker = ImagePicker();

  @override
  void dependencies() {
    CameraDatasource datasource = CameraDatasourceImp(imagePicker);

    CameraRepository repository = CameraRepositoryImp(datasource);

    GetFileFromCameraUsecase usecase = GetFileFromCameraUsecaseImp(repository);

    Get.lazyPut(
      () => CameraController(usecase),
      fenix: true,
    );
  }
}
