import 'package:dio/dio.dart';

class MarketProvider {

  final Dio dio = Dio();

  Future<Response> getMarketHome() {
    return dio.get(
      'http://192.168.1.3:1000/market/home',
    );
  }

  Future<Response> getMarketTrend() {
    return dio.get(
      'http://192.168.1.3:1000/market/trends',
    );
  }
}