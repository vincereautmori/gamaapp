import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';

abstract class LoadFileUsecase {
  Future<Result<List<int>, Failure>> call(String url);
  // Future<Result<List<int>, Failure>> call(String url);
}
