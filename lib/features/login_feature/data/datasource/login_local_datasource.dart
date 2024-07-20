import 'package:search_series/features_core/local_storage_core/local_storage_core.dart';

abstract class LoginLocalDataSource {
  Future<bool> setUserAsAuthenticated();
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  LoginLocalDataSourceImpl(this.sharedPreferencesClient);

  final SharedPreferencesClient sharedPreferencesClient;

  static const userAuthenticated = 'userAuthenticated';

  @override
  Future<bool> setUserAsAuthenticated() async =>
      await sharedPreferencesClient.setBool(userAuthenticated, true);
}
