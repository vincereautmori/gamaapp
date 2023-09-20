import 'package:gamaapp/app/cop/domain/entities/dtos/traffic_fine_input_dto.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';
import '../../entities/trafficFine/traffic_fine_info.dart';

abstract class SaveTrafficUsecase {
  Future<Result<TrafficFineInfo, Failure>> call(TrafficFineInputDto dto);
}
