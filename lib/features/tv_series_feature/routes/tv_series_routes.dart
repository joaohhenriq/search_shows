import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_series/base_app/injection/injection.dart';
import 'package:search_series/base_app/router/router.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

class TvSeriesRouter implements RouterClient {
  @override
  Map<String, dynamic> getRoutes(RouteSettings settings) => {
    TvSeriesRoutes.tvSeriesPage: MaterialPageRoute(
      settings: settings,
      builder: (_) => ChangeNotifierProvider(
        create: (context) => SearchSeriesState(),
        child: TvSearchSeriesPage(
          getTvSeriesByName: Injector.I.get(),
        ),
      )
    ),
  };
}

class TvSeriesRoutes {
  static const tvSeriesPage = 'tv_series_page';
}