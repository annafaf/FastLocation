import 'package:flutter_test/flutter_test.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:fast_location/src/modules/home/service/address_service.dart';
import 'package:fast_location/src/modules/history/controller/history_controller.dart';
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
  group('HistoryController', () {
    test('loadHistory carrega os itens salvos no repositório local', () async {
      final local = FakeAddressLocalRepository();
      final service = AddressService(FakeAddressApiRepository(), local);
      await local.save(_sample());
      final controller = HistoryController(service);

      controller.loadHistory();

      expect(controller.items, hasLength(1));
    });

    test('sem consultas anteriores, a lista permanece vazia', () {
      final service = AddressService(FakeAddressApiRepository(), FakeAddressLocalRepository());
      final controller = HistoryController(service);

      controller.loadHistory();

      expect(controller.items, isEmpty);
    });
  });
}
