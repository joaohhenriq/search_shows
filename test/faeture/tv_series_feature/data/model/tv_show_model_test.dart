import 'package:flutter_test/flutter_test.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

void main() {
  group('fromJson', () {
    test('should return model when params are present in map', () async {
      final map = {
        'show': {
          'id': 1,
          'name': 'name',
          'summary': 'summary',
          'genres': ['genres'],
          'schedule': {
            'days': ['scheduleDays'],
            'time': 'scheduleTime',
          },
          'premiered': 'premiered',
          'ended': 'ended',
          'image': {
            'medium': 'mediumImage',
            'original': 'originalImage',
          },
        },
      };

      final model = TvShowModel.fromMap(map);
      expect(model.id, 1);
      expect(model.name, 'name');
      expect(model.summary, 'summary');
      expect(model.genres, ['genres']);
      expect(model.scheduleDays, ['scheduleDays']);
      expect(model.scheduleTime, 'scheduleTime');
      expect(model.premiered, 'premiered');
      expect(model.ended, 'ended');
      expect(model.mediumImage, 'mediumImage');
      expect(model.originalImage, 'originalImage');
    });

    test(
        'should return model with default value when params are not present in map',
        () async {
      final model = TvShowModel.fromMap(const {});
      expect(model.id, 0);
      expect(model.name, '');
      expect(model.summary, '');
      expect(model.genres, []);
      expect(model.scheduleDays, []);
      expect(model.scheduleTime, '');
      expect(model.premiered, '');
      expect(model.ended, '');
      expect(model.mediumImage, '');
      expect(model.originalImage, '');
    });
  });
}
