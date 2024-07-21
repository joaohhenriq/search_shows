import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpWidget({
    required WidgetTester tester,
    required TextEditingController controller,
    String hintText = '',
    bool obscureText = false,
    IconData? prefixIcon,
    String? Function(String?)? validator,
    void Function(String)? onFieldSubmitted,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => DsInputField(
              controller: controller,
              hintText: hintText,
              obscureText: obscureText,
              prefixIcon: prefixIcon,
              validator: validator,
              onFieldSubmitted: onFieldSubmitted,
            ),
          ),
        ),
      ),
    );
  }

  group('DsInputField', () {
    testWidgets('should display the input field with default parameters', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController();
      await pumpWidget(tester: tester, controller: controller);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(DsInputField), findsOneWidget);
    });

    testWidgets('should display the hintText correctly',
        (WidgetTester tester) async {
      final controller = TextEditingController();
      await pumpWidget(
        tester: tester,
        controller: controller,
        hintText: 'Enter your name',
      );
      expect(find.text('Enter your name'), findsOneWidget);
    });

    testWidgets('should display the prefix icon when provided',
        (WidgetTester tester) async {
      final controller = TextEditingController();
      await pumpWidget(
        tester: tester,
        controller: controller,
        prefixIcon: Icons.person,
      );
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('should call the validator function when text is entered',
        (WidgetTester tester) async {
      final controller = TextEditingController();
      String? validate(String? text) => text!.isEmpty ? 'Error' : null;
      await pumpWidget(
        tester: tester,
        controller: controller,
        validator: validate,
      );
      await tester.enterText(find.byType(TextFormField), '12');
      await tester.enterText(find.byType(TextFormField), '1');
      await tester.enterText(find.byType(TextFormField), '');
      await tester.pump();
      expect(find.text('Error'), findsOneWidget);
    });

    testWidgets('should call onFieldSubmitted when the input is submitted',
        (WidgetTester tester) async {
      final controller = TextEditingController();
      String submittedText = '';
      await pumpWidget(
        tester: tester,
        controller: controller,
        onFieldSubmitted: (value) {
          submittedText = value;
        },
      );
      await tester.enterText(find.byType(TextFormField), 'Search');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      expect(submittedText, 'Search');
    });
  });
}
