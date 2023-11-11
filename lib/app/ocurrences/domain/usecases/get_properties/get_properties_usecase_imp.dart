import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/ocurrences/domain/entities/properties/properties_info.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../repositories/occurrences_properties_repository.dart';
import 'get_properties_usecase.dart';

class GetPropertiesUsecaseImp implements GetPropertiesUsecase {
  final OccurrencesPropertiesRepository repository;

  GetPropertiesUsecaseImp(this.repository);

  @override
  Future<Result<OccurrencePropertiesInfo, Failure>> call() =>
      repository.getProperties();
}
