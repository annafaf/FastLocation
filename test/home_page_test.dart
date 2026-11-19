import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:fast_location/src/modules/home/service/address_service.dart';
import 'package:fast_location/src/modules/home/controller/home_controller.dart';
import 'package:fast_location/src/modules/home/components/address_list.dart';
import 'package:fast_location/src/modules/home/page/home_page.dart';
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
  testWidgets('busca por CEP exibe o endereço retornado', (tester) async {
    final service = AddressService(FakeAddressApiRepository(cepResult: [_sample()]), FakeAddressLocalRepository());
    final controller = HomeController(service);

    await tester.pumpWidget(MaterialApp(home: HomePage(controller: controller)));

    await tester.enterText(find.byType(TextField).first, '14801000');
    await tester.tap(find.text('Consultar endereço'));
    await tester.pumpAndSettle();

    expect(find.descendant(of: find.byType(AddressListItem), matching: find.text('14801-000')), findsOneWidget);
    expect(find.text('Rua Exemplo, Centro, Araraquara - SP'), findsOneWidget);
  });

  testWidgets('estado inicial mostra texto de placeholder', (tester) async {
    final service = AddressService(FakeAddressApiRepository(), FakeAddressLocalRepository());
    final controller = HomeController(service);

    await tester.pumpWidget(MaterialApp(home: HomePage(controller: controller)));

    expect(find.text('O resultado da consulta aparecerá aqui.'), findsOneWidget);
  });
}
