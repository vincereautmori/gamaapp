import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

abstract class CameraDatasource {
  Future<XFile?> getCameraFile();

  Future<String> uploadImage(
    FormData fileFormData, {
    void Function(int, int)? onSendProgress,
  });

  Future<List<int>> loadImage(String url);
}
