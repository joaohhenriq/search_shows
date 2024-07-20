import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

class LoadedInfoSeriesDetail extends StatelessWidget {
  const LoadedInfoSeriesDetail({
    super.key,
    required this.tvShowEntity,
  });

  final TvShowEntity tvShowEntity;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsSpacing.s),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: DsSpacing.s),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.60,
                  width: double.infinity,
                  child: ImageNetwork(
                    imageUrl: tvShowEntity.originalImage,
                    defaultIconColor: DsColors.blue,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: DsSpacing.xxs),
              child: Text(
                tvShowEntity.name,
                style: DsTypography.textSemiBold.copyWith(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: DsSpacing.xxs),
              child: Text(
                tvShowEntity.summary,
                style: DsTypography.textRegular.copyWith(fontSize: 18),
              ),
            ),
          ],
        ),
      );
}
