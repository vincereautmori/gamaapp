import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/cop/domain/repositories/traffic_fine_repository.dart';
import 'package:multiple_result/multiple_result.dart';

import 'load_file_usecase.dart';

class LoadFileUsecaseImp implements LoadFileUsecase {
  final TrafficFineRepository repository;

  LoadFileUsecaseImp(this.repository);

  @override
  Future<Result<List<int>, Failure>> call(String url) =>
      repository.loadFile(url);

  //       @override
  // Future<Result<List<int>, Failure>> call(String url) =>
  //     repository.loadFile(url);
}
