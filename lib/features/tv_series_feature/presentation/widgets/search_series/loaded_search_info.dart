import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:search_series/features/tv_series_feature/domain/entity/tv_show_entity.dart';

class LoadedSearchInfo extends StatelessWidget {
  const LoadedSearchInfo({
    super.key,
    required this.tvSeriesDisplayed,
    required this.onTapCard,
  });

  final List<TvShowEntity> tvSeriesDisplayed;
  final void Function(TvShowEntity) onTapCard;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: tvSeriesDisplayed.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: DsSpacing.xxs,
              left: DsSpacing.xxs,
              right: DsSpacing.xxs,
            ),
            child: DsCardInfo(
              title: tvSeriesDisplayed[index].name,
              description: tvSeriesDisplayed[index].summary,
              mediumImage: tvSeriesDisplayed[index].mediumImage,
              onTap: () => onTapCard(tvSeriesDisplayed[index]),
            ),
          );
        },
      );
}
