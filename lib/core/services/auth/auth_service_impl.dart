import 'package:mycustomers/core/exceptions/auth_exception.dart';
import 'package:mycustomers/core/models/user.dart';
import 'package:mycustomers/core/utils/logger.dart';

import 'auth_service.dart';

class AuthServiceImpl implements AuthService {
  User _currentUser;
  @override
  User get currentUser => _currentUser;

  @override
  Future<void> signUpWithPhoneNumber(
    String phoneNumber,
    String password,
  ) async {
    try {
      // authenticate with server
      await Future.delayed(Duration(milliseconds: 250));

      // fetch current user from server
      // _currentUser = User(
//TODO: Add when model is ready for user
      // );
    } on Exception {
      Logger.e('AuthService: Error signing up');
      throw AuthException('Error signing up');
    }
  }

  @override
  Future<void> signInWithPhoneNumber(
    String phonenumber,
    String password,
  ) async {
    try {
      // authenticate with server
      await Future.delayed(Duration(milliseconds: 250));

    //  // fetch current user from server
    // TODO: Uncomment below
      _currentUser = User()
      ..phone = phonenumber;
    } on Exception {
      Logger.e('AuthService: Error signing in');
      throw AuthException('Error signing in');
    }
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(Duration(milliseconds: 250));
    _currentUser = null;
  }

  @override
  Future<bool> isUserLoggedIn() async {
    // check server for login status
    await Future.delayed(Duration(seconds: 1));

    return _currentUser != null;
  }
}
