import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/services/http/http_service.dart';
import 'package:mycustomers/core/constants/api_routes.dart';
import 'package:mycustomers/core/exceptions/create_exception.dart';
import 'package:mycustomers/core/utils/logger.dart';


class StoreService {
  static String baseStoreRoute = ApiRoutes.user;
  HttpService _http = locator<HttpService>();
  String _newRoute = '$baseStoreRoute/new';

  Future<void> createStore(String storeName, {String shopAddress: '-'}) async {
    try {
      // Send the request to the API with the data
      Map response = await _http.postHttp(_newRoute, {
        'store_name': storeName,
        'shop_address': shopAddress,
      });

      // Check if the status is true
      if (response.containsKey('status') && response['status']) {
        // TODO: Add what should happen if create is successful
      } else if (response.containsKey('message')) {
        Logger.e('Error creating store: ${response['message']}');
        throw CreateException(response['message']);
      } else {
        Logger.e('Error creating store: Unknown Error');
        throw CreateException('Bad response from server');
      }

      // TODO: Add what should happen after creating new store
    } on CreateException catch(e, s) {
      Logger.e('Error creating store: ${e.message}', e: e, s: s);
      throw e;
    } catch(e, s) {
      Logger.e('Error creating store $storeName with location: $shopAddress', e: e, s: s);
      throw CreateException('Unknown error while trying to update details');
    }
  }
}
