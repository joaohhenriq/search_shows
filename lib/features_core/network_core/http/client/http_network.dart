import 'package:search_series/features_core/network_core/network_core.dart';

abstract class HttpNetwork {
  Future<NetworkResponse<T>> get<T>(
      String pathUrl, {
        Map<String, dynamic>? queryParameters,
      });
  Future<NetworkResponse<T>> post<T>(
      String pathUrl, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      });
  Future<NetworkResponse<T>> put<T>(
      String pathUrl, {
        Object? data,
        Map<String, dynamic>? queryParameters,
      });
}