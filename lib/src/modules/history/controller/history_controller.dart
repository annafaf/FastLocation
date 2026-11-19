import 'package:mobx/mobx.dart';
import '../../home/model/address_model.dart';
import '../../home/service/address_service.dart';

part 'history_controller.g.dart';

// ignore: library_private_types_in_public_api
class HistoryController = HistoryControllerBase with _$HistoryController;

/// Controller MobX da tela de histórico: carrega os dados persistidos localmente.
abstract class HistoryControllerBase with Store {
  HistoryControllerBase(this._service);
  final AddressService _service;

  @observable
  ObservableList<AddressModel> items = ObservableList<AddressModel>();

  @action
  void loadHistory() {
    items = ObservableList.of(_service.history());
  }
}
