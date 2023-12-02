import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/ocurrences/domain/entities/dtos/occurrence_filter_dto.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../entities/ocurrences/listed_occurrences_info.dart';

abstract class GetPaginatedOccurrencesUsecase {
  Future<Result<List<ListedOccurrencesInfo>, Failure>> call(
    OccurrenceFilterDto dto,
  );
}
