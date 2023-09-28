class TrafficFineFilterDto {
  final String? licensePlate;
  final DateTime? createdSince;
  final DateTime? createdUntil;

  TrafficFineFilterDto({
    this.licensePlate = "",
    required this.createdSince,
    required this.createdUntil,
  });
}
