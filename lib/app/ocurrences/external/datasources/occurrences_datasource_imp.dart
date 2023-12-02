import 'package:dio/dio.dart';
import 'package:gamaapp/app/ocurrences/domain/entities/ocurrences/ocurrences_info.dart';
import 'package:gamaapp/app/ocurrences/infra/models/occurrences/listed_occurrences_model.dart';

import '../../infra/datasources/occurrences_datasource.dart';
import '../../infra/models/occurrences/ocurrences_model.dart';
import '../../presenter/states/ocurrences_states.dart';

class OccurrencesDatasourceImp implements OccurrencesDatasource {
  final Dio dio;

  OccurrencesDatasourceImp(this.dio);

  @override
  Future<void> startOccurrence(int occurrenceId) =>
      dio.post('/occurrences/$occurrenceId/start');

  @override
  Future<void> stopOccurrence(int occurrenceId) =>
      dio.post('/occurrences/$occurrenceId/close');

  @override
  Future<void> createOccurrence(
    double latitude,
    double longitude,
    String location,
    String name,
    String description,
    int occurrenceStatusId,
    int occurrenceTypeId,
    int occurrenceUrgencyLevelId,
    String imageUrl,
  ) =>
      dio.post('/occurrences', data: {
        "latitude": latitude,
        "longitude": longitude,
        "location": location,
        "name": name,
        "description": description,
        "occurrenceStatusId": occurrenceStatusId,
        "occurrenceTypeId": occurrenceTypeId,
        "occurrenceUrgencyLevelId": occurrenceUrgencyLevelId,
        "imageUrl": imageUrl,
      });

  @override
  Future<OccurrencesInfo> getOccurrenceById(int occurrenceId) async {
    Response res = await dio.get('/occurrences/$occurrenceId');
    OccurrencesInfo info = OcurrencesModel.fromJson(res.data);
    return info;
  }

  @override
  Future<List<ListedOccurrencesModel>> fetchOccurrences({
    String? createdSince,
    String? createdUntil,
    required int size,
    required int pageNumber,
  }) async {
    Map<String, dynamic>? params = {
      "size": size,
      "pageNumber": pageNumber,
    };

    if (createdSince != null) {
      params["createdSince"] = createdSince;
    }

    if (createdUntil != null) {
      params["createdUntil"] = createdUntil;
    }

    Response res = await dio.get('/occurrences', queryParameters: params);

    int pageAt = res.data['pageNumber'];

    OccurrenceStates.pagination.value =
        OccurrenceStates.pagination.value.copyWith(count: res.data['count']);

    List<ListedOccurrencesModel> occurrences =
        ListedOccurrencesModel.fromListJson(res.data['results'], pageAt);

    return occurrences;
  }
}
