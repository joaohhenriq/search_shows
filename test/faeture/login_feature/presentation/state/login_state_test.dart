import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/features/login_feature/login_feature.dart';

class MockCallbackFunction extends Mock {
  void call();
}

void main() {
  late LoginState provider;
  late MockCallbackFunction notifyListenerCallback;

  void setUpTest() {
    notifyListenerCallback = MockCallbackFunction();
    reset(notifyListenerCallback);

    provider = LoginState()..addListener(notifyListenerCallback.call);
  }

  group('updateLoading', () {
    test('Should change the value regarding value passed as param', () async {
      setUpTest();
      provider.updateLoading(true);
      expect(provider.loading, true);
      verify(() => notifyListenerCallback()).called(1);
    });
  });
}
