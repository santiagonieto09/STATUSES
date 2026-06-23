import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:statuses/i18n/translations.g.dart';
import 'package:statuses/ui/screens/help_screen.dart';

Widget createTestApp() {
  return TranslationProvider(
    child: MaterialApp(
      locale: const Locale('en'),
      home: const HelpScreen(),
    ),
  );
}

void main() {
  setUp(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  testWidgets('HelpScreen renders without error', (tester) async {
    await tester.pumpWidget(createTestApp());

    expect(find.byType(HelpScreen), findsOneWidget);
  });

  testWidgets('HelpScreen has scrollable content', (tester) async {
    await tester.pumpWidget(createTestApp());

    final listView = find.byType(ListView);
    expect(listView, findsOneWidget);
  });
}
