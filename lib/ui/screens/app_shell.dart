import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuses/providers/status_notifier.dart';
import 'package:statuses/ui/screens/saved_statuses_screen.dart';
import 'package:statuses/ui/screens/status_grid_screen.dart';
import 'package:statuses/ui/screens/status_list_screen.dart';
import 'package:statuses/ui/theme/app_theme.dart';
import 'package:statuses/ui/widgets/filter_chips.dart';
import 'package:statuses/i18n/translations.g.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StatusNotifier>().loadStatuses().catchError((Object error) {
        debugPrint('Failed to load statuses: $error');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final viewMode = context.select<StatusNotifier, ViewMode>(
      (n) => n.viewMode,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(t.app.title),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: RepaintBoundary(
            child: const FilterChips(),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              viewMode == ViewMode.grid
                  ? Icons.view_list_rounded
                  : Icons.grid_view_rounded,
            ),
            onPressed: () => context.read<StatusNotifier>().toggleViewMode(),
            tooltip: t.settings.toggle_view,
          ),
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            tooltip: t.settings.theme,
            onPressed: () => Navigator.of(context).pushNamed('/settings'),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          _StatusView(),
          SavedStatusesScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: [
          NavigationDestination(
            icon: _StatusNavIcon(isActive: false),
            selectedIcon: _StatusNavIcon(isActive: true),
            label: t.nav.statuses,
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: false,
              child: const Icon(Icons.download_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: false,
              child: const Icon(Icons.download_rounded),
            ),
            label: t.nav.saved,
          ),
        ],
      ),
    );
  }
}

class _StatusNavIcon extends StatelessWidget {
  final bool isActive;

  const _StatusNavIcon({required this.isActive});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final color = isActive
        ? AppColors.accentGreen
        : AppColors.secondaryText;
    return Semantics(
      label: t.nav.statuses,
      child: SizedBox(
        width: 28,
        height: 28,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              isActive ? Icons.circle : Icons.circle_outlined,
              color: color,
              size: 28,
            ),
            Icon(
              Icons.add_rounded,
              color: isActive ? Colors.white : color,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusView extends StatelessWidget {
  const _StatusView();

  @override
  Widget build(BuildContext context) {
    final viewMode = context.select<StatusNotifier, ViewMode>(
      (n) => n.viewMode,
    );
    final needsSaf = context.select<StatusNotifier, bool>(
      (n) => n.needsSafFallback,
    );
    return RepaintBoundary(
      child: viewMode == ViewMode.grid
          ? StatusGridScreen(needsSafFallback: needsSaf)
          : StatusListScreen(needsSafFallback: needsSaf),
    );
  }
}
