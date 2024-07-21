import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/features/login_feature/login_feature.dart';

class MockLocalDataSource extends Mock implements LoginLocalDataSource {}

void main() {
  late LoginRepositoryImpl repository;
  late LoginLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = LoginRepositoryImpl(datasource: mockLocalDataSource);
  });

  group('setUserAsAuthenticated', () {
    test('should return Result right when data source responds successfully',
        () async {
      when(() => mockLocalDataSource.setUserAsAuthenticated())
          .thenAnswer((_) async => true);
      final result = await repository.setUserAsAuthenticated();
      expect(result.isRight, true);
      expect(result.right, true);
      verify(() => mockLocalDataSource.setUserAsAuthenticated()).called(1);
    });
    test(
        'should return Result left when data source responds unsuccessfully with some exception',
        () async {
      when(() => mockLocalDataSource.setUserAsAuthenticated())
          .thenThrow(Exception());
      final result = await repository.setUserAsAuthenticated();
      expect(result.isLeft, true);
      expect(result.left, const TypeMatcher<SetUserAsAuthenticatedFailure>());
      verify(() => mockLocalDataSource.setUserAsAuthenticated()).called(1);
    });
  });
}
