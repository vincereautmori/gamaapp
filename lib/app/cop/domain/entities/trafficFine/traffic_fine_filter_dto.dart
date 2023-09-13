import 'package:intl/intl.dart';

class TrafficFineFilterDto {
  final DateTime? createdSince;
  final DateTime? createdUntil;

  String? formatToString(DateTime? date) =>
      date != null ? DateFormat('yyyy-MM-dd').format(date) : null;

  TrafficFineFilterDto({
    required this.createdSince,
    required this.createdUntil,
  });
}
