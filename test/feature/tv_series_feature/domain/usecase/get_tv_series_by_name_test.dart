import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

class MockRepository extends Mock implements TvSeriesRepository {}

void main() {
  late GetTvSeriesByNameImpl usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetTvSeriesByNameImpl(mockRepository);
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

  group('GetTvSeriesByNameImpl', () {
    const name = 'name';
    test(
        'should return a list with TvShowEntity when the call to the repository is successful',
        () async {
      when(() => mockRepository.getTvSeriesByName(name)).thenAnswer(
        (_) async => const Right([entity]),
      );
      final result = await usecase(name);
      expect(result.isRight, true);
      expect(result.right, [entity]);
      verify(() => mockRepository.getTvSeriesByName(name)).called(1);
    });

    test(
        'should return a GetTvSeriesByNameEmptyListFailure when the call to the repository is successful but the list is empty',
        () async {
      when(() => mockRepository.getTvSeriesByName(name)).thenAnswer(
        (_) async => Left(GetTvSeriesByNameEmptyListFailure()),
      );
      final result = await usecase(name);
      expect(result.isLeft, true);
      expect(
          result.left, const TypeMatcher<GetTvSeriesByNameEmptyListFailure>());
      verify(() => mockRepository.getTvSeriesByName(name)).called(1);
    });
  });
}
