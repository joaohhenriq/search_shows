import 'package:flutter_test/flutter_test.dart';
import 'package:search_series/features_util/helpers.dart';

void main() {
  group('Helpers', () {
    test('removeHtmlFromString removes HTML tags', () {
      expect(Helpers.removeHtmlFromString('<p>Test</p>'), 'Test');
      expect(Helpers.removeHtmlFromString('<div><span>Example</span></div>'),
          'Example');
    });

    test('removeHtmlFromString removes HTML entities', () {
      expect(Helpers.removeHtmlFromString('Test&nbsp;Example'), 'TestExample');
      expect(Helpers.removeHtmlFromString('Example&nbsp;&amp;Test'),
          'ExampleTest');
    });

    test('removeHtmlFromString handles mixed content', () {
      expect(Helpers.removeHtmlFromString('<p>Test&nbsp;Example</p>'),
          'TestExample');
      expect(
          Helpers.removeHtmlFromString(
              '<div>Example&nbsp;<span>Test</span></div>'),
          'ExampleTest');
    });

    test('removeHtmlFromString handles empty strings', () {
      expect(Helpers.removeHtmlFromString(''), '');
    });

    test('removeHtmlFromString handles strings without HTML', () {
      expect(
          Helpers.removeHtmlFromString('Just plain text'), 'Just plain text');
    });
  });
}
