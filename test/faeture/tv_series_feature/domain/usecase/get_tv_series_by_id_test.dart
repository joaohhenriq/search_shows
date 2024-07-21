import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

class MockRepository extends Mock implements TvSeriesRepository {}

void main() {
  late GetTvSeriesByIdImpl usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetTvSeriesByIdImpl(mockRepository);
  });

  const entity = TvShowEntity(
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

  group('GetTvSeriesById', () {
    const id = 1;
    test(
        'should return a TvShowEntity when the call to the repository is successful',
        () async {
      when(() => mockRepository.getTvSeriesById(id)).thenAnswer(
        (_) async => const Right(entity),
      );
      final result = await usecase(id);
      expect(result.isRight, true);
      expect(result.right, entity);
      verify(() => mockRepository.getTvSeriesById(id)).called(1);
    });

    test(
        'should return a Failure when the call to the repository is unsuccessful',
        () async {
      when(() => mockRepository.getTvSeriesById(id)).thenAnswer(
        (_) async => Left(GetTvSeriesByIdCatchFailure()),
      );
      final result = await usecase(id);
      expect(result.isRight, false);
      expect(result.left, const TypeMatcher<GetTvSeriesByIdCatchFailure>());
      verify(() => mockRepository.getTvSeriesById(id)).called(1);
    });
  });
}
