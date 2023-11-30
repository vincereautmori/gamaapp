import 'package:dio/dio.dart';
import 'package:gamaapp/app/camera/domain/extensions/camera_extension.dart';
import 'package:gamaapp/app/camera/domain/usecases/getMetadataFromCamera/get_metadata_from_camera_usecase.dart';
import 'package:gamaapp/shared/themes/snackbar_styles.dart';
import 'package:gamaapp/shared/utils/utils.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../auth/domain/errors/errors.dart';
import '../../domain/usecases/loadFile/load_file_usecase.dart';
import '../../domain/usecases/uploadFile/upload_file_usecase.dart';

class CameraController extends GetxController {
  final GetFileFromCameraUsecase getFileFromCamera;
  final UploadFileUsecase uploadFile;
  final LoadFileUsecase loadFile;

  CameraController({
    required this.getFileFromCamera,
    required this.uploadFile,
    required this.loadFile,
  });

  Future<FormData?> getFormData() async {
    Result<XFile?, Failure> result = await getFileFromCamera();
    FormData? formData;
    result.when(
      (file) async {
        if (file != null) {
          formData = await file.toFormData('foto');
        }
      },
      (error) => utils.callSnackBar(
        title: "Falha ao carregar imagem",
        message: error.message,
        snackStyle: SnackBarStyles.error,
      ),
    );

    return formData;
  }
}
