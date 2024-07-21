import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpWidget({
    required WidgetTester tester,
    required void Function() onTap,
    required bool loading,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => DsButton(
              onTap: onTap,
              text: 'Search',
              loading: loading,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('should render with loading indicator when loading is true',
      (tester) async {
    var onTapCalled = false;
    await pumpWidget(
      tester: tester,
      loading: true,
      onTap: () => onTapCalled = true,
    );
    await tester.pump();
    expect(find.byType(DsButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Search'), findsNothing);
    await tester.tap(find.byType(DsButton));
    await tester.pump();
    expect(onTapCalled, false);
  });

  testWidgets('should render with text when loading is false', (tester) async {
    var onTapCalled = false;
    await pumpWidget(
      tester: tester,
      loading: false,
      onTap: () => onTapCalled = true,
    );
    await tester.pump();
    expect(find.byType(DsButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Search'), findsOneWidget);
    await tester.tap(find.byType(DsButton));
    await tester.pump();
    expect(onTapCalled, true);
  });
}
