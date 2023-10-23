import 'package:geolocator/geolocator.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';

abstract class GetPositionUsecase {
  Future<Result<Position, Failure>> call();
}
