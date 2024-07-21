import 'package:flutter_test/flutter_test.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

void main() {
  group('TvShowEntity', () {
    const entity = TvShowEntity(
      id: 1,
      name: 'name',
      summary: 'summary',
      genres: ['genres'],
      scheduleDays: ['scheduleDays'],
      scheduleTime: 'scheduleTime',
      premiered: 'premiered',
      ended: 'ended',
      mediumImage: 'mediumImage',
      originalImage: 'originalImage',
    );

    test('Should return the correct values from the entity', () {
      expect(entity, isA<TvShowEntity>());
      expect(entity.id, 1);
      expect(entity.name, 'name');
      expect(entity.summary, 'summary');
      expect(entity.genres, ['genres']);
      expect(entity.scheduleDays, ['scheduleDays']);
      expect(entity.scheduleTime, 'scheduleTime');
      expect(entity.premiered, 'premiered');
      expect(entity.ended, 'ended');
      expect(entity.mediumImage, 'mediumImage');
      expect(entity.originalImage, 'originalImage');
    });

    test('Should replace values updated by copyWith', () {
      final updatedEntity = entity.copyWith(
        id: 2,
        name: 'name2',
        summary: 'summary2',
        genres: ['genres2'],
        scheduleDays: ['scheduleDays2'],
        scheduleTime: 'scheduleTime2',
        premiered: 'premiered2',
        ended: 'ended2',
        mediumImage: 'mediumImage2',
        originalImage: 'originalImage2',
      );
      expect(updatedEntity.id, 2);
      expect(updatedEntity.name, 'name2');
      expect(updatedEntity.summary, 'summary2');
      expect(updatedEntity.genres, ['genres2']);
      expect(updatedEntity.scheduleDays, ['scheduleDays2']);
      expect(updatedEntity.scheduleTime, 'scheduleTime2');
      expect(updatedEntity.premiered, 'premiered2');
      expect(updatedEntity.ended, 'ended2');
      expect(updatedEntity.mediumImage, 'mediumImage2');
      expect(updatedEntity.originalImage, 'originalImage2');
    });
  });
}
