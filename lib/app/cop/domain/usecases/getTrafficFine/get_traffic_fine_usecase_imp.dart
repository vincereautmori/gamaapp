import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/cop/domain/entities/trafficFine/listed_traffic_fina_info.dart';
import 'package:gamaapp/app/cop/domain/entities/trafficFine/traffic_fine_filter_dto.dart';
import 'package:gamaapp/app/cop/domain/repositories/traffic_fine_repository.dart';
import 'package:multiple_result/multiple_result.dart';

import '/app/cop/domain/usecases/getTrafficFine/get_traffic_fine_usecase.dart';

class GetTrafficFineUsecaseImp implements GetTrafficFineUsecase {
  final TrafficFineRepository repository;

  GetTrafficFineUsecaseImp(this.repository);

  @override
  Future<Result<List<ListedTrafficFineInfo>, Failure>> call(
    TrafficFineFilterDto dto,
  ) async {
    String? createdSince = dto.formatToString(dto.createdSince);
    String? createdUntil = dto.formatToString(dto.createdUntil);

    final Result<List<ListedTrafficFineInfo>, Failure> result =
        await repository.fetchTrafficFine(
      createdSince: createdSince,
      createdUntil: createdUntil,
    );
    return result;
  }
}
