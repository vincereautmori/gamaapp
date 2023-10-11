import 'package:equatable/equatable.dart';

class ListedTrafficFineEntity extends Equatable {
  final int id;
  final String licensePlate;
  final bool computed;
  final DateTime createdAt;
  final int pageNumber;

  const ListedTrafficFineEntity({
    required this.id,
    required this.licensePlate,
    required this.computed,
    required this.createdAt,
    required this.pageNumber,
  });

  @override
  List get props => [
        id,
        licensePlate,
        computed,
        createdAt,
        pageNumber,
      ];
}
