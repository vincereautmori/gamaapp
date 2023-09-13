import 'package:gamaapp/app/cop/domain/errors/error.dart';
import 'package:gamaapp/app/cop/infra/models/listed_traffic_fine_model.dart';
import 'package:multiple_result/multiple_result.dart';

import '/app/auth/domain/errors/errors.dart';
import '/app/cop/domain/entities/trafficFine/listed_traffic_fina_info.dart';
import '/app/cop/domain/repositories/traffic_fine_repository.dart';
import '/app/cop/infra/datasources/traffic_fine_datasource.dart';

class TrafficFineRepositoryImp implements TrafficFineRepository {
  final TrafficFineDatasource datasource;

  TrafficFineRepositoryImp(this.datasource);

  @override
  Future<Result<List<ListedTrafficFineInfo>, Failure>> fetchTrafficFine({
    String? createdSince,
    String? createdUntil,
  }) async {
    try {
      List<ListedTrafficFineModel> listedTrafficFine =
          await datasource.fetchTrafficFines(
        createdSince: createdSince,
        createdUntil: createdUntil,
      );
      return Success(listedTrafficFine);
    } catch (e) {
      return Error(
        TrafficFineError(
          message: 'Algo deu errado!',
        ),
      );
    }
  }
}
