import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';
import '../../entities/trafficFine/traffic_fine_info.dart';

abstract class GetTrafficFineUsecase {
  Future<Result<TrafficFineInfo, Failure>> call(
    int ind,
  );
}
