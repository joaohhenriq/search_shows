// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:tv_series_app/features/series_feature/series_feature.dart';
// import 'package:tv_series_app/features/shared/shared.dart';
//
// class LoadedInfoSeriesDetail extends StatelessWidget {
//   const LoadedInfoSeriesDetail({
//     super.key,
//     required this.seasonList,
//   });
//
//   final List<SeasonEntity> seasonList;
//
//   @override
//   Widget build(BuildContext context) => Column(
//         children: seasonList
//             .map(
//               (season) => Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 12.0),
//                     child: PaddingWithText(
//                       text: 'Season ${season.number}',
//                       fontSize: 20,
//                     ),
//                   ),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: season.episodes.length,
//                     itemBuilder: (context, index) {
//                       final episode = season.episodes[index];
//                       return Padding(
//                         padding: const EdgeInsets.only(
//                           bottom: 12.0,
//                           left: 12.0,
//                           right: 12.0,
//                         ),
//                         child: CardInfo(
//                           onTap: () => _onTapEpisodeCard(episode),
//                           name:
//                               '${episode.number.toString()} - ${episode.name}',
//                           summary: episode.summary,
//                           mediumImage: episode.mediumImage,
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             )
//             .toList(),
//       );
//
//   void _onTapEpisodeCard(EpisodeEntity episodeEntity) => Modular.to.pushNamed(
//         SeriesNavigation.episodeDetail,
//         arguments: episodeEntity,
//       );
// }
