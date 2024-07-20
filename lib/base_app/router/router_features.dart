import 'package:flutter/material.dart';
import 'package:search_series/features/login_feature/login_feature.dart';
import 'package:search_series/features/splash_feature/splash_feature.dart';

Map<String, dynamic> routerFeatures(RouteSettings settings) => {
  ...SplashRouter().getRoutes(settings),
  ...LoginRouter().getRoutes(settings),
};
