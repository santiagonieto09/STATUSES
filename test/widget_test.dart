import 'package:flutter_test/flutter_test.dart';
import 'package:statuses/ui/widgets/empty_state.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('EmptyState displays default message', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyState(),
        ),
      ),
    );

    expect(find.text('No statuses found'), findsOneWidget);
    expect(
      find.text('Open WhatsApp, view some statuses, then come back here.'),
      findsOneWidget,
    );
  });
}
