// import 'package:flutter/material.dart';
// import 'package:tv_series_app/features/series_feature/series_feature.dart';
//
// enum EpisodeListStatus {
//   loading,
//   loaded,
//   error,
//   empty,
// }
//
// class SeriesDetailState extends ChangeNotifier {
//   EpisodeListStatus episodeListStatus = EpisodeListStatus.loading;
//   List<SeasonEntity> seasonList = [];
//   bool isFavorite = false;
//
//   void updateSeasonList(List<SeasonEntity> seasons) {
//     episodeListStatus = EpisodeListStatus.loaded;
//     seasonList = seasons;
//     notifyListeners();
//   }
//
//   void updateEpisodeListStatus(EpisodeListStatus status) {
//     episodeListStatus = status;
//     notifyListeners();
//   }
//
//   void updateIsFavorite(bool value) {
//     isFavorite = value;
//     notifyListeners();
//   }
// }