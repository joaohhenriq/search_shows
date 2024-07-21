import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

class MockGetTvSeriesById extends Mock implements GetTvSeriesById {}

class MockTvSeriesDetailState extends Mock implements TvSeriesDetailState {}

void main() {
  late MockGetTvSeriesById mockGetTvSeriesById;
  late MockTvSeriesDetailState mockTvSeriesDetailState;

  setUp(() {
    mockGetTvSeriesById = MockGetTvSeriesById();
    mockTvSeriesDetailState = MockTvSeriesDetailState();

    when(() => mockTvSeriesDetailState.tvSeriesDetailsStatus)
        .thenReturn(TvSeriesDetailsStatus.loading);
    when(() => mockTvSeriesDetailState.tvShowDetails)
        .thenReturn(const TvShowEntity());
  });

  const id = 1;

  Future<void> pumpWidget({required WidgetTester tester}) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) =>
                ChangeNotifierProvider<TvSeriesDetailState>(
              create: (_) => mockTvSeriesDetailState,
              child: SeriesDetailPage(
                getTvSeriesById: mockGetTvSeriesById,
                tvShowId: id,
              ),
            ),
          ),
        ),
      ),
    );
  }

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

  group('fetch info', () {
    testWidgets('should load data successfully when use case returns Right',
        (tester) async {
      when(() => mockGetTvSeriesById(id))
          .thenAnswer((_) async => const Right(entity));
      await pumpWidget(tester: tester);
      await tester.pump();
      verify(() => mockTvSeriesDetailState.updateTvShowDetails(entity));
      verify(() => mockGetTvSeriesById(id));
    });

    testWidgets('should show error message when use case returns Left',
        (tester) async {
      when(() => mockGetTvSeriesById(id))
          .thenAnswer((_) async => Left(GetTvSeriesByIdCatchFailure()));
      await pumpWidget(tester: tester);
      await tester.pump();
      verify(() => mockTvSeriesDetailState
          .updateTvSeriesDetailsStatus(TvSeriesDetailsStatus.error));
      verify(() => mockGetTvSeriesById(id));
    });
  });
}
