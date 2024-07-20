class NetworkResponse<T> {
  NetworkResponse({
    required this.data,
    this.statusCode,
    this.headers,
  });

  final dynamic data;
  final int? statusCode;
  final Map<String, dynamic>? headers;
}