import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

enum PermissionState { granted, denied, permanentlyDenied }

class PermissionService {
  int? _cachedSdkVersion;

  PermissionState _checkPermissionState(ph.PermissionStatus status) {
    if (status.isGranted) return PermissionState.granted;
    if (status.isPermanentlyDenied) return PermissionState.permanentlyDenied;
    return PermissionState.denied;
  }

  Future<int> _androidSdkVersion() async {
    if (!Platform.isAndroid) return 0;
    if (_cachedSdkVersion != null) return _cachedSdkVersion!;
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    _cachedSdkVersion = androidInfo.version.sdkInt;
    return _cachedSdkVersion!;
  }

  Future<PermissionState> requestStoragePermission() async {
    if (Platform.isAndroid) {
      final sdk = await _androidSdkVersion();

      if (sdk >= 30) {
        // Android 11+ (SDK 30+): MANAGE_EXTERNAL_STORAGE es necesario para
        // acceder directamente a Android/media/com.whatsapp/ via dart:io File.
        // En SDK >= 33 tambien solicitamos los permisos de media granulares
        // como fallback para acceso via MediaStore.
        final manage =
            await ph.Permission.manageExternalStorage.request();
        if (manage.isGranted) return PermissionState.granted;
        if (manage.isPermanentlyDenied) {
          return PermissionState.permanentlyDenied;
        }
        return PermissionState.denied;
      } else {
        final status = await ph.Permission.storage.request();
        return _checkPermissionState(status);
      }
    }
    return PermissionState.granted;
  }

  Future<PermissionState> checkStoragePermission() async {
    if (Platform.isAndroid) {
      final sdk = await _androidSdkVersion();

      if (sdk >= 30) {
        final status = await ph.Permission.manageExternalStorage.status;
        return _checkPermissionState(status);
      } else {
        final status = await ph.Permission.storage.status;
        return _checkPermissionState(status);
      }
    }
    return PermissionState.granted;
  }

  Future<void> openAppSettings() async {
    await ph.openAppSettings();
  }
}
