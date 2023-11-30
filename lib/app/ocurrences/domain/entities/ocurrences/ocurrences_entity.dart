import 'package:equatable/equatable.dart';

class OcurrencesEntity extends Equatable {
  final int id;
  final int userId;
  final double latitude;
  final double longitude;
  final String location;
  final String name;
  final String description;
  final bool active;
  final String urgencyLevel;
  final String occurrenceType;
  final String status;
  final String imageUrl;

  const OcurrencesEntity({
    required this.id,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.name,
    required this.description,
    required this.active,
    required this.urgencyLevel,
    required this.occurrenceType,
    required this.status,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [
        id,
        userId,
        latitude,
        longitude,
        location,
        name,
        description,
        active,
        urgencyLevel,
        occurrenceType,
        status,
        imageUrl,
      ];
}
