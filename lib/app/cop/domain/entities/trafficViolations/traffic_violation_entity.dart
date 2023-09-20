import 'package:equatable/equatable.dart';

class TrafficViolationEntity extends Equatable {
  final int id;
  final String code;
  final String name;
  final bool active;

  const TrafficViolationEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.active,
  });

  @override
  List<Object> get props => [id, code, name, active];
}
