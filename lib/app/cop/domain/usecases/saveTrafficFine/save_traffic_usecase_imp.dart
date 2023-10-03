import 'package:multiple_result/multiple_result.dart';

import '/app/auth/domain/errors/errors.dart';
import '/app/cop/domain/entities/dtos/traffic_fine_input_dto.dart';
import '../../repositories/traffic_fine_repository.dart';
import 'save_traffic_usecase.dart';

class SaveTrafficUsecaseImp implements SaveTrafficUsecase {
  final TrafficFineRepository repository;

  SaveTrafficUsecaseImp(this.repository);

  @override
  Future<Result<int, Failure>> call(TrafficFineInputDto dto) =>
      repository.createTrafficFine(
        licensePlate: dto.licensePlate,
        latitude: dto.latitude,
        longitude: dto.longitude,
        trafficViolations: dto.trafficViolations,
        imageUrl: dto.imageUrl,
      );
}
