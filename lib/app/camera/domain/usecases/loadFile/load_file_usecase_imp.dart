import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../repositories/camera_repository.dart';
import 'load_file_usecase.dart';

class LoadFileUsecaseImp implements LoadFileUsecase {
  final CameraRepository repository;

  LoadFileUsecaseImp(this.repository);

  @override
  Future<Result<List<int>, Failure>> call(String url) =>
      repository.loadFile(url);

  //       @override
  // Future<Result<List<int>, Failure>> call(String url) =>
  //     repository.loadFile(url);
}
