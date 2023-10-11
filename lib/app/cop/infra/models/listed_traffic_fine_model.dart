import 'package:gamaapp/app/cop/domain/entities/trafficFine/listed_traffic_fine_entity.dart';
import 'package:gamaapp/app/cop/domain/entities/trafficFine/listed_traffic_fine_info.dart';

class ListedTrafficFineModel extends ListedTrafficFineEntity
    implements ListedTrafficFineInfo {
  const ListedTrafficFineModel({
    required super.id,
    required super.licensePlate,
    required super.computed,
    required super.createdAt,
    required super.pageNumber,
  });
}
