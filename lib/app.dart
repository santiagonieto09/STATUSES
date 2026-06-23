import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuses/providers/theme_notifier.dart';
import 'package:statuses/data/services/permission_service.dart';
import 'package:statuses/ui/screens/app_shell.dart';
import 'package:statuses/ui/screens/app_startup_screen.dart';
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
          initialRoute: '/',
          routes: {
            '/': (_) => const AppStartupScreen(),
            '/permission': (context) {
              final state =
                  ModalRoute.of(context)?.settings.arguments as PermissionState?;
              return PermissionScreen(initialState: state);
            },
            '/home': (_) => const AppShell(),
          },
        );
      },
    );
  }
}
