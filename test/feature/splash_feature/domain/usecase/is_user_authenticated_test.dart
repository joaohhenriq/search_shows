import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/features/splash_feature/splash_feature.dart';

class MockRepository extends Mock implements SplashRepository {}

void main() {
  late IsUserAuthenticatedImpl usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = IsUserAuthenticatedImpl(repository: mockRepository);
  });

  test('should return true when user is authenticated', () async {
    when(() => mockRepository.isUserAuthenticated())
        .thenAnswer((_) async => const Right(true));
    final result = await usecase();
    expect(result, const Right(true));
    verify(() => mockRepository.isUserAuthenticated()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return false when user is not authenticated', () async {
    when(() => mockRepository.isUserAuthenticated())
        .thenAnswer((_) async => const Right(false));
    final result = await usecase();
    expect(result, const Right(false));
    verify(() => mockRepository.isUserAuthenticated()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
