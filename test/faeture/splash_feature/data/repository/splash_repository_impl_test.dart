import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/features/splash_feature/splash_feature.dart';

class MockLocalDataSource extends Mock implements SplashDataSource {}

void main() {
  late SplashRepositoryImpl repository;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = SplashRepositoryImpl(datasource: mockLocalDataSource);
  });

  group('isUserAuthenticated', () {
    test('should return Result right when data source responds successfully',
        () async {
      when(() => mockLocalDataSource.isUserAuthenticated())
          .thenAnswer((_) async => true);
      final result = await repository.isUserAuthenticated();
      expect(result.isRight, true);
      expect(result.right, true);
      verify(() => mockLocalDataSource.isUserAuthenticated()).called(1);
    });
    test(
        'should return Result left when data source responds unsuccessfully with some exception',
        () async {
      when(() => mockLocalDataSource.isUserAuthenticated())
          .thenThrow(Exception());
      final result = await repository.isUserAuthenticated();
      expect(result.isLeft, true);
      expect(result.left, const TypeMatcher<IsUserAuthenticatedFailure>());
      verify(() => mockLocalDataSource.isUserAuthenticated()).called(1);
    });
  });
}
