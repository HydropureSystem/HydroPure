import 'package:dio/dio.dart';

class MarketProvider {

  final Dio dio = Dio();

  Future<Response> getMarketHome() {
    return dio.get(
      'http://10.83.92.116:1000/market/home',
    );
  }

  Future<Response> getMarketTrend() {
    return dio.get(
      'http://10.83.92.116:1000/market/trends',
    );
  }
}