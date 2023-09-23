import 'package:gamaapp/app/camera/infra/datasources/camera_datasource.dart';
import 'package:image_picker/image_picker.dart';

class CameraDatasourceImp implements CameraDatasource {
  final ImagePicker imagePicker;

  CameraDatasourceImp(this.imagePicker);

  @override
  Future<XFile?> getCameraFile() =>
      imagePicker.pickImage(source: ImageSource.camera);
}
