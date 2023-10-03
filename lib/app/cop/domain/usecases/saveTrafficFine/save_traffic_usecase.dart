import 'package:gamaapp/app/cop/domain/entities/dtos/traffic_fine_input_dto.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';

abstract class SaveTrafficUsecase {
  Future<Result<int, Failure>> call(TrafficFineInputDto dto);
}
