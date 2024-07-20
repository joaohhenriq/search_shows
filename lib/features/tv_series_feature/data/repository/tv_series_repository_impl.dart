import 'package:either_dart/either.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';
import 'package:search_series/features_util/failure.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  TvSeriesRepositoryImpl({
    required this.remoteDatasource,
  });

  final TvSeriesRemoteDatasource remoteDatasource;

  @override
  Future<Either<Failure, List<TvShowEntity>>> getTvSeriesByName(
    String name,
  ) async {
    try {
      final result = await remoteDatasource.getTvSeriesByName(name);
      if (result.isNotEmpty) {
        return Right(result);
      }
      return Left(GetTvSeriesByNameEmptyListFailure());
    } catch (e) {
      return Left(GetTvSeriesByNameCatchFailure());
    }
  }

  @override
  Future<Either<Failure, TvShowEntity>> getTvSeriesById(int id) async {
    try {
      final result = await remoteDatasource.getTvSeriesById(id);
      return Right(result);
    } catch (e) {
      return Left(GetTvSeriesByIdCatchFailure());
    }
  }
}
