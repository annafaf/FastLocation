import 'package:flutter/material.dart';
import '../model/address_model.dart';

class AddressList extends StatelessWidget {
  const AddressList({super.key, required this.addresses, required this.onRoute});
  final List<AddressModel> addresses;
  final void Function(AddressModel) onRoute;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Resultados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          for (final address in addresses)
            AddressListItem(address: address, onRoute: () => onRoute(address)),
        ],
      );
}

class AddressListItem extends StatelessWidget {
  const AddressListItem({super.key, required this.address, required this.onRoute});
  final AddressModel address;
  final VoidCallback onRoute;

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          leading: const Icon(Icons.location_on),
          title: Text(address.cep),
          subtitle: Text(address.fullAddress),
          trailing: IconButton(tooltip: 'Traçar rota', icon: const Icon(Icons.directions), onPressed: onRoute),
        ),
      );
}
