import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/base_app/injection/injection.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';
import 'package:search_series/features_core/network_core/network_core.dart';

class MockHttp extends Mock implements HttpNetwork {}

void main() {
  late MockHttp mockHttp;

  setUpAll(() async {
    mockHttp = MockHttp();

    Injector.I.registerFactory<HttpNetwork>(
      () => mockHttp,
    );
  });

  test('Should test inject TvSeriesFeatureDI was successful', () async {
    TvSeriesFeatureDI().registerDependencies(injector: Injector.I);

    // Datasources
    expect(
      Injector.I.get<TvSeriesRemoteDatasource>().runtimeType,
      TvSeriesRemoteDatasourceImpl,
    );

    // Repositories
    expect(
      Injector.I.get<TvSeriesRepository>().runtimeType,
      TvSeriesRepositoryImpl,
    );

    // Use cases
    expect(
      Injector.I.get<GetTvSeriesByName>().runtimeType,
      GetTvSeriesByNameImpl,
    );
    expect(
      Injector.I.get<GetTvSeriesById>().runtimeType,
      GetTvSeriesByIdImpl,
    );
  });
}
