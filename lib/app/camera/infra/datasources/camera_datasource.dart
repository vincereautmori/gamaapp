import 'package:image_picker/image_picker.dart';

abstract class CameraDatasource {
  Future<XFile> getCameraFile();
}
