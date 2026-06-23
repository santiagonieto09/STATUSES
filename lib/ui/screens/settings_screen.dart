import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuses/i18n/translations.g.dart';
import 'package:statuses/providers/locale_notifier.dart';
import 'package:statuses/providers/theme_notifier.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.settings.title)),
      body: ListView(
        children: [
          _SectionHeader(title: t.settings.appearance),
          _LanguageTile(),
          _ThemeTile(),
          const Divider(),
          _SectionHeader(title: t.settings.help),
          ListTile(
            leading: const Icon(Icons.help_outline_rounded),
            title: Text(t.settings.help_center),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => Navigator.of(context).pushNamed('/help'),
          ),
          const Divider(),
          _SectionHeader(title: t.settings.about),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: Text(t.settings.app_name),
            subtitle: Text(t.settings.app_description),
          ),
          ListTile(
            leading: const Icon(Icons.tag_rounded),
            title: Text(t.settings.version),
            trailing: const Text('1.0.0+1'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final localeNotifier = context.watch<LocaleNotifier>();
    return ListTile(
      leading: const Icon(Icons.translate_rounded),
      title: Text(t.settings.language),
      trailing: DropdownButton<AppLocale>(
        value: localeNotifier.locale,
        underline: const SizedBox(),
        items: [
          DropdownMenuItem(
            value: AppLocale.en,
            child: const Text('English'),
          ),
          DropdownMenuItem(
            value: AppLocale.es,
            child: const Text('Español'),
          ),
        ],
        onChanged: (locale) {
          if (locale != null) {
            localeNotifier.setLocale(locale);
          }
        },
      ),
    );
  }
}

class _ThemeTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final themeNotifier = context.watch<ThemeNotifier>();
    return SwitchListTile(
      secondary: Icon(
        themeNotifier.themeMode == ThemeMode.dark
            ? Icons.dark_mode_rounded
            : Icons.light_mode_rounded,
      ),
      title: Text(t.settings.theme),
      subtitle: Text(
        themeNotifier.themeMode == ThemeMode.dark
            ? t.settings.dark
            : t.settings.light,
      ),
      value: themeNotifier.themeMode == ThemeMode.dark,
      onChanged: (_) => themeNotifier.toggleTheme(),
    );
  }
}
