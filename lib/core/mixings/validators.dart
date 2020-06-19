class Validators {
  String validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.length < 10) {
      return 'Enter a Valid Phone Number';
    }
    return null;
  }
}
