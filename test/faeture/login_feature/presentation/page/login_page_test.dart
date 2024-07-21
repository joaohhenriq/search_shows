import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:search_series/features/login_feature/login_feature.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

class MockAuthenticateUser extends Mock implements AuthenticateUser {}

class FakeRoute extends Fake implements Route<dynamic> {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockLoginState extends Mock implements LoginState {}

void main() {
  late MockAuthenticateUser mockAuthenticateUser;
  late MockLoginState mockLoginState;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockAuthenticateUser = MockAuthenticateUser();
    mockLoginState = MockLoginState();
    mockNavigatorObserver = MockNavigatorObserver();
    registerFallbackValue(FakeRoute());

    when(() => mockLoginState.loading).thenReturn(false);
  });

  Map<String, dynamic> routerFeaturesMock(RouteSettings settings) =>
      <String, dynamic>{
        TvSeriesRoutes.tvSeriesPage: MaterialPageRoute(
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
                ChangeNotifierProvider<LoginState>(
              create: (_) => mockLoginState,
              child: LoginPage(authenticateUser: mockAuthenticateUser),
            ),
          ),
        ),
      ),
    );
  }

  const credential = 'admin';

  testWidgets('should render the page correctly when it is first accessed',
      (tester) async {
    await pumpWidget(tester: tester);
    await tester.pump();
    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.text('Login'), findsNWidgets(2));
    expect(find.byType(DsInputField), findsNWidgets(2));
    expect(find.text('User'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.byType(DsButton), findsOneWidget);
  });

  testWidgets(
      'should show input error messages when button is pressed without filling in the fields',
      (tester) async {
    await pumpWidget(tester: tester);
    await tester.pump();
    await tester.tap(find.byType(DsButton));
    await tester.pumpAndSettle();
    expect(find.text('Please enter a valid user'), findsOneWidget);
    expect(find.text('Please enter a valid password'), findsOneWidget);
  });

  testWidgets(
      'should navigate user to tv series when button is pressed with valid fields',
      (tester) async {
    when(() => mockAuthenticateUser(user: credential, password: credential))
        .thenAnswer((_) async => true);
    await pumpWidget(tester: tester);
    await tester.pump();
    await tester.enterText(find.byType(DsInputField).first, credential);
    await tester.enterText(find.byType(DsInputField).last, credential);
    await tester.tap(find.byType(DsButton));
    await tester.pumpAndSettle();
    verify(() => mockAuthenticateUser(user: credential, password: credential))
        .called(1);
    verify(() => mockLoginState.updateLoading(true)).called(1);
    verify(() => mockLoginState.updateLoading(false)).called(1);
    verify(() => mockNavigatorObserver.didPush(any(), any())).called(1);
  });

  testWidgets(
      'should show error dialog when button is pressed with invalid fields',
      (tester) async {
    when(() => mockAuthenticateUser(user: credential, password: credential))
        .thenAnswer((_) async => false);
    await pumpWidget(tester: tester);
    await tester.pump();
    await tester.enterText(find.byType(DsInputField).first, credential);
    await tester.enterText(find.byType(DsInputField).last, credential);
    await tester.tap(find.byType(DsButton));
    await tester.pumpAndSettle();
    expect(find.byType(DsAlertDialog), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
    expect(find.text('Invalid username or password'), findsOneWidget);
    verify(() => mockAuthenticateUser(user: credential, password: credential))
        .called(1);
    verify(() => mockLoginState.updateLoading(true)).called(1);
    verify(() => mockLoginState.updateLoading(false)).called(1);
  });
}
