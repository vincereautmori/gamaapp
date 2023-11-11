import 'package:gamaapp/app/ocurrences/domain/errors/error.dart';
import 'package:gamaapp/app/ocurrences/infra/datasources/occurrences_datasource.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../auth/domain/errors/errors.dart';
import '../../domain/repositories/occurrences_repository.dart';

class OccurrencesRepositoryImp implements OccurrencesRepository {
  final OccurrencesDatasource datasource;

  OccurrencesRepositoryImp(this.datasource);

  @override
  Future<Result<Unit, Failure>> startOccurrence(int occurrenceId) async {
    try {
      await datasource.startOccurrence(occurrenceId);
      return Success.unit();
    } catch (e) {
      return Error(OccurrenceError(message: "$e"));
    }
  }

  @override
  Future<Result<Unit, Failure>> stopOccurrence(int occurrenceId) async {
    try {
      await datasource.stopOccurrence(occurrenceId);
      return Success.unit();
    } catch (e) {
      return Error(OccurrenceError(message: "$e"));
    }
  }
}
