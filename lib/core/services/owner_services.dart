import 'package:mycustomers/core/models/customer.dart';
import 'permissions.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:mockito/mockito.dart';

class IOwnerServices {
  getPhoneContacts() {}
}

class MockOwnerService extends Mock implements IOwnerServices {
  
}

class OwnerServices implements IOwnerServices {

  Permissions _permission = new Permissions();

  // method to get contacts from the user's device
  @override
  Future<List> getPhoneContacts({String query}) async {
    List<Contact> contacts = <Contact>[];
    final bool isPermitted =
        await _permission.getContactsPermission();
    if (isPermitted) {
      final Iterable<Contact> rawContacts = await ContactsService.getContacts(query: query);
      contacts = rawContacts.toList();
      var newContacts = contacts.map((contact) => Customer.fromJson({
        'name': contact.givenName.isEmpty ? contact.displayName : contact.givenName,
        'lastname': contact.familyName,
        'phone': contact.phones.toList().isEmpty ? '' : contact.phones.toList()[0].value,
        'email': contact.emails.toList().isEmpty ? '' : contact.emails.toList()[0].value,
      })).toList(); 
      return newContacts;
    }
    return contacts;
  }

}
