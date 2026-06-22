import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

enum PermissionState { granted, denied, permanentlyDenied }

class PermissionService {
  PermissionState _checkPermissionState(ph.PermissionStatus status) {
    if (status.isGranted) return PermissionState.granted;
    if (status.isPermanentlyDenied) return PermissionState.permanentlyDenied;
    return PermissionState.denied;
  }

  Future<int> _androidSdkVersion() async {
    if (!Platform.isAndroid) return 0;
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  }

  Future<PermissionState> requestStoragePermission() async {
    if (Platform.isAndroid) {
      final sdk = await _androidSdkVersion();

      if (sdk >= 33) {
        final image = await ph.Permission.photos.request();
        final video = await ph.Permission.videos.request();
        final audio = await ph.Permission.audio.request();

        if (image.isGranted && video.isGranted && audio.isGranted) {
          return PermissionState.granted;
        }
        if (image.isPermanentlyDenied ||
            video.isPermanentlyDenied ||
            audio.isPermanentlyDenied) {
          return PermissionState.permanentlyDenied;
        }
        return PermissionState.denied;
      } else if (sdk >= 30) {
        final status = await ph.Permission.manageExternalStorage.request();
        return _checkPermissionState(status);
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

      if (sdk >= 33) {
        final image = await ph.Permission.photos.status;
        final video = await ph.Permission.videos.status;
        final audio = await ph.Permission.audio.status;
        if (image.isGranted && video.isGranted && audio.isGranted) {
          return PermissionState.granted;
        }
        if (image.isPermanentlyDenied ||
            video.isPermanentlyDenied ||
            audio.isPermanentlyDenied) {
          return PermissionState.permanentlyDenied;
        }
        return PermissionState.denied;
      } else if (sdk >= 30) {
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
