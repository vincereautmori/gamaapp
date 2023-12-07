import 'package:dio/dio.dart';
import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/camera/domain/errors/camera_errors.dart';
import 'package:gamaapp/app/camera/domain/repositories/camera_repository.dart';
import 'package:gamaapp/app/camera/infra/datasources/camera_datasource.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_result/multiple_result.dart';

class CameraRepositoryImp implements CameraRepository {
  final CameraDatasource datasource;

  CameraRepositoryImp(this.datasource);

  @override
  Future<Result<XFile?, Failure>> takeCameraFile() async {
    try {
      XFile? xfile = await datasource.getCameraFile();
      return Success(xfile);
    } catch (e) {
      return Error(CameraError(message: "Falha ao abrir a camera"));
    }
  }

  @override
  Future<Result<String, Failure>> uploadFile(
    FormData fileFormData, {
    void Function(int, int)? onSendProgress,
  }) async {
    try {
      String uploadedImageUrl = await datasource.uploadImage(
        fileFormData,
        onSendProgress: onSendProgress,
      );

      if (uploadedImageUrl.isEmpty) {
        return Error(
          UploadImageError(
            message: 'Tente novamente em alguns instantes',
          ),
        );
      }

      return Success(uploadedImageUrl);
    } catch (e) {
      return Error(
        UploadImageError(
          message: 'Falha ao fazer upload da imagem',
        ),
      );
    }
  }

  @override
  Future<Result<List<int>, Failure>> loadFile(String url) async {
    try {
      List<int> fileBytes = await datasource.loadImage(url);
      return Success(fileBytes);
    } catch (e) {
      return Error(
        UploadImageError(
          message: 'Falha ao carregar imagem',
        ),
      );
    }
  }
}
