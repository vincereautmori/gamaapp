import 'package:multiple_result/multiple_result.dart';

import '/app/auth/domain/errors/errors.dart';
import '/app/cop/domain/entities/trafficFine/listed_traffic_fina_info.dart';

abstract class TrafficFineRepository {
  Future<Result<List<ListedTrafficFineInfo>, Failure>> fetchTrafficFine({
    String? createdSince,
    String? createdUntil,
  });
}
