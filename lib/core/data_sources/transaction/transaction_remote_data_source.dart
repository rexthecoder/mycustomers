import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/api_routes.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:mycustomers/core/services/http/http_service.dart';
import 'package:mycustomers/core/utils/logger.dart';
import '../../extensions/transaction_extension.dart';

abstract class TransactionRemoteDataSource {
  Future<void> fetchTransaction();
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final _hiveService = locator<HiveInterface>();
  final HttpService _http = locator<HttpService>();
  final _auth = locator<AuthService>();
  Map<String, TransactionModel> alltransactions;

  @override
  Future<void> fetchTransaction()async {
    List<TransactionModel> temp = [];
    try {      
      await _http.getHttp('').then((value) {
        value.forEach((val){
          temp.add(List.from(val).map((e) => TransactionModel.fromjson(e)).toList()[0]);
        });
        alltransactions = temp.helperToMap();
      });
    } on DioError catch (e, s) {
      Logger.e('Error: $e\nStacktrace\n$s', s: s, e: e);
      rethrow;
    } catch (e, s) {
      Logger.e('Error: $e\nStacktrace\n$s', s: s, e: e);
    }
  }

  Future<void> updateTransaction() async {
  }
}
