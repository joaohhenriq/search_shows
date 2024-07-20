import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';
import 'package:search_series/features_core/network_core/network_core.dart';
import 'package:search_series/features_util/apis.dart';

const showSearchEndpoint = '$tvMazeUrl/search/shows?q={name}';
const showIdEndpoint = '$tvMazeUrl/shows/{id}';

abstract class TvSeriesRemoteDatasource {
  Future<List<TvShowModel>> getTvSeriesByName(String name);

  Future<TvShowModel> getTvSeriesById(int id);
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

  @override
  Future<TvShowModel> getTvSeriesById(int id) async {
    final response = await network.get(
      showIdEndpoint.replaceAll('{id}', id.toString()),
    );
    if (response.statusCode == 200) {
      return TvShowModel.fromMap(response.data);
    }
    throw Exception('Failed to load data');
  }
}
