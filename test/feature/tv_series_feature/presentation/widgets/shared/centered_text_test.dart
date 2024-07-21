import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

void main() {
  Future<void> pumpWidget({
    required WidgetTester tester,
    required String text,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => CenteredText(
              text: text,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets(
      'should render the widget correctly when widget is accessed by some page',
      (tester) async {
    await pumpWidget(
      tester: tester,
      text: 'text',
    );
    await tester.pump();
    expect(find.byType(CenteredText), findsOneWidget);
    expect(find.text('text'), findsOneWidget);
  });
}
