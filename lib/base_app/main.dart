import 'package:flutter/material.dart';
import 'package:search_series/base_app/bootstrap.dart';
import 'package:search_series/base_app/router/router.dart';
import 'package:search_series/features/splash_feature/splash_feature.dart';

void main() async {
  await Bootstrap.start();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Series',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => routerFeatures(settings)[settings.name],
      initialRoute: SplashRoutes.splashPage,
    );
  }
}
