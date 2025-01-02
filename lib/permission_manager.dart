import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  Future<bool> checkPermission(Permission permission) async {
    PermissionStatus status = await permission.status;
    return status.isGranted;
  }

  Future<bool> requestPermission(Permission permission) async {
    PermissionStatus result = await permission.request();
    if (result.isGranted) {
      return true;
    } else if (result.isPermanentlyDenied) {
      openAppSettings();
      return false;
    }
    return false;
  }

  Future<void> checkRequestPermission(
    Permission permission,
    Function onGranted,
  ) async {
    if (await checkPermission(permission)) {
      onGranted();
    } else {
      if (await requestPermission(permission)) {
        onGranted();
      } else {
        if (await requestPermission(permission)) {
          onGranted();
        }
      }
    }
  }
}
