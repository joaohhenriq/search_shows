import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:search_series/base_app/injection/injection.dart';
import 'package:search_series/features/login_feature/login_feature.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockAuthenticateUser extends Mock implements AuthenticateUser {}

void main() {
  late LoginRouter router;
  late MockBuildContext mockBuildContext;
  late MockAuthenticateUser mockAuthenticateUser;

  Injector.I.registerFactory<AuthenticateUser>(() => mockAuthenticateUser);

  setUpAll(() {
    mockBuildContext = MockBuildContext();
    mockAuthenticateUser = MockAuthenticateUser();
    router = LoginRouter();
  });

  group('getRoutes', () {
    test('should return a page typed LoginState', () {
      final MaterialPageRoute<dynamic> feature = router.getRoutes(
        const RouteSettings(),
      )[LoginRoutes.loginPage];
      final call = feature.builder;
      expect(
        call(mockBuildContext),
        isA<ChangeNotifierProvider<LoginState>>(),
      );
    });
  });
}
