class PaginatedResponse<T> {
  final int pageIndex;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  final List<T> data;

  const PaginatedResponse({
    required this.pageIndex,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.data,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return PaginatedResponse<T>(
      pageIndex: (json['pageIndex'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      data: (json['data'] as List)
          .map((item) => fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(),
    );
  }
}
