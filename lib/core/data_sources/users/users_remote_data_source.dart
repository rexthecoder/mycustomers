import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/api_routes.dart';
import 'package:mycustomers/core/models/user.dart';
import 'package:mycustomers/core/services/http/http_service.dart';

abstract class UsersRemoteDataSource {
  Future<User> fetchUser(int id);
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  final httpService = locator<HttpService>();

  @override
  Future<User> fetchUser(int id) async {
    final postsMap = await httpService.getHttp('${ApiRoutes.user}/$id')
        as Map<String, dynamic>;

    // return User.fromJson(postsMap); 
  }
}
