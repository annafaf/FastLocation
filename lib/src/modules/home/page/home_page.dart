import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/components/loading_indicator.dart';
import '../../../shared/metrics/app_metrics.dart';
import '../components/address_list.dart';
import '../components/empty_search.dart';
import '../components/last_address_card.dart';
import '../controller/home_controller.dart';
import '../model/address_model.dart';
import '../service/map_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.controller});
  final HomeController controller;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cep = TextEditingController();
  final uf = TextEditingController();
  final city = TextEditingController();
  final street = TextEditingController();
  int mode = 0;
  late final ReactionDisposer _errorReaction;

  @override
  void initState() {
    super.initState();
    // Reação do MobX: exibe um aviso sempre que a consulta resultar em erro.
    _errorReaction = reaction<String?>((_) => widget.controller.error, (message) {
      if (message == null || !mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    });
  }

  @override
  void dispose() {
    _errorReaction();
    cep.dispose();
    uf.dispose();
    city.dispose();
    street.dispose();
    super.dispose();
  }

  Future<void> _route(AddressModel address) async {
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(const SnackBar(content: Text('Traçando rota...')));
    try {
      await MapService.openRoute(address);
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))));
    }
  }

  void _search() {
    FocusScope.of(context).unfocus();
    mode == 0 ? widget.controller.searchCep(cep.text) : widget.controller.searchAddress(uf.text, city.text, street.text);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('FastLocation'),
          actions: [
            IconButton(
              tooltip: 'Histórico',
              icon: const Icon(Icons.history),
              onPressed: () => Navigator.of(context).pushNamed(AppRoutes.history),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(AppMetrics.paddingLarge),
          children: [
            const Text('Encontre um endereço', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const SizedBox(height: AppMetrics.spacingSmall),
            const Text('Consulte pelo CEP ou pesquise pelo endereço.'),
            const SizedBox(height: AppMetrics.spacingLarge),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Por CEP')),
                ButtonSegment(value: 1, label: Text('Por endereço')),
              ],
              selected: {mode},
              onSelectionChanged: (v) => setState(() => mode = v.first),
            ),
            const SizedBox(height: AppMetrics.spacingMedium + 2),
            if (mode == 0)
              TextField(
                controller: cep,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'CEP', hintText: '14801-000', border: OutlineInputBorder()),
              )
            else ...[
              TextField(
                controller: uf,
                maxLength: 2,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(labelText: 'UF', hintText: 'SP', border: OutlineInputBorder()),
              ),
              const SizedBox(height: AppMetrics.spacingSmall),
              TextField(
                controller: city,
                decoration: const InputDecoration(labelText: 'Cidade', hintText: 'Araraquara', border: OutlineInputBorder()),
              ),
              const SizedBox(height: AppMetrics.spacingSmall),
              TextField(
                controller: street,
                decoration: const InputDecoration(labelText: 'Logradouro', hintText: 'Rua Exemplo', border: OutlineInputBorder()),
              ),
            ],
            const SizedBox(height: AppMetrics.spacingMedium),
            FilledButton.icon(
              onPressed: _search,
              icon: const Icon(Icons.search),
              label: const Text('Consultar endereço'),
            ),
            const SizedBox(height: AppMetrics.spacingLarge),
            Observer(builder: (_) {
              if (widget.controller.loading) return const LoadingIndicator();
              if (widget.controller.results.isEmpty) return const EmptySearch();
              final lastResult = widget.controller.lastResult;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (lastResult != null) ...[
                    LastAddressCard(address: lastResult, onRoute: () => _route(lastResult)),
                    const SizedBox(height: AppMetrics.spacingMedium),
                  ],
                  AddressList(addresses: widget.controller.results, onRoute: _route),
                ],
              );
            }),
          ],
        ),
      );
}
