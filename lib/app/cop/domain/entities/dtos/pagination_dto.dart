class PaginationDto {
  final int pageNumber;
  final int size;

  const PaginationDto({
    this.pageNumber = 1,
    this.size = 10,
  });

  PaginationDto copyWith({
    int? pageNumber,
    int? size,
  }) =>
      PaginationDto(
        pageNumber: pageNumber ?? this.pageNumber,
        size: size ?? this.size,
      );
}
