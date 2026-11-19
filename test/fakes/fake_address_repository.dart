import 'package:dio/dio.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:fast_location/src/modules/home/repositories/address_api_repository.dart';
import 'package:fast_location/src/modules/home/repositories/address_local_repository.dart';

/// Repositório de API falso para testes: não acessa rede.
class FakeAddressApiRepository extends AddressApiRepository {
  FakeAddressApiRepository({this.cepResult = const [], this.addressResult = const []}) : super(Dio());

  final List<AddressModel> cepResult;
  final List<AddressModel> addressResult;

  @override
  Future<List<AddressModel>> byCep(String cep) async => cepResult;

  @override
  Future<List<AddressModel>> byAddress(String uf, String city, String street) async => addressResult;
}

/// Repositório local falso para testes: mantém os dados em memória, sem Hive.
class FakeAddressLocalRepository extends AddressLocalRepository {
  final List<AddressModel> saved = [];

  @override
  Future<void> save(AddressModel address) async => saved.add(address);

  @override
  List<AddressModel> history() => saved.reversed.toList();
}
