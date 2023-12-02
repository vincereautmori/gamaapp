import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/ocurrences/domain/entities/dtos/occurrence_filter_dto.dart';
import 'package:gamaapp/app/ocurrences/domain/entities/ocurrences/listed_occurrences_info.dart';
import 'package:gamaapp/shared/extensions/datetime_extension.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../repositories/occurrences_repository.dart';
import 'get_paginated_occurrences_usecase.dart';

class GetPaginatedOccurrencesUsecaseImp
    implements GetPaginatedOccurrencesUsecase {
  final OccurrencesRepository repository;

  GetPaginatedOccurrencesUsecaseImp(this.repository);

  @override
  Future<Result<List<ListedOccurrencesInfo>, Failure>> call(
    OccurrenceFilterDto dto,
  ) {
    String? createdSince = dto.createdSince?.formatDate('yyyy-MM-ddT00:00:01');
    String? createdUntil = dto.createdUntil?.formatDate('yyyy-MM-ddT23:59:59');

    return repository.getOccurrences(
      createdSince: createdSince,
      createdUntil: createdUntil,
      size: dto.pagination.size,
      pageNumber: dto.pagination.pageNumber,
    );
  }
}
