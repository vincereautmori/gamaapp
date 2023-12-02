import '../../../../../shared/dtos/pagination_dto.dart';

class OccurrenceFilterDto {
  final DateTime? createdSince;
  final DateTime? createdUntil;
  final PaginationDto pagination;

  OccurrenceFilterDto(
      {required this.createdSince,
      required this.createdUntil,
      this.pagination = const PaginationDto(pageNumber: 1, size: 10)});
}
