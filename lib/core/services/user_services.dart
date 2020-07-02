import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:mycustomers/core/services/http/http_service.dart';
import 'package:mycustomers/core/constants/api_routes.dart';
//import 'package:mycustomers/core/exceptions/auth_exception.dart';
import 'package:mycustomers/core/models/user.dart';
import 'package:mycustomers/core/utils/logger.dart';


class UserService {
  static String baseUserRoute = ApiRoutes.user;
  HttpService _http = locator<HttpService>();
  AuthService _auth = locator<AuthService>();
  String _updateRoute = '$baseUserRoute/update';
//  String _getRoute = baseUserRoute;
//  String _deleteRoute = '$baseUserRoute/delete';

  Future<void> updateUser(String userId, {Map updateData}) async {
    try {
      // Send the request to the API with the data
      Map response = await _http.putHttp(_updateRoute, updateData);

      // Check if the status is true
      if (response.containsKey('status') && response['status']) {
        // TODO: Add what should happen if update is successful
      } else {
        throw Exception(response.containsKey('message')
            ? response['message']
            : 'Bad response: $response');
      }

      _auth.updateCurrentUser(User.fromJson(response['local'])
      ..id = response['_id']
      );
    } on Exception catch(e, s) {
      Logger.e('Error updating User $userId with data: $updateData', e: e, s: s);
    }
  }
}
