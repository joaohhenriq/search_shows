import 'package:search_series/base_app/injection/client/client.dart';
import 'package:search_series/features/login_feature/login_feature.dart';

class LoginFeatureDI implements RegisterInjectionClient {
  @override
  void registerDependencies({required InjectionClient injector}) {
    // data sources
    injector.registerFactory<LoginLocalDataSource>(
        () => LoginLocalDataSourceImpl(injector.get()));

    // repositories
    injector.registerFactory<LoginRepository>(
        () => LoginRepositoryImpl(datasource: injector.get()));

    // use cases
    injector.registerFactory<AuthenticateUser>(
        () => AuthenticateUserImpl(loginRepository: injector.get()));
  }
}
