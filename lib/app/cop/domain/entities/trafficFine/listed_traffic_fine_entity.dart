import 'package:equatable/equatable.dart';

class ListedTrafficFineEntity extends Equatable {
  final int id;
  final String licensePlate;
  final bool computed;
  final DateTime createdAt;

  const ListedTrafficFineEntity({
    required this.id,
    required this.licensePlate,
    required this.computed,
    required this.createdAt,
  });

  @override
  List get props => [
        id,
        licensePlate,
        computed,
        createdAt,
      ];
}
