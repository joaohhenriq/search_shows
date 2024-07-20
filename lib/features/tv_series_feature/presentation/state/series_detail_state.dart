import 'package:flutter/material.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

enum TvSeriesDetailsStatus {
  loading,
  loaded,
  error,
}

class TvSeriesDetailState extends ChangeNotifier {
  TvSeriesDetailsStatus tvSeriesDetailsStatus = TvSeriesDetailsStatus.loading;
  TvShowEntity tvShowDetails = const TvShowEntity();

  void updateTvSeriesDetailsStatus(TvSeriesDetailsStatus value) {
    tvSeriesDetailsStatus = value;
    notifyListeners();
  }

  void updateTvShowDetails(TvShowEntity value) {
    tvSeriesDetailsStatus = TvSeriesDetailsStatus.loaded;
    tvShowDetails = value;
    notifyListeners();
  }
}