import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';
import 'package:search_series/features_core/network_core/network_core.dart';
import 'package:search_series/features_util/apis.dart';

const showSearchEndpoint = '$tvMazeUrl/search/shows?q={name}';

abstract class TvSeriesRemoteDatasource {
  Future<List<TvShowModel>> getTvSeriesByName(String name);
}

class TvSeriesRemoteDatasourceImpl implements TvSeriesRemoteDatasource {
  TvSeriesRemoteDatasourceImpl(this.network);

  final HttpNetwork network;

  @override
  Future<List<TvShowModel>> getTvSeriesByName(String name) async {
    final response = await network.get(
      showSearchEndpoint.replaceAll('{name}', name),
    );
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => TvShowModel.fromMap(e))
          .toList();
    }
    throw Exception('Failed to load data');
  }
}
