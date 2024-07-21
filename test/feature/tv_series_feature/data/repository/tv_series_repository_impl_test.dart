import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

class MockTvSeriesRemoteDatasource extends Mock
    implements TvSeriesRemoteDatasource {}

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDatasource mockTvSeriesRemoteDatasource;

  setUp(() {
    mockTvSeriesRemoteDatasource = MockTvSeriesRemoteDatasource();
    repository = TvSeriesRepositoryImpl(
      remoteDatasource: mockTvSeriesRemoteDatasource,
    );
  });

  const mockModel = TvShowModel(
    id: 1,
    name: 'name',
    summary: 'summary',
    genres: ['genres'],
    scheduleDays: ['scheduleDays'],
    scheduleTime: 'scheduleTime',
    premiered: 'premiered',
    ended: 'ended',
    mediumImage: 'mediumImage',
    originalImage: 'originalImage',
  );

  group('getTvSeriesByName', () {
    const name = 'name';
    test('should return Result right when data source responds successfully',
        () async {
      when(() => mockTvSeriesRemoteDatasource.getTvSeriesByName(name))
          .thenAnswer((_) async => [mockModel]);
      final result = await repository.getTvSeriesByName(name);
      expect(result.isRight, true);
      expect(result.right, [mockModel]);
      verify(() => mockTvSeriesRemoteDatasource.getTvSeriesByName(name))
          .called(1);
    });
    test(
        'should return Result left when data source responds unsuccessfully with some exception',
        () async {
      when(() => mockTvSeriesRemoteDatasource.getTvSeriesByName(name))
          .thenThrow(Exception());
      final result = await repository.getTvSeriesByName(name);
      expect(result.isLeft, true);
      expect(result.left, const TypeMatcher<GetTvSeriesByNameCatchFailure>());
      verify(() => mockTvSeriesRemoteDatasource.getTvSeriesByName(name))
          .called(1);
    });
    test(
        'should return Result left when data source responds successfully with empty list',
        () async {
      when(() => mockTvSeriesRemoteDatasource.getTvSeriesByName(name))
          .thenAnswer((_) async => []);
      final result = await repository.getTvSeriesByName(name);
      expect(result.isLeft, true);
      expect(
          result.left, const TypeMatcher<GetTvSeriesByNameEmptyListFailure>());
      verify(() => mockTvSeriesRemoteDatasource.getTvSeriesByName(name))
          .called(1);
    });
  });

  group('getTvSeriesById', () {
    test('should return Result right when data source responds successfully',
        () async {
      when(() => mockTvSeriesRemoteDatasource.getTvSeriesById(1))
          .thenAnswer((_) async => mockModel);
      final result = await repository.getTvSeriesById(1);
      expect(result.isRight, true);
      expect(result.right, mockModel);
      verify(() => mockTvSeriesRemoteDatasource.getTvSeriesById(1)).called(1);
    });
    test(
        'should return Result left when data source responds unsuccessfully with some exception',
        () async {
      when(() => mockTvSeriesRemoteDatasource.getTvSeriesById(1))
          .thenThrow(Exception());
      final result = await repository.getTvSeriesById(1);
      expect(result.isLeft, true);
      expect(result.left, const TypeMatcher<GetTvSeriesByIdCatchFailure>());
      verify(() => mockTvSeriesRemoteDatasource.getTvSeriesById(1)).called(1);
    });
  });
}
