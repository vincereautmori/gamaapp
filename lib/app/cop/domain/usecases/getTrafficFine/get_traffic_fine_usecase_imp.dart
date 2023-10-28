import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/cop/domain/entities/trafficFine/traffic_fine_info.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../repositories/traffic_fine_repository.dart';
import 'get_traffic_fine_usecase.dart';

class GetTrafficFineUsecaseImp implements GetTrafficFineUsecase {
  final TrafficFineRepository repository;

  GetTrafficFineUsecaseImp(this.repository);

  @override
  Future<Result<TrafficFineInfo, Failure>> call(int id) =>
      repository.getTrafficFine(id);
}
