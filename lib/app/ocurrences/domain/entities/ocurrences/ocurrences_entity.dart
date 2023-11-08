import 'package:equatable/equatable.dart';

class OcurrencesEntity extends Equatable {
  final DateTime createdAt;
  final String name;
  final int occurrenceId;
  final double latitude;
  final double longitude;
  final String location;
  final String occurrenceName;
  final String statusName;
  final String occurrenceUrgencyLevelName;
  final String occurrenceTypeName;
  final int userId;
  final String userName;
  final bool active;

  const OcurrencesEntity({
    required this.createdAt,
    required this.name,
    required this.occurrenceId,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.occurrenceName,
    required this.statusName,
    required this.occurrenceUrgencyLevelName,
    required this.occurrenceTypeName,
    required this.userId,
    required this.userName,
    required this.active,
  });

  @override
  List<Object> get props => [
        createdAt,
        name,
        occurrenceId,
        latitude,
        longitude,
        location,
        occurrenceName,
        statusName,
        occurrenceUrgencyLevelName,
        occurrenceTypeName,
        userId,
        userName,
        active,
      ];
}
