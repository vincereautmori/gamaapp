import 'package:gamaapp/app/ocurrences/domain/repositories/occurrences_repository.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';
import '../../entities/ocurrences/ocurrences_info.dart';
import 'load_occurrence_data_usecase.dart';

class LoadOccurrenceDataUsecaseImp implements LoadOccurrenceDataUsecase {
  final OccurrencesRepository repository;

  LoadOccurrenceDataUsecaseImp(this.repository);

  @override
  Future<Result<OccurrencesInfo, Failure>> call(int id) =>
      repository.getOccurrenceById(id);
}
