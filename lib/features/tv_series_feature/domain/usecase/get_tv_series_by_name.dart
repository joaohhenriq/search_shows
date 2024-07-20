import 'package:either_dart/either.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';
import 'package:search_series/features_util/failure.dart';

abstract class GetTvSeriesByName {
  Future<Either<Failure, List<TvShowEntity>>> call(String name);
}

class GetTvSeriesByNameImpl implements GetTvSeriesByName {
  GetTvSeriesByNameImpl(this.repository);

  final TvSeriesRepository repository;

  @override
  Future<Either<Failure, List<TvShowEntity>>> call(String name) async =>
      await repository.getTvSeriesByName(name);
}
