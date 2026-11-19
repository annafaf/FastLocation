import 'package:mobx/mobx.dart';
import '../model/address_model.dart';
import '../service/address_service.dart';

part 'home_controller.g.dart';

// ignore: library_private_types_in_public_api
class HomeController = HomeControllerBase with _$HomeController;

/// Controller MobX da tela Home: dispara consultas e expõe o estado reativo para a página.
abstract class HomeControllerBase with Store {
  HomeControllerBase(this._service);
  final AddressService _service;

  @observable
  bool loading = false;

  @observable
  String? error;

  @observable
  ObservableList<AddressModel> results = ObservableList<AddressModel>();

  @computed
  AddressModel? get lastResult => results.isNotEmpty ? results.first : null;

  @action
  Future<void> searchCep(String cep) async {
    loading = true;
    error = null;
    results.clear();
    try {
      final result = await _service.searchCep(cep);
      results.addAll(result);
      if (result.isEmpty) error = 'CEP não encontrado.';
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> searchAddress(String uf, String city, String street) async {
    loading = true;
    error = null;
    results.clear();
    try {
      final result = await _service.searchAddress(uf, city, street);
      results.addAll(result);
      if (result.isEmpty) error = 'Nenhum endereço encontrado.';
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      loading = false;
    }
  }
}
