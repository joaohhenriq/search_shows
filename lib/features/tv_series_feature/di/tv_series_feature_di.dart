import 'package:search_series/base_app/injection/client/client.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

class TvSeriesFeatureDI implements RegisterInjectionClient {
  @override
  void registerDependencies({required InjectionClient injector}) {
    // data sources
    injector.registerFactory<TvSeriesRemoteDatasource>(
        () => TvSeriesRemoteDatasourceImpl(injector.get()));

    // repositories
    injector.registerFactory<TvSeriesRepository>(
        () => TvSeriesRepositoryImpl(remoteDatasource: injector.get()));

    // use cases
    injector.registerFactory<GetTvSeriesByName>(
        () => GetTvSeriesByNameImpl(injector.get()));
  }
}
