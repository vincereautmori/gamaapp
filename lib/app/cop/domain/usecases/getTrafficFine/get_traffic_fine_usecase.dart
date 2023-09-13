import 'package:multiple_result/multiple_result.dart';

import '/app/auth/domain/errors/errors.dart';
import '/app/cop/domain/entities/trafficFine/listed_traffic_fina_info.dart';
import '/app/cop/domain/entities/trafficFine/traffic_fine_filter_dto.dart';

abstract class GetTrafficFineUsecase {
  Future<Result<List<ListedTrafficFineInfo>, Failure>> call(
    TrafficFineFilterDto dto,
  );
}
