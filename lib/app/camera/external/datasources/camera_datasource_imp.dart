import 'package:dio/dio.dart';
import 'package:gamaapp/app/camera/infra/datasources/camera_datasource.dart';
import 'package:image_picker/image_picker.dart';

class CameraDatasourceImp implements CameraDatasource {
  final ImagePicker imagePicker;
  final Dio dio;

  CameraDatasourceImp({
    required this.imagePicker,
    required this.dio,
  });

  @override
  Future<XFile?> getCameraFile() =>
      imagePicker.pickImage(source: ImageSource.camera);

  @override
  Future<String> uploadImage(
    FormData fileFormData, {
    void Function(int, int)? onSendProgress,
  }) async {
    Response response = await dio.post(
      '/files',
      data: fileFormData,
      onSendProgress: onSendProgress,
    );

    return response.data;
  }

  @override
  Future<List<int>> loadImage(String url) async {
    Response response = await dio.get(
      '/files?path=$url',
      options: Options(responseType: ResponseType.bytes),
    );
    return response.data;
  }
}
