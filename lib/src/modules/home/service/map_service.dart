import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import '../model/address_model.dart';

/// Traça a rota da localização atual do dispositivo até o endereço consultado.
class MapService {
  static Future<void> openRoute(AddressModel address) async {
    final query = [address.logradouro, address.bairro, address.localidade, address.uf, address.cep, 'Brasil']
        .where((s) => s.trim().isNotEmpty).join(', ');
    if (query.isEmpty) throw Exception('Endereço insuficiente para localizar no mapa.');
    final places = await locationFromAddress(query);
    if (places.isEmpty) throw Exception('Não foi possível localizar o endereço no mapa.');

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      throw Exception('Permita o acesso à localização para traçar a rota.');
    }
    final current = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final destination = places.first;
    final maps = await MapLauncher.installedMaps;
    if (maps.isEmpty) throw Exception('Nenhum aplicativo de mapas disponível.');
    await maps.first.showDirections(
      destination: Coords(destination.latitude, destination.longitude),
      origin: Coords(current.latitude, current.longitude),
      destinationTitle: address.fullAddress,
    );
  }
}
