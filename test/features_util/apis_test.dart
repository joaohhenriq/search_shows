import 'package:flutter_test/flutter_test.dart';

const String tvMazeUrl = 'https://api.tvmaze.com';

void main() {
  group('Constants', () {
    test('tvMazeUrl should be correct', () {
      expect(tvMazeUrl, 'https://api.tvmaze.com');
    });
  });
}