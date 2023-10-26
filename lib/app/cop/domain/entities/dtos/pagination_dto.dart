class PaginationDto {
  final int pageNumber;
  final int size;
  final int count;

  const PaginationDto({
    this.pageNumber = 1,
    this.size = 10,
    this.count = 0,
  });

  PaginationDto copyWith({
    int? pageNumber,
    int? size,
    int? count,
  }) =>
      PaginationDto(
        pageNumber: pageNumber ?? this.pageNumber,
        size: size ?? this.size,
        count: count ?? this.count,
      );
}
