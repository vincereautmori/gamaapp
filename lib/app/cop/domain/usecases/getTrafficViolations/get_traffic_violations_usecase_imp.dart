import 'package:gamaapp/app/cop/domain/entities/trafficViolations/traffic_violation_info.dart';
import 'package:gamaapp/app/cop/domain/repositories/traffic_violation_repository.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';
import 'get_traffic_violations_usecase.dart';

class GetTrafficViolationsUsecaseImp implements GetTrafficViolationsUsecase {
  final TrafficViolationRepository repository;

  GetTrafficViolationsUsecaseImp(this.repository);

  @override
  Future<Result<List<TrafficViolationInfo>, Failure>> call() =>
      repository.fetchTrafficFine();
}
