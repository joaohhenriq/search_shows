import 'package:search_series/base_app/injection/injection.dart';
import 'package:search_series/features/login_feature/login_feature.dart';
import 'package:search_series/features/splash_feature/splash_feature.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';
import 'package:search_series/features_core/local_storage_core/local_storage_core.dart';
import 'package:search_series/features_core/network_core/network_core.dart';

final List<RegisterInjectionClient> appInjectionFeatures = [
  ..._coreFeatures,
  ..._features,
];

final List<RegisterInjectionClient> _coreFeatures = <RegisterInjectionClient>[
  HttpDI(),
  SharedPreferencesDI(),
];

final List<RegisterInjectionClient> _features = <RegisterInjectionClient>[
  SplashFeatureDI(),
  LoginFeatureDI(),
  TvSeriesFeatureDI(),
];