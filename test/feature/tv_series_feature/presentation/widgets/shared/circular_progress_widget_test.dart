import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

void main() {
  Future<void> pumpWidget({
    required WidgetTester tester,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => const CircularProgressWidget(),
          ),
        ),
      ),
    );
  }

  testWidgets(
      'should render the widget correctly when widget is accessed by some page',
      (tester) async {
    await pumpWidget(tester: tester);
    await tester.pump();
    expect(find.byType(CircularProgressWidget), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
