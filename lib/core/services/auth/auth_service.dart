import 'package:mycustomers/core/models/user.dart';

abstract class AuthService {
  User get currentUser;

  Future<void> signUpWithPhoneNumber(
    String phoneNumber,
    String password,
  );

  Future<void> signInWithPhoneNumber(
    String phoneNumber,
    String password,
  );

  Future<void> signOut();

  Future<bool> get isUserLoggedIn;
}
