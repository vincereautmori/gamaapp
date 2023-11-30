import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/ocurrences/domain/repositories/occurrences_repository.dart';
import 'package:multiple_result/multiple_result.dart';

import 'start_occurrence_usecase.dart';

class StartOccurrenceUsecaseImp implements StartOccurrenceUsecase {
  final OccurrencesRepository repository;

  StartOccurrenceUsecaseImp(this.repository);

  @override
  Future<Result<Unit, Failure>> call(int occurrenceId) =>
      repository.startOccurrence(occurrenceId);
}
