import 'package:flutter/material.dart';
import 'package:search_series/base_app/injection/injection.dart';
import 'package:search_series/base_app/router/router.dart';
import 'package:search_series/features/splash_feature/splash_feature.dart';

class SplashRouter implements RouterClient {
  @override
  Map<String, dynamic> getRoutes(RouteSettings settings) => {
    SplashRoutes.splashPage: MaterialPageRoute(
      settings: settings,
      builder: (_) => SplashPage(
        isUserAuthenticated: Injector.I.get(),
      ),
    ),
  };
}

class SplashRoutes {
  static const splashPage = 'splash_page';
}