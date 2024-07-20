import 'package:search_series/features_core/local_storage_core/local_storage_core.dart';

abstract class SplashDataSource {
  Future<bool> isUserAuthenticated();
}

class SplashDataSourceImpl implements SplashDataSource {
  SplashDataSourceImpl(this.sharedPreferencesClient);

  final SharedPreferencesClient sharedPreferencesClient;

  static const userAuthenticated = 'userAuthenticated';

  @override
  Future<bool> isUserAuthenticated() async =>
      await sharedPreferencesClient.getBool(userAuthenticated) ?? false;
}
