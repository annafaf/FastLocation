import 'package:dio/dio.dart';

class DioClient {
  DioClient._();
  static final Dio instance = Dio(BaseOptions(
    baseUrl: 'https://viacep.com.br/ws/',
    connectTimeout: 10000,
    receiveTimeout: 10000,
  ));
}
