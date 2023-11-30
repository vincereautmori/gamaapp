import 'package:dio/dio.dart';
import 'package:gamaapp/app/ocurrences/domain/entities/ocurrences/ocurrences_info.dart';
import 'package:gamaapp/app/ocurrences/domain/errors/error.dart';
import 'package:gamaapp/app/ocurrences/infra/datasources/occurrences_datasource.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../shared/utils/loading.dart';
import '../../../auth/domain/errors/errors.dart';
import '../../domain/repositories/occurrences_repository.dart';

class OccurrencesRepositoryImp with Loading implements OccurrencesRepository {
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

  @override
  Future<Result<Unit, Failure>> createOccurrence(
    double latitude,
    double longitude,
    String location,
    String name,
    String description,
    int occurrenceStatusId,
    int occurrenceTypeId,
    int occurrenceUrgencyLevelId,
    String imageUrl,
  ) async {
    try {
      await datasource.createOccurrence(
        latitude,
        longitude,
        location,
        name,
        description,
        occurrenceStatusId,
        occurrenceTypeId,
        occurrenceUrgencyLevelId,
        imageUrl,
      );
      return Success.unit();
    } on DioException catch (e) {
      String errorMessage =
          e.response?.data["createOccurrenceCommand.Location"]?.first ??
              "Algo deu errado";
      return Error(OccurrenceError(message: errorMessage));
    }
  }

  @override
  Future<Result<OccurrencesInfo, Failure>> getOccurrenceById(int id) async {
    try {
      OccurrencesInfo info = await datasource.getOccurrenceById(id);
      return Success(info);
    } catch (e) {
      return Error(OccurrenceError(message: '$e'));
    }
  }
}
