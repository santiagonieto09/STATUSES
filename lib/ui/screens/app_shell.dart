import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuses/providers/download_notifier.dart';
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
    final statusCount = context.select<StatusNotifier, int>(
      (n) => n.statusCount,
    );
    final savedCount = context.select<DownloadNotifier, int>(
      (n) => n.savedCount,
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
            icon: Badge(
              isLabelVisible: statusCount > 0,
              label: Text(statusCount > 99 ? '99+' : '$statusCount'),
              child: const _StatusRingIcon(isActive: false),
            ),
            selectedIcon: Badge(
              isLabelVisible: statusCount > 0,
              label: Text(statusCount > 99 ? '99+' : '$statusCount'),
              child: const _StatusRingIcon(isActive: true),
            ),
            label: t.nav.statuses,
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: savedCount > 0,
              label: Text(savedCount > 99 ? '99+' : '$savedCount'),
              child: const Icon(Icons.download_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: savedCount > 0,
              label: Text(savedCount > 99 ? '99+' : '$savedCount'),
              child: const Icon(Icons.download_rounded),
            ),
            label: t.nav.saved,
          ),
        ],
      ),
    );
  }
}

class _StatusRingIcon extends StatelessWidget {
  final bool isActive;

  const _StatusRingIcon({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Stories',
      child: SizedBox(
        width: 28,
        height: 28,
        child: CustomPaint(
          painter: _StatusRingPainter(isActive: isActive),
        ),
      ),
    );
  }
}

class _StatusRingPainter extends CustomPainter {
  final bool isActive;

  _StatusRingPainter({required this.isActive});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2 - 1;
    final innerRadius = outerRadius * 0.55;
    final strokeWidth = outerRadius - innerRadius;

    final color = isActive ? AppColors.accentGreen : AppColors.secondaryText;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final outerGap = 0.25 * math.pi;
    final innerGap = 0.35 * math.pi;
    final rotation = isActive ? 0.15 * math.pi : 0.0;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: outerRadius - strokeWidth / 2),
      rotation + outerGap * 0.5,
      2 * math.pi - outerGap,
      false,
      paint,
    );

    paint.strokeWidth = strokeWidth * 0.65;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: innerRadius),
      math.pi + rotation + innerGap * 0.3,
      2 * math.pi - innerGap,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_StatusRingPainter oldDelegate) =>
      oldDelegate.isActive != isActive;
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
