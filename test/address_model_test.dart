import 'package:flutter_test/flutter_test.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';

void main() {
  group('AddressModel', () {
    test('fromJson converte campos da API ViaCEP', () {
      final model = AddressModel.fromJson({
        'cep': '14801-000',
        'logradouro': 'Rua Exemplo',
        'complemento': '',
        'bairro': 'Centro',
        'localidade': 'Araraquara',
        'uf': 'SP',
      });
      expect(model.cep, '14801-000');
      expect(model.logradouro, 'Rua Exemplo');
      expect(model.bairro, 'Centro');
      expect(model.localidade, 'Araraquara');
      expect(model.uf, 'SP');
    });

    test('fullAddress junta logradouro, bairro e cidade/UF', () {
      final model = AddressModel.fromJson({
        'cep': '14801-000',
        'logradouro': 'Rua Exemplo',
        'complemento': '',
        'bairro': 'Centro',
        'localidade': 'Araraquara',
        'uf': 'SP',
      });
      expect(model.fullAddress, 'Rua Exemplo, Centro, Araraquara - SP');
    });

    test('copyWithConsultedAt preserva os dados e define a data', () {
      final original = AddressModel.fromJson({
        'cep': '14801-000',
        'logradouro': 'Rua Exemplo',
        'complemento': '',
        'bairro': 'Centro',
        'localidade': 'Araraquara',
        'uf': 'SP',
      });
      final date = DateTime(2026, 1, 1);
      final stamped = original.copyWithConsultedAt(date);

      expect(stamped.cep, original.cep);
      expect(stamped.fullAddress, original.fullAddress);
      expect(stamped.consultedAt, date);
    });
  });
}
