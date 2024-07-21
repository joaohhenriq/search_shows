import 'package:design_system/design_system.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

class MockGetTvSeriesByName extends Mock implements GetTvSeriesByName {}

class FakeRoute extends Fake implements Route<dynamic> {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockSearchSeriesState extends Mock implements SearchSeriesState {}

void main() {
  late MockGetTvSeriesByName mockGetTvSeriesByName;
  late MockNavigatorObserver mockNavigatorObserver;
  late MockSearchSeriesState mockSearchSeriesState;

  setUp(() {
    mockGetTvSeriesByName = MockGetTvSeriesByName();
    mockNavigatorObserver = MockNavigatorObserver();
    mockSearchSeriesState = MockSearchSeriesState();
    registerFallbackValue(FakeRoute());
  });

  Map<String, dynamic> routerFeaturesMock(RouteSettings settings) =>
      <String, dynamic>{
        TvSeriesRoutes.tvSeriesDetailPage: MaterialPageRoute(
          settings: const RouteSettings(),
          builder: (context) => const Scaffold(),
        ),
      };

  Future<void> pumpWidget({required WidgetTester tester}) async {
    await tester.pumpWidget(
      MaterialApp(
        onGenerateRoute: (settings) =>
            routerFeaturesMock(settings)[settings.name],
        navigatorObservers: [mockNavigatorObserver],
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) =>
                ChangeNotifierProvider<SearchSeriesState>(
              create: (_) => mockSearchSeriesState,
              child: TvSearchSeriesPage(
                getTvSeriesByName: mockGetTvSeriesByName,
              ),
            ),
          ),
        ),
      ),
    );
  }

  group('Initial status', () {
    testWidgets('should build page successfully when status is initial',
        (tester) async {
      when(() => mockSearchSeriesState.pageStatus)
          .thenReturn(SearchSeriesStatusEnum.initial);
      await pumpWidget(tester: tester);
      await tester.pump();
      expect(find.byType(TvSearchSeriesPage), findsOneWidget);
      expect(find.byType(CenteredText), findsOneWidget);
      expect(find.text('Search for a series'), findsOneWidget);
    });
  });

  group('Loading status', () {
    testWidgets('should build page successfully when status is loading',
        (tester) async {
      when(() => mockSearchSeriesState.pageStatus)
          .thenReturn(SearchSeriesStatusEnum.loading);
      await pumpWidget(tester: tester);
      await tester.pump();
      expect(find.byType(TvSearchSeriesPage), findsOneWidget);
      expect(find.byType(CircularProgressWidget), findsOneWidget);
    });
  });

  group('Error status', () {
    testWidgets('should build page successfully when status is error',
        (tester) async {
      when(() => mockSearchSeriesState.pageStatus)
          .thenReturn(SearchSeriesStatusEnum.error);
      await pumpWidget(tester: tester);
      await tester.pump();
      expect(find.byType(TvSearchSeriesPage), findsOneWidget);
      expect(find.byType(CenteredText), findsOneWidget);
      expect(find.text('Oh, looks like something went wrong!'), findsOneWidget);
    });
  });

  group('Empty status', () {
    testWidgets('should build page successfully when status is empty',
        (tester) async {
      when(() => mockSearchSeriesState.pageStatus)
          .thenReturn(SearchSeriesStatusEnum.empty);
      await pumpWidget(tester: tester);
      await tester.pump();
      expect(find.byType(TvSearchSeriesPage), findsOneWidget);
      expect(find.byType(CenteredText), findsOneWidget);
      expect(find.text('No data available'), findsOneWidget);
    });
  });

  group('Loaded status', () {
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

    testWidgets('should build page successfully when status is loaded',
        (tester) async {
      when(() => mockSearchSeriesState.pageStatus)
          .thenReturn(SearchSeriesStatusEnum.loaded);
      when(() => mockSearchSeriesState.tvSeriesDisplayed).thenReturn([entity]);
      await mockNetworkImagesFor(() => pumpWidget(tester: tester));
      await tester.pump();
      expect(find.byType(TvSearchSeriesPage), findsOneWidget);
      expect(find.byType(LoadedSearchInfo), findsOneWidget);
    });

    testWidgets('should navigate to detail page when card is tapped',
        (tester) async {
      when(() => mockSearchSeriesState.pageStatus)
          .thenReturn(SearchSeriesStatusEnum.loaded);
      when(() => mockSearchSeriesState.tvSeriesDisplayed).thenReturn([entity]);
      await mockNetworkImagesFor(() => pumpWidget(tester: tester));
      await tester.pump();
      await tester.tap(find.byType(DsCardInfo));
      verify(() => mockNavigatorObserver.didPush(any(), any()));
    });

    group('search series', () {
      testWidgets('should not fetch data when search is called with empty text',
          (tester) async {
        when(() => mockSearchSeriesState.pageStatus)
            .thenReturn(SearchSeriesStatusEnum.loaded);
        when(() => mockSearchSeriesState.tvSeriesDisplayed)
            .thenReturn([entity]);
        await mockNetworkImagesFor(() => pumpWidget(tester: tester));
        await tester.pump();
        await tester.enterText(find.byType(DsInputField), '');
        await tester.tap(find.byType(ElevatedButton));
        verifyNever(() => mockGetTvSeriesByName(''));
        verifyNever(() => mockSearchSeriesState.updateTvSeriesDisplayed([]));
      });

      testWidgets('should fetch data when search is called', (tester) async {
        when(() => mockSearchSeriesState.pageStatus)
            .thenReturn(SearchSeriesStatusEnum.loaded);
        when(() => mockSearchSeriesState.tvSeriesDisplayed)
            .thenReturn([entity]);
        when(() => mockGetTvSeriesByName('text'))
            .thenAnswer((_) async => const Right([entity]));
        await mockNetworkImagesFor(() => pumpWidget(tester: tester));
        await tester.pump();
        await tester.enterText(find.byType(DsInputField), 'text');
        await tester.tap(find.byType(ElevatedButton));
        verify(() => mockGetTvSeriesByName('text')).called(1);
        verify(() => mockSearchSeriesState.updateTvSeriesDisplayed([entity]))
            .called(1);
      });

      testWidgets(
          'should show empty status when search is called with empty list',
          (tester) async {
        when(() => mockSearchSeriesState.pageStatus)
            .thenReturn(SearchSeriesStatusEnum.loaded);
        when(() => mockSearchSeriesState.tvSeriesDisplayed)
            .thenReturn([entity]);
        when(() => mockGetTvSeriesByName('text'))
            .thenAnswer((_) async => Left(GetTvSeriesByNameEmptyListFailure()));
        await mockNetworkImagesFor(() => pumpWidget(tester: tester));
        await tester.pump();
        await tester.enterText(find.byType(DsInputField), 'text');
        await tester.tap(find.byType(ElevatedButton));
        verify(() => mockSearchSeriesState
            .updatePageStatus(SearchSeriesStatusEnum.empty)).called(1);
      });

      testWidgets('should show error status when search is called with error',
          (tester) async {
        when(() => mockSearchSeriesState.pageStatus)
            .thenReturn(SearchSeriesStatusEnum.loaded);
        when(() => mockSearchSeriesState.tvSeriesDisplayed)
            .thenReturn([entity]);
        when(() => mockGetTvSeriesByName('text'))
            .thenAnswer((_) async => Left(GetTvSeriesByNameCatchFailure()));
        await mockNetworkImagesFor(() => pumpWidget(tester: tester));
        await tester.pump();
        await tester.enterText(find.byType(DsInputField), 'text');
        await tester.tap(find.byType(ElevatedButton));
        verify(() => mockSearchSeriesState
            .updatePageStatus(SearchSeriesStatusEnum.error)).called(1);
      });

      testWidgets(
          'should show error status when search is called with a different Failure expected',
          (tester) async {
        when(() => mockSearchSeriesState.pageStatus)
            .thenReturn(SearchSeriesStatusEnum.loaded);
        when(() => mockSearchSeriesState.tvSeriesDisplayed)
            .thenReturn([entity]);
        when(() => mockGetTvSeriesByName('text'))
            .thenAnswer((_) async => Left(GetTvSeriesByIdCatchFailure()));
        await mockNetworkImagesFor(() => pumpWidget(tester: tester));
        await tester.pump();
        await tester.enterText(find.byType(DsInputField), 'text');
        await tester.tap(find.byType(ElevatedButton));
        verify(() => mockSearchSeriesState
            .updatePageStatus(SearchSeriesStatusEnum.error)).called(1);
      });
    });
  });
}
