import 'package:dio/dio.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/exceptions/auth_exception.dart';
import 'package:mycustomers/core/exceptions/network_exception.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:mycustomers/core/services/auth/auth_service_impl.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:mycustomers/core/utils/network_utils.dart' as network_utils;


import 'http_service.dart';

/// Helper service that abstracts away common HTTP Requests
class HttpServiceImpl implements HttpService {

  final _dio = Dio(BaseOptions(connectTimeout: 6000));

  setHeader(Map<String, dynamic> header) {
    _dio.options.headers.addAll(header);
  }

  @override
  Future<dynamic> getHttp(String route, {Map<String, dynamic> params, bool refreshed: false}) async {
    Response response;

    Logger.d('[GET] Sending $params to $route');

    try {
      final fullRoute = '$route';
      response = await _dio.get(
        fullRoute,
        queryParameters: params,
        options: Options(
          contentType: 'application/json',
        ),
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        if (!refreshed) {
          await AuthServiceImpl.refreshToken();
          return await getHttp(route, params: params, refreshed: true);
        }
        throw AuthException('Invalid token and credentials');
      }
      Logger.e('HttpService: Failed to GET $route: Error message: ${e.message}');
      print('Http response data is: ${e.response?.data}');
      throw NetworkException(e.response?.data != null ? e.response.data['message'] ?? e.message : e.message);
    }

    network_utils.checkForNetworkExceptions(response);

    Logger.d('Received Response: $response');

    // For this specific API its decodes json for us
    return response.data;
  }

  @override
  Future<dynamic> postHttp(String route, dynamic body, {Map<String, dynamic> params, refreshed: false}) async {
    Response response;

    Logger.d('[POST] Sending $body to $route');

    try {
      final fullRoute = '$route';
      response = await _dio.post(
        fullRoute,
        data: body,
        queryParameters: params,
        onSendProgress: network_utils.showLoadingProgress,
        onReceiveProgress: network_utils.showLoadingProgress,
        options: Options(
          contentType: 'application/json',
        ),
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        if (!refreshed) {
          await AuthServiceImpl.refreshToken();
          return await postHttp(route, body, params: params, refreshed: true);
        }
        throw AuthException('Invalid token and credentials');
      }
      Logger.e('HttpService: Failed to POST ${e.message}');
      print('Http response data is: ${e.response?.data}');
      throw NetworkException(e.response?.data != null ? e.response.data['message'] ?? e.message : e.message);
    }

    network_utils.checkForNetworkExceptions(response);

    Logger.d('Received Response: $response');

    // For this specific API its decodes json for us
    return response.data;
  }

  @override
  void dispose() {
    _dio.clear();
    _dio.close(force: true);
  }

  @override
  clearHeaders() {
    _dio.options.headers.clear();
  }

  @override
  Future putHttp(String route, body, {Map<String, dynamic> params, refreshed: false}) async {
    Response response;

    Logger.d('[PUT] Sending $body to $route');

    try {
      final fullRoute = '$route';
      response = await _dio.put(
        fullRoute,
        data: body,
        queryParameters: params,
        onSendProgress: network_utils.showLoadingProgress,
        onReceiveProgress: network_utils.showLoadingProgress,
        options: Options(
          contentType: 'application/json',
        ),
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        if (!refreshed) {
          await AuthServiceImpl.refreshToken();
          return await putHttp(route, body, params: params, refreshed: true);
        }
        throw AuthException('Invalid token and credentials');
      }
      Logger.e('HttpService: Failed to PUT ${e.message}');
      print('Http response data is: ${e.response?.data}');
      throw NetworkException(e.response?.data != null ? e.response.data['message'] ?? e.message : e.message);
    }

    network_utils.checkForNetworkExceptions(response);

    // For this specific API its decodes json for us
    return response.data;
  }

  @override
  Future deleteHttp(String route, {Map<String, dynamic> params, refreshed: false}) async {
    Response response;

    Logger.d('[DELETE] Sending $params to $route');

    try {
      final fullRoute = '$route';
      response = await _dio.delete(
        fullRoute,
        queryParameters: params,
        options: Options(
          contentType: 'application/json',
        ),
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        if (!refreshed) {
          await AuthServiceImpl.refreshToken();
          return await deleteHttp(route, params: params, refreshed: true);
        }
        throw AuthException('Invalid token and credentials');
      }
      Logger.e('HttpService: Failed to DELETE $route: Error message: ${e.message}');
      print('Http response data is: ${e.response?.data}');
      throw NetworkException(e.response?.data != null ? e.response.data['message'] ?? e.message : e.message);
    }

    network_utils.checkForNetworkExceptions(response);

    Logger.d('Received Response: $response');

    // For this specific API its decodes json for us
    return response.data;
  }
}
