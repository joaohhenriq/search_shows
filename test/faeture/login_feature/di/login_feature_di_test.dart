import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_series/base_app/injection/injection.dart';
import 'package:search_series/features/login_feature/login_feature.dart';
import 'package:search_series/features_core/local_storage_core/shared_preferences/shared_preferences.dart';

class MockSharedPreferencesClient extends Mock
    implements SharedPreferencesClient {}

void main() {
  late MockSharedPreferencesClient mockSharedPreferencesClient;

  setUpAll(() async {
    mockSharedPreferencesClient = MockSharedPreferencesClient();

    Injector.I.registerFactory<SharedPreferencesClient>(
      () => mockSharedPreferencesClient,
    );
  });

  test('Should test inject LoginFeatureDI was successful', () async {
    LoginFeatureDI().registerDependencies(injector: Injector.I);

    // Datasources
    expect(
      Injector.I.get<LoginLocalDataSource>().runtimeType,
      LoginLocalDataSourceImpl,
    );

    // Repositories
    expect(
      Injector.I.get<LoginRepository>().runtimeType,
      LoginRepositoryImpl,
    );

    // Use cases
    expect(
      Injector.I.get<AuthenticateUser>().runtimeType,
      AuthenticateUserImpl,
    );
  });
}
