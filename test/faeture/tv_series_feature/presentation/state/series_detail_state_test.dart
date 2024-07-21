import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

class MockCallbackFunction extends Mock {
  void call();
}

void main() {
  late TvSeriesDetailState provider;
  late MockCallbackFunction notifyListenerCallback;

  void setUpTest() {
    notifyListenerCallback = MockCallbackFunction();
    reset(notifyListenerCallback);

    provider = TvSeriesDetailState()..addListener(notifyListenerCallback.call);
  }

  group('updateTvSeriesDetailsStatus', () {
    test('Should change the value regarding value passed as param', () async {
      setUpTest();
      provider.updateTvSeriesDetailsStatus(TvSeriesDetailsStatus.loaded);
      expect(provider.tvSeriesDetailsStatus, TvSeriesDetailsStatus.loaded);
      verify(() => notifyListenerCallback()).called(1);
    });
  });

  group('updateTvShowDetails', () {
    test('Should change the value regarding value passed as param', () async {
      setUpTest();
      const mockTvShowEntity = TvShowEntity(
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
      provider.updateTvShowDetails(mockTvShowEntity);
      expect(provider.tvSeriesDetailsStatus, TvSeriesDetailsStatus.loaded);
      expect(provider.tvShowDetails, mockTvShowEntity);
      verify(() => notifyListenerCallback()).called(1);
    });
  });
}
