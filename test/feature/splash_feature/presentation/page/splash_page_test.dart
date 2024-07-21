import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/features/login_feature/login_feature.dart';
import 'package:search_series/features/splash_feature/splash_feature.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

class MockIsUserAuthenticated extends Mock implements IsUserAuthenticated {}

class FakeRoute extends Fake implements Route<dynamic> {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockIsUserAuthenticated mockIsUserAuthenticated;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockIsUserAuthenticated = MockIsUserAuthenticated();
    mockNavigatorObserver = MockNavigatorObserver();
    registerFallbackValue(FakeRoute());
  });

  Map<String, dynamic> routerFeaturesMock(RouteSettings settings) =>
      <String, dynamic>{
        TvSeriesRoutes.tvSeriesPage: MaterialPageRoute(
          settings: const RouteSettings(),
          builder: (context) => const Scaffold(),
        ),
        LoginRoutes.loginPage: MaterialPageRoute(
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
            builder: (BuildContext context) => SplashPage(
              isUserAuthenticated: mockIsUserAuthenticated,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('should navigate to tv series page when user is authenticated',
      (tester) async {
    when(() => mockIsUserAuthenticated())
        .thenAnswer((_) async => const Right(true));
    await pumpWidget(tester: tester);
    await tester.pump(const Duration(seconds: 4));
    expect(find.byType(SplashPage), findsOneWidget);
    expect(find.text('Welcome to TV Series App'), findsOneWidget);
    verify(() => mockIsUserAuthenticated()).called(1);
    verify(() => mockNavigatorObserver.didPush(any(), any())).called(1);
  });

  testWidgets('should navigate to login page when user is not authenticated',
      (tester) async {
    when(() => mockIsUserAuthenticated())
        .thenAnswer((_) async => const Right(false));
    await pumpWidget(tester: tester);
    await tester.pump(const Duration(seconds: 4));
    verify(() => mockIsUserAuthenticated()).called(1);
    verify(() => mockNavigatorObserver.didPush(any(), any())).called(1);
  });
}
