import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

class MockCallbackFunction extends Mock {
  void call();
}

void main() {
  late SearchSeriesState provider;
  late MockCallbackFunction notifyListenerCallback;

  void setUpTest() {
    notifyListenerCallback = MockCallbackFunction();
    reset(notifyListenerCallback);

    provider = SearchSeriesState()..addListener(notifyListenerCallback.call);
  }

  group('updatePageStatus', () {
    test('Should change the value regarding value passed as param', () async {
      setUpTest();
      provider.updatePageStatus(SearchSeriesStatusEnum.loaded);
      expect(provider.pageStatus, SearchSeriesStatusEnum.loaded);
      verify(() => notifyListenerCallback()).called(1);
    });
  });

  group('updateTvSeriesDisplayed', () {
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
      provider.updateTvSeriesDisplayed([mockTvShowEntity]);
      expect(provider.pageStatus, SearchSeriesStatusEnum.loaded);
      expect(provider.tvSeriesDisplayed, [mockTvShowEntity]);
      verify(() => notifyListenerCallback()).called(1);
    });
  });
}
