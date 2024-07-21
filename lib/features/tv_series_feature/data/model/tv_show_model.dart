import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';
import 'package:search_series/features_util/helpers.dart';

class TvShowModel extends TvShowEntity {
  const TvShowModel({
    super.id = 0,
    super.name = '',
    super.mediumImage = '',
    super.originalImage = '',
    super.premiered = '',
    super.ended = '',
    super.scheduleDays = const [],
    super.scheduleTime = '',
    super.genres = const [],
    super.summary = '',
  });

  factory TvShowModel.fromMap(Map<String, dynamic> map) {
    final show = map['show'] ?? map;
    return TvShowModel(
      id: show['id'] ?? 0,
      name: show['name'] ?? '',
      mediumImage: show['image'] != null && show['image']['medium'] != null
          ? show['image']['medium']
          : '',
      originalImage: show['image'] != null && show['image']['original'] != null
          ? show['image']['original']
          : '',
      premiered: show['premiered'] ?? '',
      ended: show['ended'] ?? '',
      scheduleDays: List<String>.from(
        show['schedule'] != null && show['schedule']['days'] != null
            ? show['schedule']['days']
            : [],
      ),
      scheduleTime: show['schedule'] != null && show['schedule']['time'] != null
          ? show['schedule']['time']
          : '',
      genres: List<String>.from(show['genres'] ?? []),
      summary: Helpers.removeHtmlFromString(show['summary'] ?? ''),
    );
  }
}
