import 'package:search_series/base_app/injection/injection.dart';
import 'package:search_series/features_core/local_storage_core/local_storage_core.dart';

class SharedPreferencesDI implements RegisterInjectionClient {
  @override
  void registerDependencies({required InjectionClient injector}) {
    injector.registerFactory<SharedPreferencesClient>(
      () => SharedPreferencesClientImpl(),
    );
  }
}
