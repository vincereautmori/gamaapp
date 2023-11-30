import 'package:dio/dio.dart';
import 'package:gamaapp/app/camera/domain/repositories/camera_repository.dart';
import 'package:gamaapp/app/camera/domain/usecases/getMetadataFromCamera/get_metadata_from_camera_usecase.dart';
import 'package:gamaapp/app/camera/domain/usecases/getMetadataFromCamera/get_metadata_from_camera_usecase_imp.dart';
import 'package:gamaapp/app/camera/external/datasources/camera_datasource_imp.dart';
import 'package:gamaapp/app/camera/infra/datasources/camera_datasource.dart';
import 'package:gamaapp/app/camera/infra/repositories/camera_repository_imp.dart';
import 'package:gamaapp/app/camera/presenter/controllers/camera_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../shared/config/dio.dart';
import '../../domain/usecases/loadFile/load_file_usecase.dart';
import '../../domain/usecases/loadFile/load_file_usecase_imp.dart';
import '../../domain/usecases/uploadFile/upload_file_usecase.dart';
import '../../domain/usecases/uploadFile/upload_file_usecase_imp.dart';

class CameraBind implements Bindings {
  final ImagePicker imagePicker = ImagePicker();

  @override
  void dependencies() {
    Dio dio = Api().dio;
    CameraDatasource datasource = CameraDatasourceImp(
      dio: dio,
      imagePicker: imagePicker,
    );

    CameraRepository repository = CameraRepositoryImp(datasource);

    GetFileFromCameraUsecase getFile = GetFileFromCameraUsecaseImp(repository);
    LoadFileUsecase loadFile = LoadFileUsecaseImp(repository);
    UploadFileUsecase uploadFile = UploadFileUsecaseImp(repository);

    Get.lazyPut(
      () => CameraController(
        getFileFromCamera: getFile,
        loadFile: loadFile,
        uploadFile: uploadFile,
      ),
      fenix: true,
    );
  }
}
