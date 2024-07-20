import 'package:dio/dio.dart';
import 'package:search_series/features_core/network_core/network_core.dart';

class HttpNetworkImpl implements HttpNetwork {
  HttpNetworkImpl({
    required this.client,
    required this.httpInterceptor,
  }) {
    client
      ..interceptors.clear()
      ..interceptors.add(httpInterceptor);
  }

  final Dio client;
  final HttpInterceptor httpInterceptor;

  @override
  Future<NetworkResponse<T>> get<T>(
    String pathUrl, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await client.get(
      pathUrl,
      queryParameters: queryParameters,
    );
    return NetworkResponse(
      data: response.data,
      statusCode: response.statusCode,
      headers: response.headers.map,
    );
  }

  @override
  Future<NetworkResponse<T>> post<T>(
    String pathUrl, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await client.post(
      pathUrl,
      data: data,
      queryParameters: queryParameters,
      options: headers != null ? Options(headers: headers) : null,
    );
    return NetworkResponse(
      data: response.data,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<NetworkResponse<T>> put<T>(
    String pathUrl, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await client.put(
      pathUrl,
      data: data,
      queryParameters: queryParameters,
    );
    return NetworkResponse(
      data: response.data,
      statusCode: response.statusCode,
    );
  }
}
