import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FakeRoute extends Fake implements Route<dynamic> {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockNavigatorObserver = MockNavigatorObserver();
    registerFallbackValue(FakeRoute());
  });

  Future<void> pumpWidget({
    required WidgetTester tester,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        navigatorObservers: [mockNavigatorObserver],
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => GestureDetector(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => const DsAlertDialog(
                    title: 'Error',
                    content: 'Invalid username or password',
                  ),
                );
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                color: Colors.amber,
                height: 100.0,
                width: 100.0,
                key: const Key('tap-target'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets(
      'should render the widget and execute its operations correctly when widget is accessed by some page',
      (tester) async {
    await pumpWidget(tester: tester);
    await tester.pump();
    await tester.tap(find.byKey(const Key('tap-target')));
    await tester.pump();
    expect(find.byType(DsAlertDialog), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
    expect(find.text('Invalid username or password'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pump();
    expect(find.byType(DsAlertDialog), findsNothing);
    verify(() => mockNavigatorObserver.didPop(any(), any())).called(1);
  });
}
