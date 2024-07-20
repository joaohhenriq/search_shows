import 'package:dio/dio.dart';
import 'package:search_series/base_app/injection/injection.dart';
import 'package:search_series/features_core/network_core/network_core.dart';

class HttpDI implements RegisterInjectionClient {
  @override
  void registerDependencies({required InjectionClient injector}) {
    injector.registerFactory<HttpNetwork>(
      () => HttpNetworkImpl(client: Dio(), httpInterceptor: injector.get()),
    );
    injector.registerFactory<HttpInterceptor>(
      () => HttpInterceptor(),
    );
  }
}
