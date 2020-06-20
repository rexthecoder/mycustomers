import 'permissions.dart';
import 'package:contacts_service/contacts_service.dart';

class IOwnerServices {
  getPhoneContacts() {}
}

class OwnerServices implements IOwnerServices {

  Permissions _permission = new Permissions();

  // method to get contacts from the user's device
  @override
  Future<List> getPhoneContacts() async {
    var contacts = [];
    final bool isPermitted =
        await _permission.getContactsPermission();
    if (isPermitted) {
      final Iterable<Contact> rawContacts = await ContactsService.getContacts();
      return rawContacts.toList();    
    }
    return contacts;
  }

}
