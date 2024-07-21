import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

void main() {
  Future<void> pumpWidget({
    required WidgetTester tester,
    required void Function() onTap,
    required String labelText,
    required TextEditingController controller,
    required bool loading,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => SearchBarWidget(
              onTap: onTap,
              labelText: labelText,
              controller: controller,
              loading: loading,
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
      labelText: 'labelText',
      controller: TextEditingController(),
      loading: false,
      onTap: () {},
    );
    await tester.pump();
    expect(find.byType(SearchBarWidget), findsOneWidget);
    expect(find.byType(DsInputField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('labelText'), findsOneWidget);
  });

  testWidgets('should call onTap when button is pressed', (tester) async {
    var onTapCalled = false;
    await pumpWidget(
      tester: tester,
      labelText: 'labelText',
      controller: TextEditingController(),
      loading: false,
      onTap: () {
        onTapCalled = true;
      },
    );
    await tester.pump();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(onTapCalled, true);
    await tester.enterText(find.byType(DsInputField), 'another series');
    expect(find.text('another series'), findsOneWidget);
  });
}
