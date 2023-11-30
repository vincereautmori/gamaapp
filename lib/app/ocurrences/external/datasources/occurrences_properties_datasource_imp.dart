import 'package:dio/dio.dart';
import 'package:gamaapp/app/ocurrences/domain/entities/properties/properties_info.dart';
import 'package:gamaapp/app/ocurrences/infra/models/properties/occurrence_properties_model.dart';

import '../../infra/datasources/occurrence_properties_datasource.dart';

class OccurrencesPropertiesDatasourceImp
    implements OccurrencesPropertiesDatasource {
  final Dio dio;

  OccurrencesPropertiesDatasourceImp(this.dio);

  @override
  Future<OccurrencePropertiesInfo> getOccurrenceProperties() async {
    Response res = await dio.get('/occurrences/properties');

    OccurrencePropertiesInfo properties =
        OccurrencePropertiesModel.fromJson(res.data);

    return properties;
  }
}
