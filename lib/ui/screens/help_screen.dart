import 'package:flutter/material.dart';
import 'package:statuses/i18n/translations.g.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.help.title)),
      body: _ResponsiveWrapper(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              t.help.how_to_use_title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            _HelpCard(
              icon: Icons.folder_open_rounded,
              title: t.help.grant_permissions_title,
              body: t.help.grant_permissions_body,
            ),
            _HelpCard(
              icon: Icons.visibility_rounded,
              title: t.help.view_statuses_title,
              body: t.help.view_statuses_body,
            ),
            _HelpCard(
              icon: Icons.download_rounded,
              title: t.help.save_statuses_title,
              body: t.help.save_statuses_body,
            ),
            _HelpCard(
              icon: Icons.share_rounded,
              title: t.help.share_content_title,
              body: t.help.share_content_body,
            ),
            _HelpCard(
              icon: Icons.grid_view_rounded,
              title: t.help.switch_view_title,
              body: t.help.switch_view_body,
            ),
            _HelpCard(
              icon: Icons.dark_mode_rounded,
              title: t.help.dark_mode_title,
              body: t.help.dark_mode_body,
            ),
            const SizedBox(height: 24),
            Text(
              t.help.faq_title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ExpansionTile(
                leading: const Icon(Icons.help_outline_rounded),
                title: Text(t.help.faq_encrypted_names_q),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: [
                  Text(
                    t.help.faq_encrypted_names_a,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.7),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HelpCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _HelpCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.7),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const _ResponsiveWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 600) {
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: child,
        ),
      );
    }
    return child;
  }
}
