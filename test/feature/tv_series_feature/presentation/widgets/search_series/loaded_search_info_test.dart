import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

void main() {
  Future<void> pumpWidget({
    required WidgetTester tester,
    required void Function(TvShowEntity) onTapCard,
    required List<TvShowEntity> tvSeriesDisplayed,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => LoadedSearchInfo(
              onTapCard: onTapCard,
              tvSeriesDisplayed: tvSeriesDisplayed,
            ),
          ),
        ),
      ),
    );
  }

  const tvShowEntity = TvShowEntity(
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

  testWidgets(
      'should render the widget correctly when widget is accessed by some page',
      (tester) async {
    var tvShowAux = const TvShowEntity();
    await mockNetworkImagesFor(
      () => pumpWidget(
        tester: tester,
        onTapCard: (TvShowEntity tvShowEntity) => tvShowAux = tvShowEntity,
        tvSeriesDisplayed: const [tvShowEntity],
      ),
    );
    await tester.pump();
    expect(find.byType(LoadedSearchInfo), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(DsCardInfo), findsOneWidget);
    expect(find.text('name'), findsOneWidget);
    expect(find.text('summary'), findsOneWidget);
    await tester.tap(find.byType(DsCardInfo));
    await tester.pump();
    expect(tvShowAux, tvShowEntity);
  });
}
