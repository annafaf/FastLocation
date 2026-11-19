import 'package:flutter_test/flutter_test.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:fast_location/src/modules/home/service/address_service.dart';
import 'fakes/fake_address_repository.dart';

AddressModel _sample() => AddressModel.fromJson({
  'cep': '14801-000',
  'logradouro': 'Rua Exemplo',
  'complemento': '',
  'bairro': 'Centro',
  'localidade': 'Araraquara',
  'uf': 'SP',
});

void main() {
  group('AddressService', () {
    test('searchCep retorna resultados e salva no histórico', () async {
      final api = FakeAddressApiRepository(cepResult: [_sample()]);
      final local = FakeAddressLocalRepository();
      final service = AddressService(api, local);

      final result = await service.searchCep('14801000');

      expect(result, hasLength(1));
      expect(local.saved, hasLength(1));
      expect(service.history(), hasLength(1));
    });

    test('searchCep com CEP inválido não chama a API', () async {
      final api = FakeAddressApiRepository(cepResult: [_sample()]);
      final local = FakeAddressLocalRepository();
      final service = AddressService(api, local);

      expect(() => service.searchCep('123'), throwsException);
      expect(local.saved, isEmpty);
    });

    test('searchAddress retorna resultados e salva cada um no histórico', () async {
      final api = FakeAddressApiRepository(addressResult: [_sample(), _sample()]);
      final local = FakeAddressLocalRepository();
      final service = AddressService(api, local);

      final result = await service.searchAddress('SP', 'Araraquara', 'Rua Exemplo');

      expect(result, hasLength(2));
      expect(local.saved, hasLength(2));
    });

    test('searchAddress com campos incompletos lança erro', () async {
      final api = FakeAddressApiRepository();
      final local = FakeAddressLocalRepository();
      final service = AddressService(api, local);

      expect(() => service.searchAddress('S', '', 'Rua Exemplo'), throwsException);
    });
  });
}
