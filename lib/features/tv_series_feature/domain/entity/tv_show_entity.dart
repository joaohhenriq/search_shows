import 'package:equatable/equatable.dart';

class TvShowEntity extends Equatable {
  const TvShowEntity({
    this.id = 0,
    this.name = '',
    this.mediumImage = '',
    this.originalImage = '',
    this.premiered = '',
    this.ended = '',
    this.scheduleDays = const [],
    this.scheduleTime = '',
    this.genres = const [],
    this.summary = '',
  });

  final int id;
  final String name;
  final String mediumImage;
  final String originalImage;
  final String premiered;
  final String ended;
  final List<String> scheduleDays;
  final String scheduleTime;
  final List<String> genres;
  final String summary;

  @override
  List<Object?> get props => [
        id,
        name,
        mediumImage,
        originalImage,
        premiered,
        ended,
        scheduleDays,
        scheduleTime,
        genres,
        summary,
      ];

  TvShowEntity copyWith({
    int? id,
    String? name,
    String? mediumImage,
    String? originalImage,
    String? premiered,
    String? ended,
    List<String>? scheduleDays,
    String? scheduleTime,
    List<String>? genres,
    String? summary,
  }) =>
      TvShowEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        mediumImage: mediumImage ?? this.mediumImage,
        originalImage: originalImage ?? this.originalImage,
        premiered: premiered ?? this.premiered,
        ended: ended ?? this.ended,
        scheduleDays: scheduleDays ?? this.scheduleDays,
        scheduleTime: scheduleTime ?? this.scheduleTime,
        genres: genres ?? this.genres,
        summary: summary ?? this.summary,
      );
}
