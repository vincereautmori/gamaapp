import '../../domain/entities/properties/properties_info.dart';

abstract class OccurrencesPropertiesDatasource {
  Future<OccurrencePropertiesInfo> getOccurrenceProperties();
}
