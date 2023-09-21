import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class GetMetadataFromCameraUsecase {
  Future<Result<XFile, Failure>> call();
}
