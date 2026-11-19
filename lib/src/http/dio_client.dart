import 'package:dio/dio.dart';

/// Configuração única do Dio usada para comunicação com a API pública do ViaCEP.
class DioClient {
  DioClient._();
  static final Dio instance = Dio(BaseOptions(
    baseUrl: 'https://viacep.com.br/ws/',
    connectTimeout: 10000,
    receiveTimeout: 10000,
  ));
}
