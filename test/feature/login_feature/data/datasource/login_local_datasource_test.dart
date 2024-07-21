import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/features/login_feature/login_feature.dart';
import 'package:search_series/features_core/local_storage_core/local_storage_core.dart';

class MockLocalStorage extends Mock implements SharedPreferencesClient {}

void main() {
  late LoginLocalDataSourceImpl dataSource;
  late MockLocalStorage mockLocalStorage;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    dataSource = LoginLocalDataSourceImpl(mockLocalStorage);
  });

  const userAuthenticated = 'userAuthenticated';

  group('setUserAsAuthenticated', () {
    test('should return true when user is set as authenticated', () async {
      when(() => mockLocalStorage.setBool(userAuthenticated, true)).thenAnswer(
        (_) async => true,
      );
      final result = await dataSource.setUserAsAuthenticated();
      expect(result, true);
      verify(() => mockLocalStorage.setBool(userAuthenticated, true)).called(1);
    });

    test('should return false when user is not set as authenticated', () async {
      when(() => mockLocalStorage.setBool(userAuthenticated, true)).thenAnswer(
        (_) async => false,
      );
      final result = await dataSource.setUserAsAuthenticated();
      expect(result, false);
      verify(() => mockLocalStorage.setBool(userAuthenticated, true)).called(1);
    });
  });
}
