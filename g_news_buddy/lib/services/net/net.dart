import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'error_handler.dart';
import 'headers.dart';

const showCustomServerError = true;

typedef ONCOMPLETE = void Function(http.Response response);
typedef ONERROR = void Function(Exception);
typedef ONTIMEOUT = void Function();

// ignore: constant_identifier_names
enum HttpMethods { GET, POST, PUT, PATCH, DELETE }

class Net {
  static Map<String, Net> netWorkRequestsStack = {};

  Uri? _uri;
  Map<String, String>? _header;
  HttpMethods? _httpMethod;
  String? _url;
  Map<String, dynamic>? _queryParams;
  String? _contentType;

  int? _autoRetryCount;
  bool _isAutoRetry = false;
  late int _timeOut;
  Map<String, dynamic>? _body;
  ONCOMPLETE? onComplete;
  ONERROR? onError;
  ONTIMEOUT? onTimeOut;

  Net();

  Net.init(
      {required HttpMethods httpMethod,
      String? url,
      Map<String, String>? headers,
      bool authenticate = true,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? body,
      String contentType = "application/json",
      int timeOut = 5,
      int autoRetryCount = 0,
      bool isAutoRetry = false,
      Uri? uri,
      bool rawResponse = false})
      : assert(uri != null || url != null) {
    _url = url;
    _header = headers;
    _queryParams = queryParams;
    _contentType = contentType;
    _timeOut = timeOut;
    _httpMethod = httpMethod;
    _autoRetryCount = autoRetryCount;
    _isAutoRetry = isAutoRetry;
    _body = body;
    _uri = uri;
  }

//GET
  Future<http.Response?> _get() async {
    _httpMethod = HttpMethods.GET;

    try {
      _uri = _uri ?? _buildUri(url: _url, queryParams: _queryParams);
      // logger.i("url - $_httpMethod - ${_uri.toString()}");

      _header ??= await ReqHeaders().getHeader(_contentType);

      if (_uri == null) throw Exception('Invalid URL argument');

      final response = await http
          .get(_uri!, headers: _header)
          .timeout(Duration(seconds: _timeOut), onTimeout: () {
        if (_isAutoRetry) {
          _autoRetry();
          return http.Response("TimeOut", 408);
        } else {
          if (onTimeOut != null) {
            onTimeOut!();
          }

          throw Exception("Time out - ${_uri.toString()}");
        }
      });

      if (response.statusCode == 408) return null;

      // logger.i(response.body);
      var errorMessage = NetworkErrorHandler().handleRequest(response);
      if (errorMessage != null) throw errorMessage;

      _removeMeFromNetWorkRequestsStack();

      if (onComplete != null) {
        onComplete!(response);
      }

      return response;
    } on Exception catch (error) {
      _addMeToNetWorkRequestsStack();
      //  logger.e(error);
      if (onError != null) {
        onError!(error);
      }
      return null;
    }
  }

  //POST
  Future _post() async {
    _httpMethod = HttpMethods.POST;

    try {
      _uri = _uri ?? _buildUri(url: _url, queryParams: _queryParams);
      // logger.i("url - $_httpMethod - ${_uri.toString()}");

      _header ??= await ReqHeaders().getHeader(_contentType);

      if (_uri == null) throw Exception('Invalid URL argument');

      final response = await http
          .post(_uri!,
              headers: _header,
              body: json.encode(_body))
          .timeout(Duration(seconds: _timeOut), onTimeout: () {
        if (_isAutoRetry) {
          _autoRetry();
          return http.Response("TimeOut", 408);
        } else {
          if (onTimeOut != null) {
            onTimeOut!();
          }
          throw Exception("Time out - ${_uri.toString()}");
        }
      });

      if (response.statusCode == 408) return;

      // logger.i(response.body);
      var errorMessage = NetworkErrorHandler().handleRequest(response);
      if (errorMessage != null) throw errorMessage;

      _removeMeFromNetWorkRequestsStack();

      if (onComplete != null) {
        onComplete!(response);
      }
    } on Exception catch (error) {
      _addMeToNetWorkRequestsStack();
      //  logger.e(error);
      if (onError != null) {
        onError!(error);
      }
    }
  }

  int _autoRetriedCount = 0;
  _autoRetry() {
    _autoRetriedCount++;
    if (_autoRetriedCount == _autoRetryCount) {
      _isAutoRetry = false;
    }
    // logger.i("Auto retry count $_autoRetriedCount");
    execute();
  }

  _addMeToNetWorkRequestsStack() {
    netWorkRequestsStack[_uri!.path] = this;
    // logger.i("netWorkRequestsStack length ${netWorkRequestsStack.length}");
  }

  _removeMeFromNetWorkRequestsStack() {
    netWorkRequestsStack.remove(_uri!.path);
  }

  Future<http.Response?> execute() async {
    switch (_httpMethod) {
      case HttpMethods.GET:
        final response = await _get();
        return response;
        
      case HttpMethods.POST:
        await _post();
        break;
      default:
      //await _get();
    }
    return null;
  }

  static void resendFailedRequest() {
    netWorkRequestsStack.forEach((key, value) {
      value.execute();
    });
  }

  //build Uri
  Uri? _buildUri({String? url, Map<String, dynamic>? queryParams}) {
    if (_uri != null) {
      return _uri;
    }
    Uri uri;
    uri = Uri.parse(url!);

    if (queryParams != null) {
     uri = uri.replace(queryParameters: queryParams);
    }
    // uri = Uri(
    //     scheme: ssl == true ? 'https' : 'http',
    //     host: host,
    //     port: port,
    //     path: url,
    //     queryParameters: queryParams);
    return uri;
  }
}
