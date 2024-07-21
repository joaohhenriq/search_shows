import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';
import 'package:search_series/features_core/network_core/network_core.dart';
import 'package:search_series/features_util/apis.dart';

class MockHttp extends Mock implements HttpNetwork {}

void main() {
  late TvSeriesRemoteDatasourceImpl dataSource;
  late MockHttp mockHttp;

  setUp(() {
    mockHttp = MockHttp();
    dataSource = TvSeriesRemoteDatasourceImpl(mockHttp);
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

  final mockResponseJson = [
    {
      'show': {
        'id': 1,
        'name': 'name',
        'summary': 'summary',
        'genres': ['genres'],
        'schedule': {
          'days': ['scheduleDays'],
          'time': 'scheduleTime',
        },
        'premiered': 'premiered',
        'ended': 'ended',
        'image': {
          'medium': 'mediumImage',
          'original': 'originalImage',
        },
      },
    },
  ];

  group('getTvSeriesByName', () {
    const search = 'test';
    test('should return TvShowModel when the response code is success',
        () async {
      when(() => mockHttp.get('$tvMazeUrl/search/shows?q=$search')).thenAnswer(
        (_) async => NetworkResponse(
          data: mockResponseJson,
          statusCode: 200,
        ),
      );
      final result = await dataSource.getTvSeriesByName(search);
      expect(result, [mockModel]);
      verify(() => mockHttp.get('$tvMazeUrl/search/shows?q=$search')).called(1);
      verifyNever(() => mockHttp.post(any()));
      verifyNever(() => mockHttp.put(any()));
    });

    test(
        'should throw a Exception when the response code is different from a success result',
        () async {
      when(() => mockHttp.get('$tvMazeUrl/search/shows?q=$search')).thenAnswer(
        (_) async => NetworkResponse(
          data: '',
          statusCode: 500,
        ),
      );
      final call = dataSource.getTvSeriesByName;
      expect(
        () => call(search),
        throwsA(const TypeMatcher<Exception>()),
      );
      verify(() => mockHttp.get('$tvMazeUrl/search/shows?q=$search')).called(1);
      verifyNever(() => mockHttp.post(any()));
      verifyNever(() => mockHttp.put(any()));
    });
  });

  group('getTvSeriesById', () {
    const id = 1;
    test('should return TvShowModel when the response code is success',
        () async {
      when(() => mockHttp.get('$tvMazeUrl/shows/$id')).thenAnswer(
        (_) async => NetworkResponse(
          data: mockResponseJson.first['show'],
          statusCode: 200,
        ),
      );
      final result = await dataSource.getTvSeriesById(id);
      expect(result, mockModel);
      verify(() => mockHttp.get('$tvMazeUrl/shows/$id')).called(1);
      verifyNever(() => mockHttp.post(any()));
      verifyNever(() => mockHttp.put(any()));
    });

    test(
        'should throw a Exception when the response code is different from a success result',
        () async {
      when(() => mockHttp.get('$tvMazeUrl/shows/$id')).thenAnswer(
        (_) async => NetworkResponse(
          data: '',
          statusCode: 500,
        ),
      );
      final call = dataSource.getTvSeriesById;
      expect(
        () => call(id),
        throwsA(const TypeMatcher<Exception>()),
      );
      verify(() => mockHttp.get('$tvMazeUrl/shows/$id')).called(1);
      verifyNever(() => mockHttp.post(any()));
      verifyNever(() => mockHttp.put(any()));
    });
  });
}
