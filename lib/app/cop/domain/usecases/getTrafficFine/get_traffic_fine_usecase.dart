import 'package:multiple_result/multiple_result.dart';

import '/app/auth/domain/errors/errors.dart';
import '../../entities/dtos/traffic_fine_filter_dto.dart';
import '../../entities/trafficFine/listed_traffic_fine_info.dart';

abstract class GetTrafficFineUsecase {
  Future<Result<List<ListedTrafficFineInfo>, Failure>> call(
    TrafficFineFilterDto dto,
  );
}
