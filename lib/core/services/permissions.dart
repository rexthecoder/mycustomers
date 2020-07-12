import 'package:permission_handler/permission_handler.dart';
import 'package:mockito/mockito.dart';

class Permissions {

  Future<bool> getContactsPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ==
          PermissionStatus.denied;
    } else {
      return permission == PermissionStatus.granted;
    }
  }
}

class MockPermissions extends Mock implements Permissions {
  
}
