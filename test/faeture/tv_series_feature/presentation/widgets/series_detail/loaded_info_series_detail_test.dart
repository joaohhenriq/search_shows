import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

void main() {
  Future<void> pumpWidget({
    required WidgetTester tester,
    required TvShowEntity tvShowEntity,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => LoadedInfoSeriesDetail(
              tvShowEntity: tvShowEntity,
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
    await mockNetworkImagesFor(
      () => pumpWidget(
        tester: tester,
        tvShowEntity: tvShowEntity,
      ),
    );
    await tester.pump();
    expect(find.byType(LoadedInfoSeriesDetail), findsOneWidget);
    expect(find.byType(ImageNetwork), findsOneWidget);
    expect(find.text('name'), findsOneWidget);
    expect(find.text('summary'), findsOneWidget);
  });
}
