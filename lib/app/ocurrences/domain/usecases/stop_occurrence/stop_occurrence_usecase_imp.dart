import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';
import '../../repositories/occurrences_repository.dart';
import 'stop_occurrence_usecase.dart';

class StopOccurrenceUsecaseImp implements StopOccurrenceUsecase {
  final OccurrencesRepository repository;

  StopOccurrenceUsecaseImp(this.repository);

  @override
  Future<Result<Unit, Failure>> call(int occurrenceId) =>
      repository.startOccurrence(occurrenceId);
}
