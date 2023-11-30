import 'package:equatable/equatable.dart';

import 'properties_info.dart';

class OccurrencePropertiesEntity extends Equatable {
  final List<PropertiesInfo> urgencyLevels;
  final List<PropertiesInfo> types;
  final List<PropertiesInfo> status;

  const OccurrencePropertiesEntity({
    required this.urgencyLevels,
    required this.types,
    required this.status,
  });

  @override
  List<Object> get props => [
        urgencyLevels,
        types,
        status,
      ];
}
