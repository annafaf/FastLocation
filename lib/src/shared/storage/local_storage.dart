import 'package:hive_flutter/hive_flutter.dart';
import '../../modules/home/model/address_model.dart';

/// Configuração central do armazenamento local (Hive) usado pelo módulo home/history.
class LocalStorage {
  LocalStorage._();
  static const String addressesBoxName = 'addresses';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AddressModelAdapter());
    await Hive.openBox<AddressModel>(addressesBoxName);
  }

  static Box<AddressModel> get addressesBox => Hive.box<AddressModel>(addressesBoxName);
}
