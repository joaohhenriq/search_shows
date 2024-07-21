import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/base_app/injection/injection.dart';
import 'package:search_series/features/splash_feature/splash_feature.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockIsUserAuthenticated extends Mock implements IsUserAuthenticated {}

void main() {
  late SplashRouter router;
  late MockBuildContext mockBuildContext;
  late MockIsUserAuthenticated mockIsUserAuthenticated;

  Injector.I
      .registerFactory<IsUserAuthenticated>(() => mockIsUserAuthenticated);

  setUpAll(() {
    mockBuildContext = MockBuildContext();
    mockIsUserAuthenticated = MockIsUserAuthenticated();
    router = SplashRouter();
  });

  group('getRoutes', () {
    test('should return a page typed SplashPage', () {
      final MaterialPageRoute<dynamic> feature = router.getRoutes(
        const RouteSettings(),
      )[SplashRoutes.splashPage];
      final call = feature.builder;
      expect(
        call(mockBuildContext),
        isA<SplashPage>(),
      );
    });
  });
}
