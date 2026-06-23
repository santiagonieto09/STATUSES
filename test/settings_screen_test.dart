import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statuses/i18n/translations.g.dart';
import 'package:statuses/providers/download_notifier.dart';
import 'package:statuses/providers/locale_notifier.dart';
import 'package:statuses/providers/notification_notifier.dart';
import 'package:statuses/providers/status_notifier.dart';
import 'package:statuses/providers/theme_notifier.dart';
import 'package:statuses/ui/screens/settings_screen.dart';
import 'mocks.dart';

Widget createTestApp() {
  final repo = FakeStatusRepository();
  final statusNotifier = StatusNotifier(repo);
  return TranslationProvider(
    child: MaterialApp(
      locale: const Locale('en'),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeNotifier()),
          ChangeNotifierProvider(create: (_) => statusNotifier),
          ChangeNotifierProvider(create: (_) => DownloadNotifier()),
          ChangeNotifierProvider(
            create: (_) => NotificationNotifier(statusNotifier),
          ),
          ChangeNotifierProvider(
            create: (_) => LocaleNotifier(initialLocale: AppLocale.en),
          ),
        ],
        child: const SettingsScreen(),
      ),
    ),
  );
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  testWidgets('SettingsScreen renders without error', (tester) async {
    await tester.pumpWidget(createTestApp());

    expect(find.byType(SettingsScreen), findsOneWidget);
  });
}
