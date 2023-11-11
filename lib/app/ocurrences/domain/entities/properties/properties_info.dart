class PropertiesInfo {
  final int id;
  final String name;

  PropertiesInfo({
    required this.id,
    required this.name,
  });

  factory PropertiesInfo.fromJson(Map<String, dynamic> json) => PropertiesInfo(
        id: json['id'],
        name: json['name'],
      );
}

abstract class OccurrencePropertiesInfo {
  List<PropertiesInfo> get urgencyLevels;
  List<PropertiesInfo> get types;
  List<PropertiesInfo> get status;
}
