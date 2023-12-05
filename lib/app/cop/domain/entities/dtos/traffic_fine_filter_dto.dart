import '../../../../../shared/dtos/pagination_dto.dart';

class TrafficFineFilterDto {
  final String? licensePlate;
  final DateTime? createdSince;
  final DateTime? createdUntil;
  final PaginationDto pagination;

  TrafficFineFilterDto(
      {this.licensePlate = "",
      required this.createdSince,
      required this.createdUntil,
      this.pagination = const PaginationDto(pageNumber: 1, size: 10)});
}
