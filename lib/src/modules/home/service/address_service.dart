import '../model/address_model.dart';
import '../repositories/address_api_repository.dart';
import '../repositories/address_local_repository.dart';

class AddressService {
  AddressService(this._apiRepository, this._localRepository);
  final AddressApiRepository _apiRepository;
  final AddressLocalRepository _localRepository;

  Future<List<AddressModel>> searchCep(String cep) async {
    final digits = cep.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 8) throw Exception('Informe um CEP com 8 números.');
    final result = await _apiRepository.byCep(digits);
    for (final address in result) {
      await _localRepository.save(address);
    }
    return result;
  }

  Future<List<AddressModel>> searchAddress(String uf, String city, String street) async {
    if (uf.trim().length != 2 || city.trim().isEmpty || street.trim().isEmpty) {
      throw Exception('Preencha UF, cidade e logradouro.');
    }
    final result = await _apiRepository.byAddress(uf, city, street);
    for (final address in result) {
      await _localRepository.save(address);
    }
    return result;
  }

  List<AddressModel> history() => _localRepository.history();
}
