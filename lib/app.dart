import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuses/providers/theme_notifier.dart';
import 'package:statuses/ui/screens/app_shell.dart';
import 'package:statuses/ui/screens/permission_screen.dart';
import 'package:statuses/ui/theme/dark_theme.dart';
import 'package:statuses/ui/theme/light_theme.dart';

class StatusesApp extends StatelessWidget {
  const StatusesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, _) {
        return MaterialApp(
          title: 'Statuses',
          debugShowCheckedModeBanner: false,
          theme: LightTheme.theme,
          darkTheme: DarkTheme.theme,
          themeMode: themeNotifier.themeMode,
          initialRoute: '/permission',
          routes: {
            '/permission': (_) => const PermissionScreen(),
            '/home': (_) => const AppShell(),
          },
        );
      },
    );
  }
}
