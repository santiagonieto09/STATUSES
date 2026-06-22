import 'package:flutter/material.dart';
import 'package:statuses/ui/widgets/empty_state.dart';

class SavedStatusesScreen extends StatelessWidget {
  const SavedStatusesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: emptyState,
    );
  }

  Widget get emptyState => const EmptyState(
        title: 'No saved statuses',
        subtitle: 'Download statuses to see them here.',
        icon: Icons.download_rounded,
      );
}
