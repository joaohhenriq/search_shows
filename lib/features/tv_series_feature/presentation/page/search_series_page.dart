import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

class TvSearchSeriesPage extends StatefulWidget {
  const TvSearchSeriesPage({
    super.key,
    required this.getTvSeriesByName,
  });

  final GetTvSeriesByName getTvSeriesByName;

  @override
  State<TvSearchSeriesPage> createState() => _TvSearchSeriesPageState();
}

class _TvSearchSeriesPageState extends State<TvSearchSeriesPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Tv Search Series', style: DsTypography.textMedium),
        ),
        body: Column(
          children: [
            Consumer<SearchSeriesState>(
              builder: (context, provider, child) => SearchBarWidget(
                labelText: 'Search series',
                controller: textEditingController,
                loading: provider.pageStatus == SearchSeriesStatusEnum.loading,
                onTap: () => _searchSeries(
                  name: textEditingController.text,
                  updatePageStatus: provider.updatePageStatus,
                  updateTvSeriesDisplayed: provider.updateTvSeriesDisplayed,
                ),
              ),
            ),
            Consumer<SearchSeriesState>(
              builder: (context, provider, child) {
                switch (provider.pageStatus) {
                  case SearchSeriesStatusEnum.initial:
                    return const CenteredText(text: 'Search for a series');
                  case SearchSeriesStatusEnum.loading:
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: DsSpacing.xxl),
                        child: CircularProgressWidget(),
                      ),
                    );
                  case SearchSeriesStatusEnum.loaded:
                    return Expanded(
                      child: LoadedSearchInfo(
                        tvSeriesDisplayed: provider.tvSeriesDisplayed,
                        onTapCard: _onTapCard,
                      ),
                    );
                  case SearchSeriesStatusEnum.error:
                    return const CenteredText(
                      text: 'Oh, looks like something went wrong!',
                    );
                  case SearchSeriesStatusEnum.empty:
                    return const CenteredText(text: 'No data available');
                }
              },
            ),
          ],
        ),
      );

  Future<void> _searchSeries({
    required String name,
    required void Function(List<TvShowEntity>) updateTvSeriesDisplayed,
    required void Function(SearchSeriesStatusEnum) updatePageStatus,
  }) async {
    if (name.isEmpty) return;
    FocusScope.of(context).unfocus();
    updatePageStatus(SearchSeriesStatusEnum.loading);
    final result = await widget.getTvSeriesByName(textEditingController.text);
    if (result.isRight) {
      updateTvSeriesDisplayed(result.right);
    } else {
      switch (result.left) {
        case GetTvSeriesByNameEmptyListFailure():
          updatePageStatus(SearchSeriesStatusEnum.empty);
          break;
        case GetTvSeriesByNameCatchFailure():
          updatePageStatus(SearchSeriesStatusEnum.error);
          break;
        default:
          updatePageStatus(SearchSeriesStatusEnum.error);
          break;
      }
    }
  }

  Future<void> _onTapCard(TvShowEntity tvShowEntity) async =>
      await Navigator.pushNamed(
        context,
        TvSeriesRoutes.tvSeriesDetailPage,
        arguments: tvShowEntity.id,
      );
}
