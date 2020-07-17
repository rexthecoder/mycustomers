import 'package:permission_handler/permission_handler.dart';
import 'package:mockito/mockito.dart';

abstract class IPermissionService {
  Future<bool> getContactsPermission();

  Future<bool> getStoragePermission();
}

class PermissionService implements IPermissionService {
  @override
  Future<bool> getContactsPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] == PermissionStatus.granted;
    } else {
      return permission == PermissionStatus.granted;
    }
  }

  @override
  Future<bool> getStoragePermission() async {
    final PermissionStatus permission = await Permission.storage.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.storage].request();
      return permissionStatus[Permission.storage] == PermissionStatus.denied;
    } else {
      return permission == PermissionStatus.granted;
    }
  }
}

class MockPermissions extends Mock implements IPermissionService {}
