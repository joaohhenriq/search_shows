import 'package:search_series/base_app/injection/injection.dart';

class Bootstrap {
  static Future<void> start() async {
    _loadInjection();
  }

  static void _loadInjection() {
    try {
      RegisterFeatureClient.instance.registerFeatures();
    } catch (error) {
      Exception('Error loading injection: $error');
    }
  }
}
