import 'package:gamaapp/app/cop/infra/models/listed_traffic_fine_model.dart';

abstract class TrafficFineDatasource {
  Future<List<ListedTrafficFineModel>> fetchTrafficFines({
    String? createdSince,
    String? createdUntil,
  });
}
