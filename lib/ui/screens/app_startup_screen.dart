import 'package:flutter/material.dart';
import 'package:statuses/data/services/permission_service.dart';
import 'package:statuses/ui/theme/app_theme.dart';

/// Resolves the initial route before showing permission or home content.
class AppStartupScreen extends StatefulWidget {
  const AppStartupScreen({super.key});

  @override
  State<AppStartupScreen> createState() => _AppStartupScreenState();
}

class _AppStartupScreenState extends State<AppStartupScreen> {
  final PermissionService _permissionService = PermissionService();

  @override
  void initState() {
    super.initState();
    _resolveInitialRoute();
  }

  Future<void> _resolveInitialRoute() async {
    final state = await _permissionService.checkStoragePermission();
    if (!mounted) return;

    if (state == PermissionState.granted) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed(
        '/permission',
        arguments: state,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: AppColors.primaryDark,
          ),
        ),
      ),
    );
  }
}
