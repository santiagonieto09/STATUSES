import 'package:flutter/material.dart';
import 'package:statuses/data/services/permission_service.dart';
import 'package:statuses/ui/theme/app_theme.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  final PermissionService _permissionService = PermissionService();
  PermissionState _state = PermissionState.denied;
  bool _isRequesting = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final state = await _permissionService.checkStoragePermission();
    if (mounted) {
      setState(() => _state = state);
      if (state == PermissionState.granted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
  }

  Future<void> _requestPermission() async {
    setState(() => _isRequesting = true);
    final state = await _permissionService.requestStoragePermission();
    if (mounted) {
      setState(() {
        _state = state;
        _isRequesting = false;
      });
      if (state == PermissionState.granted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
  }

  Future<void> _openSettings() async {
    await _permissionService.openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.folder_open_rounded,
                  size: 50,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Storage Access Required',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Statuses needs access to your storage to read WhatsApp status media files. Your files remain on your device.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondaryText,
                    ),
              ),
              const SizedBox(height: 32),
              if (_state == PermissionState.permanentlyDenied)
                _buildPermanentlyDenied()
              else
                _buildGrantButton(),
              const Spacer(),
              Text(
                'Your data stays on your device.\nStatuses does not collect any information.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondaryText.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrantButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: _isRequesting ? null : _requestPermission,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppShapes.buttonRadius),
          ),
        ),
        child: _isRequesting
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                'Grant Access',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  Widget _buildPermanentlyDenied() {
    return Column(
      children: [
        const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 48),
        const SizedBox(height: 16),
        Text(
          'Permission was permanently denied.\nPlease enable it in Settings.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.secondaryText),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: FilledButton(
            onPressed: _openSettings,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppShapes.buttonRadius),
              ),
            ),
            child: const Text(
              'Open Settings',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
