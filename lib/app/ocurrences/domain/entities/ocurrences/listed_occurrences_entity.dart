import 'package:equatable/equatable.dart';

class ListedOccurrencesEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String occurrenceUrgencyLevel;
  final String occurrenceType;
  final String status;
  final bool active;
  final int pageNumber;

  const ListedOccurrencesEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.occurrenceUrgencyLevel,
      required this.occurrenceType,
      required this.status,
      required this.active,
      required this.pageNumber});

  @override
  List<Object> get props => [
        id,
        name,
        description,
        occurrenceUrgencyLevel,
        occurrenceType,
        status,
        active,
        pageNumber,
      ];
}
