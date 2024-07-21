import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:search_series/base_app/injection/injection.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockGetTvSeriesByName extends Mock implements GetTvSeriesByName {}

class MockGetTvSeriesById extends Mock implements GetTvSeriesById {}

void main() {
  late TvSeriesRouter router;
  late MockBuildContext mockBuildContext;
  late MockGetTvSeriesByName mockGetTvSeriesByName;
  late MockGetTvSeriesById mockGetTvSeriesById;

  Injector.I.registerFactory<GetTvSeriesByName>(() => mockGetTvSeriesByName);

  Injector.I.registerFactory<GetTvSeriesById>(() => mockGetTvSeriesById);

  setUpAll(() {
    mockBuildContext = MockBuildContext();
    mockGetTvSeriesByName = MockGetTvSeriesByName();
    mockGetTvSeriesById = MockGetTvSeriesById();
    router = TvSeriesRouter();
  });

  group('getRoutes', () {
    test('should return a page typed SearchSeriesState', () {
      final MaterialPageRoute<dynamic> feature = router.getRoutes(
        const RouteSettings(),
      )[TvSeriesRoutes.tvSeriesPage];
      final call = feature.builder;
      expect(
        call(mockBuildContext),
        isA<ChangeNotifierProvider<SearchSeriesState>>(),
      );
    });

    test('should return a page typed SeriesDetailPage', () {
      final MaterialPageRoute<dynamic> feature = router.getRoutes(
        const RouteSettings(arguments: 1),
      )[TvSeriesRoutes.tvSeriesDetailPage];
      final call = feature.builder;
      expect(
        call(mockBuildContext),
        isA<ChangeNotifierProvider<TvSeriesDetailState>>(),
      );
    });
  });
}
