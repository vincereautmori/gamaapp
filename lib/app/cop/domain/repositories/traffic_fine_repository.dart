import 'package:multiple_result/multiple_result.dart';

import '/app/auth/domain/errors/errors.dart';
import '../entities/trafficFine/listed_traffic_fine_info.dart';

abstract class TrafficFineRepository {
  Future<Result<List<ListedTrafficFineInfo>, Failure>> fetchTrafficFine({
    String? createdSince,
    String? createdUntil,
  });
}
