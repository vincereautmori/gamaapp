import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/cop/domain/entities/dtos/traffic_fine_filter_dto.dart';
import 'package:gamaapp/app/cop/domain/entities/trafficFine/listed_traffic_fine_info.dart';
import 'package:gamaapp/app/cop/domain/repositories/traffic_fine_repository.dart';
import 'package:gamaapp/shared/extensions/datetime_extension.dart';
import 'package:multiple_result/multiple_result.dart';

import '/app/cop/domain/usecases/getTrafficFine/get_traffic_fine_usecase.dart';

class GetTrafficFineUsecaseImp implements GetTrafficFineUsecase {
  final TrafficFineRepository repository;

  GetTrafficFineUsecaseImp(this.repository);

  @override
  Future<Result<List<ListedTrafficFineInfo>, Failure>> call(
    TrafficFineFilterDto dto,
  ) async {
    String? createdSince = dto.createdSince.formatDate('yyyy-MM-dd');
    String? createdUntil = dto.createdUntil.formatDate('yyyy-MM-dd');

    final Result<List<ListedTrafficFineInfo>, Failure> result =
        await repository.fetchTrafficFine(
      licensePlate: dto.licensePlate,
      createdSince: createdSince,
      createdUntil: createdUntil,
      pageNumber: dto.pagination.pageNumber,
      size: dto.pagination.size,
    );
    return result;
  }
}
