import '../../../shared/storage/local_storage.dart';
import '../model/address_model.dart';

class AddressLocalRepository {
  Future<void> save(AddressModel address) {
    final stamped = address.copyWithConsultedAt(address.consultedAt ?? DateTime.now());
    return LocalStorage.addressesBox.add(stamped);
  }

  List<AddressModel> history() => LocalStorage.addressesBox.values.toList().reversed.toList();
}
