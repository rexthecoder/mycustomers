class Validators {
  String validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.length < 10 || !RegExp(r'[0-9]').hasMatch(phoneNumber)) {
      return 'Enter a Valid Phone Number';
    }
    return null;
  }
}
