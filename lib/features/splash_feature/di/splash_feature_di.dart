import 'package:search_series/base_app/injection/client/client.dart';
import 'package:search_series/features/splash_feature/splash_feature.dart';

class SplashFeatureDI implements RegisterInjectionClient {
  @override
  void registerDependencies({required InjectionClient injector}) {
    // data sources
    injector.registerFactory<SplashDataSource>(
        () => SplashDataSourceImpl(injector.get()));

    // repositories
    injector.registerFactory<SplashRepository>(
        () => SplashRepositoryImpl(datasource: injector.get()));

    // use cases
    injector.registerFactory<IsUserAuthenticated>(
        () => IsUserAuthenticatedImpl(repository: injector.get()));
  }
}
