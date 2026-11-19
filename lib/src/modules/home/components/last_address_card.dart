import 'package:flutter/material.dart';
import '../model/address_model.dart';

/// Componente de destaque do último endereço consultado, com atalho para traçar rota.
class LastAddressCard extends StatelessWidget {
  const LastAddressCard({super.key, required this.address, required this.onRoute});
  final AddressModel address;
  final VoidCallback onRoute;

  @override
  Widget build(BuildContext context) => Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: ListTile(
          leading: const Icon(Icons.history_toggle_off),
          title: const Text('Última consulta'),
          subtitle: Text('${address.cep} • ${address.fullAddress}'),
          trailing: IconButton(tooltip: 'Traçar rota', icon: const Icon(Icons.directions), onPressed: onRoute),
        ),
      );
}
