import 'package:gamaapp/app/cop/domain/entities/trafficViolations/traffic_violation_info.dart';

abstract class TrafficFineInfo {
  int get id;
  String get licensePlate;
  double get latitude;
  double get longitude;
  bool get active;
  bool get computed;
  String get imageUrl;
  bool get deleted;
  DateTime get createdAt;
  List<TrafficViolationInfo> get trafficViolations;
}
