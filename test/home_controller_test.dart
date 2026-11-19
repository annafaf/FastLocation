import 'package:flutter_test/flutter_test.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:fast_location/src/modules/home/service/address_service.dart';
import 'package:fast_location/src/modules/home/controller/home_controller.dart';
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
  group('HomeController', () {
    test('searchCep popula resultados e desliga o loading ao final', () async {
      final service = AddressService(FakeAddressApiRepository(cepResult: [_sample()]), FakeAddressLocalRepository());
      final controller = HomeController(service);

      await controller.searchCep('14801000');

      expect(controller.loading, isFalse);
      expect(controller.error, isNull);
      expect(controller.results, hasLength(1));
      expect(controller.lastResult?.cep, '14801-000');
    });

    test('searchCep sem resultado define mensagem de erro', () async {
      final service = AddressService(FakeAddressApiRepository(cepResult: const []), FakeAddressLocalRepository());
      final controller = HomeController(service);

      await controller.searchCep('14801000');

      expect(controller.results, isEmpty);
      expect(controller.error, 'CEP não encontrado.');
    });

    test('searchCep com CEP inválido define a mensagem de validação como erro', () async {
      final service = AddressService(FakeAddressApiRepository(), FakeAddressLocalRepository());
      final controller = HomeController(service);

      await controller.searchCep('123');

      expect(controller.loading, isFalse);
      expect(controller.error, 'Informe um CEP com 8 números.');
    });
  });
}
