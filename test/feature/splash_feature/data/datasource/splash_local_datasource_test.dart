import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/features/splash_feature/splash_feature.dart';
import 'package:search_series/features_core/local_storage_core/local_storage_core.dart';

class MockLocalStorage extends Mock implements SharedPreferencesClient {}

void main() {
  late SplashDataSourceImpl dataSource;
  late MockLocalStorage mockLocalStorage;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    dataSource = SplashDataSourceImpl(mockLocalStorage);
  });

  const userAuthenticated = 'userAuthenticated';

  group('isUserAuthenticated', () {
    test('should return true when user is set as authenticated', () async {
      when(() => mockLocalStorage.getBool(userAuthenticated)).thenAnswer(
        (_) async => true,
      );
      final result = await dataSource.isUserAuthenticated();
      expect(result, true);
      verify(() => mockLocalStorage.getBool(userAuthenticated)).called(1);
    });

    test('should return false when user is not set as authenticated', () async {
      when(() => mockLocalStorage.getBool(userAuthenticated)).thenAnswer(
        (_) async => false,
      );
      final result = await dataSource.isUserAuthenticated();
      expect(result, false);
      verify(() => mockLocalStorage.getBool(userAuthenticated)).called(1);
    });
  });
}
