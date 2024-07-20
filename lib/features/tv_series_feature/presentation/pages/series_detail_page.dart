// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tv_series_app/features/series_feature/series_feature.dart';
// import 'package:tv_series_app/features/shared/shared.dart';
//
// class SeriesDetailPage extends StatefulWidget {
//   const SeriesDetailPage({
//     super.key,
//     required this.tvShowEntity,
//     required this.getEpisodesBySeriesId,
//     required this.groupEpisodesBySeason,
//     required this.isSeriesFavorite,
//     required this.addFavoriteSeries,
//     required this.deleteFromFavoriteSeries,
//   });
//
//   final TvShowEntity tvShowEntity;
//   final GetEpisodesBySeriesId getEpisodesBySeriesId;
//   final GroupEpisodesBySeason groupEpisodesBySeason;
//   final IsSeriesFavorite isSeriesFavorite;
//   final AddFavoriteSeries addFavoriteSeries;
//   final DeleteFromFavoriteSeries deleteFromFavoriteSeries;
//
//   @override
//   State<SeriesDetailPage> createState() => _SeriesDetailPageState();
// }
//
// class _SeriesDetailPageState extends State<SeriesDetailPage> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       final provider = context.read<SeriesDetailState>();
//       _validateFavorite(
//         seriesId: widget.tvShowEntity.id,
//         updateIsFavorite: provider.updateIsFavorite,
//       );
//       await _fetchEpisodes(
//         seriesId: widget.tvShowEntity.id,
//         updateEpisodeListStatus: provider.updateEpisodeListStatus,
//         updateSeasonList: provider.updateSeasonList,
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: const Text('Series Detail'),
//           actions: [
//             Consumer<SeriesDetailState>(
//               builder: (context, provider, child) {
//                 return IconButton(
//                   icon: Icon(
//                     provider.isFavorite
//                         ? Icons.favorite
//                         : Icons.favorite_border,
//                     color: provider.isFavorite ? Colors.red : Colors.grey,
//                   ),
//                   onPressed: () => _onTapFavoriteIcon(
//                     tvShowEntity: widget.tvShowEntity,
//                     isFavorite: provider.isFavorite,
//                     updateIsFavorite: provider.updateIsFavorite,
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 12.0),
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.45,
//                   width: double.infinity,
//                   child: ImageNetwork(
//                     imageUrl: widget.tvShowEntity.originalImage,
//                     defaultIconColor: Colors.grey,
//                   ),
//                 ),
//               ),
//               PaddingWithText(
//                 text: widget.tvShowEntity.name,
//                 fontSize: 24,
//               ),
//               PaddingWithText(
//                 text: widget.tvShowEntity.summary,
//                 fontSize: 14,
//               ),
//               PaddingWithText(
//                 text: widget.tvShowEntity.scheduleDays.isNotEmpty
//                     ? 'Days: ${widget.tvShowEntity.scheduleDays.join(', ')}'
//                     : '',
//                 fontSize: 14,
//               ),
//               PaddingWithText(
//                 text: widget.tvShowEntity.scheduleTime.isNotEmpty
//                     ? 'Time: ${widget.tvShowEntity.scheduleTime}'
//                     : '',
//                 fontSize: 14,
//               ),
//               PaddingWithText(
//                 text: widget.tvShowEntity.genres.isNotEmpty
//                     ? 'Genres: ${widget.tvShowEntity.genres.join(', ')}'
//                     : '',
//                 fontSize: 14,
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(top: 20),
//                 child: PaddingWithText(
//                   text: 'EPISODES',
//                   fontSize: 22,
//                 ),
//               ),
//               Consumer<SeriesDetailState>(
//                 builder: (context, provider, child) {
//                   switch (provider.episodeListStatus) {
//                     case EpisodeListStatus.loading:
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     case EpisodeListStatus.loaded:
//                       return LoadedInfoSeriesDetail(
//                         seasonList: provider.seasonList,
//                       );
//                     case EpisodeListStatus.error:
//                       return const CenteredText(
//                         text: 'Oh, looks like something went wrong!',
//                       );
//                     case EpisodeListStatus.empty:
//                       return const CenteredText(text: 'No data available');
//                   }
//                 },
//               )
//             ],
//           ),
//         ),
//       );
//
//   Future<void> _fetchEpisodes({
//     required int seriesId,
//     required void Function(EpisodeListStatus) updateEpisodeListStatus,
//     required void Function(List<SeasonEntity>) updateSeasonList,
//   }) async {
//     final result = await widget.getEpisodesBySeriesId(seriesId);
//
//     if (result.isRight) {
//       updateSeasonList(widget.groupEpisodesBySeason(result.right));
//     } else {
//       switch (result.left) {
//         case GetEpisodesBySeriesIdEmptyListFailure():
//           updateEpisodeListStatus(EpisodeListStatus.empty);
//           break;
//         case GetEpisodesBySeriesIdCatchFailure():
//           updateEpisodeListStatus(EpisodeListStatus.error);
//           break;
//         default:
//           updateEpisodeListStatus(EpisodeListStatus.error);
//           break;
//       }
//     }
//   }
//
//   void _validateFavorite({
//     required int seriesId,
//     required void Function(bool) updateIsFavorite,
//   }) async {
//     final isFavorite = await widget.isSeriesFavorite(widget.tvShowEntity.id);
//     updateIsFavorite(isFavorite);
//   }
//
//   Future<void> _onTapFavoriteIcon({
//     required TvShowEntity tvShowEntity,
//     required bool isFavorite,
//     required void Function(bool) updateIsFavorite,
//   }) async {
//     if (isFavorite) {
//       await widget.deleteFromFavoriteSeries(tvShowEntity.id);
//       updateIsFavorite(false);
//     } else {
//       await widget.addFavoriteSeries(tvShowEntity);
//       updateIsFavorite(true);
//     }
//   }
// }
