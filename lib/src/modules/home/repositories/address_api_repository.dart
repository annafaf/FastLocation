import 'package:dio/dio.dart';
import '../model/address_model.dart';

class AddressApiRepository {
  AddressApiRepository(this._dio);
  final Dio _dio;

  Future<List<AddressModel>> byCep(String cep) async {
    final response = await _dio.get('$cep/json/');
    if (response.data is! Map || response.data['erro'] == true) return [];
    return [AddressModel.fromJson(Map<String, dynamic>.from(response.data))];
  }

  Future<List<AddressModel>> byAddress(String uf, String city, String street) async {
    final url = '${uf.toUpperCase()}/${Uri.encodeComponent(city)}/${Uri.encodeComponent(street)}/json/';
    final response = await _dio.get(url);
    if (response.data is! List) return [];
    return (response.data as List)
        .whereType<Map>()
        .map((e) => AddressModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
