import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  Future<void> pumpWidget({
    required WidgetTester tester,
    required void Function() onTap,
    required String title,
    required String description,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => DsCardInfo(
              onTap: onTap,
              title: title,
              description: description,
              mediumImage: 'https://example.com/image.png',
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('should render with texts when they are not empty',
      (tester) async {
    var onTapCalled = false;
    await mockNetworkImagesFor(
      () => pumpWidget(
        tester: tester,
        onTap: () => onTapCalled = true,
        title: 'Title',
        description: 'Description',
      ),
    );
    await tester.pump();
    expect(find.byType(DsCardInfo), findsOneWidget);
    expect(find.byType(ImageNetwork), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    await tester.tap(find.byType(DsCardInfo));
    await tester.pump();
    expect(onTapCalled, true);
  });

  testWidgets('should not render texts when they are empty', (tester) async {
    var onTapCalled = false;
    await mockNetworkImagesFor(
      () => pumpWidget(
        tester: tester,
        onTap: () => onTapCalled = true,
        title: '',
        description: '',
      ),
    );
    await tester.pump();
    expect(find.byType(DsCardInfo), findsOneWidget);
    expect(find.byType(ImageNetwork), findsOneWidget);
    expect(find.text('No title available'), findsOneWidget);
    expect(find.text('Description'), findsNothing);
    await tester.tap(find.byType(DsCardInfo));
    await tester.pump();
    expect(onTapCalled, true);
  });
}
