import 'package:search_series/base_app/injection/injection.dart';

class RegisterFeatureClient {
  RegisterFeatureClient._();

  static RegisterFeatureClient instance = RegisterFeatureClient._();

  void registerFeatures() async {
    for (final feature in appInjectionFeatures) {
      feature.registerDependencies(injector: Injector.I);
    }
  }
}
