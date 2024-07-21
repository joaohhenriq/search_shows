import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/features/login_feature/login_feature.dart';

class MockRepository extends Mock implements LoginRepository {}

void main() {
  late AuthenticateUserImpl usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = AuthenticateUserImpl(loginRepository: mockRepository);
  });

  const credential = 'admin';
  const wrongCredential = 'admin123';

  test(
      'should return true and set user as authenticated when credentials match with expected',
      () async {
    when(() => mockRepository.setUserAsAuthenticated())
        .thenAnswer((_) async => const Right(true));
    final result = await usecase(
      user: credential,
      password: credential,
    );
    expect(result, true);
    verify(() => mockRepository.setUserAsAuthenticated()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test(
      'should return false and not set user as authenticated when credentials does not match with expected',
      () async {
    when(() => mockRepository.setUserAsAuthenticated())
        .thenAnswer((_) async => const Right(true));
    final result = await usecase(
      user: wrongCredential,
      password: wrongCredential,
    );
    expect(result, false);
    verifyNever(() => mockRepository.setUserAsAuthenticated());
  });
}
