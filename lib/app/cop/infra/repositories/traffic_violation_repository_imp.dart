import 'package:gamaapp/app/cop/domain/entities/trafficViolations/traffic_violation_info.dart';
import 'package:gamaapp/app/cop/domain/errors/error.dart';
import 'package:gamaapp/app/cop/infra/models/traffic_violation_model.dart';
import 'package:multiple_result/multiple_result.dart';

import '/app/auth/domain/errors/errors.dart';
import '../../domain/repositories/traffic_violation_repository.dart';
import '../datasources/traffic_violation_datasource.dart';

class TrafficViolationRepositoryImp implements TrafficViolationRepository {
  final TrafficViolationDatasource datasource;

  TrafficViolationRepositoryImp(this.datasource);

  @override
  Future<Result<List<TrafficViolationInfo>, Failure>>
      fetchTrafficViolation() async {
    try {
      List<TrafficViolationModel> trafficViolations =
          await datasource.fetchTrafficViolations();
      return Success(trafficViolations);
    } catch (e) {
      return Error(
        TrafficViolationError(message: "Falha ao carregar tipos de multa"),
      );
    }
  }
}
