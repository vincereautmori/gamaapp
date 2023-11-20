import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/ocurrences/domain/entities/dtos/ocurrency_input.dart';
import 'package:gamaapp/app/ocurrences/domain/repositories/occurrences_repository.dart';
import 'package:multiple_result/multiple_result.dart';

import 'create_occurrence_usecase.dart';

class CreateOccurrenceUsecaseImp implements CreateOccurrenceUsecase {
  final OccurrencesRepository repository;

  CreateOccurrenceUsecaseImp(this.repository);

  @override
  Future<Result<Unit, Failure>> call(OccurrenceInput input) {
    return repository.createOccurrence(
      input.latitude,
      input.longitude,
      input.location,
      input.name,
      input.description,
      input.occurrenceStatusId,
      input.occurrenceTypeId,
      input.occurrenceUrgencyLevelId,
      input.imageUrl,
    );
  }
}
