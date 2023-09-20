class TrafficFineInputDto {
  final String licensePlate;
  final double latitude;
  final double longitude;
  final List<Map<String, int>> trafficViolations;
  final String imageUrl;

  TrafficFineInputDto({
    required this.licensePlate,
    required this.latitude,
    required this.longitude,
    required this.trafficViolations,
    required this.imageUrl,
  });
}
