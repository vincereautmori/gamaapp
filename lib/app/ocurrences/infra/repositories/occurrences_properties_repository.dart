import 'package:gamaapp/app/ocurrences/domain/errors/error.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../auth/domain/errors/errors.dart';
import '../../domain/entities/properties/properties_info.dart';
import '../../domain/repositories/occurrences_properties_repository.dart';
import '../datasources/occurrence_properties_datasource.dart';

class OccurrencesPropertiesRepositoryImp
    implements OccurrencesPropertiesRepository {
  final OccurrencesPropertiesDatasource datasource;

  OccurrencesPropertiesRepositoryImp(this.datasource);

  @override
  Future<Result<OccurrencePropertiesInfo, Failure>> getProperties() async {
    try {
      OccurrencePropertiesInfo properties =
          await datasource.getOccurrenceProperties();
      return Success(properties);
    } catch (e) {
      return Error(OccurrenceError(message: "$e"));
    }
  }
}
