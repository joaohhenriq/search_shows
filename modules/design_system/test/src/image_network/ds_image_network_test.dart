import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  Future<void> pumpWidget({
    required WidgetTester tester,
    required String imageUrl,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ImageNetwork(
              imageUrl: imageUrl,
              defaultIconColor: DsColors.blue,
            ),
          ),
        ),
      ),
    );
  }

  group('ImageNetwork', () {
    testWidgets('should build ImageNetwork with image',
        (WidgetTester tester) async {
      const imageUrl = 'https://example.com/image.png';
      await mockNetworkImagesFor(
        () => pumpWidget(tester: tester, imageUrl: imageUrl),
      );
      await tester.pump();
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should build ImageNetwork with default icon',
        (WidgetTester tester) async {
      const imageUrl = '';
      await pumpWidget(tester: tester, imageUrl: imageUrl);
      await tester.pump();
      expect(find.byType(Icon), findsOneWidget);
    });
  });
}
