import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

class SeriesDetailPage extends StatefulWidget {
  const SeriesDetailPage({
    super.key,
    required this.tvShowId,
    required this.getTvSeriesById,
  });

  final int tvShowId;
  final GetTvSeriesById getTvSeriesById;

  @override
  State<SeriesDetailPage> createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<TvSeriesDetailState>();
      await _fetchTvSeriesDetails(
        tvSeriesId: widget.tvShowId,
        updateTvSeriesDetailsStatus: provider.updateTvSeriesDetailsStatus,
        updateTvShowDetails: provider.updateTvShowDetails,
      );
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Tv Series Detail')),
        body: SingleChildScrollView(
          child: Consumer<TvSeriesDetailState>(
            builder: (context, provider, child) {
              switch (provider.tvSeriesDetailsStatus) {
                case TvSeriesDetailsStatus.loading:
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: DsSpacing.xxl),
                      child: CircularProgressWidget(),
                    ),
                  );
                case TvSeriesDetailsStatus.loaded:
                  return LoadedInfoSeriesDetail(
                    tvShowEntity: provider.tvShowDetails,
                  );
                case TvSeriesDetailsStatus.error:
                  return const CenteredText(
                    text: 'Oh, looks like something went wrong!',
                  );
              }
            },
          ),
        ),
      );

  Future<void> _fetchTvSeriesDetails({
    required int tvSeriesId,
    required void Function(TvSeriesDetailsStatus) updateTvSeriesDetailsStatus,
    required void Function(TvShowEntity) updateTvShowDetails,
  }) async {
    final result = await widget.getTvSeriesById(tvSeriesId);

    if (result.isRight) {
      updateTvShowDetails(result.right);
      return;
    }
    updateTvSeriesDetailsStatus(TvSeriesDetailsStatus.error);
  }
}
