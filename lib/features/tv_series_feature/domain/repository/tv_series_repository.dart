import 'package:either_dart/either.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';
import 'package:search_series/features_util/failure.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvShowEntity>>> getTvSeriesByName(String name);

  Future<Either<Failure, TvShowEntity>> getTvSeriesById(int id);
}
