import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../controller/history_controller.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.controller});
  final HistoryController controller;
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    // Carregamento automático do histórico ao acessar a página.
    widget.controller.loadHistory();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Histórico')),
        body: Observer(builder: (_) {
          final items = widget.controller.items;
          if (items.isEmpty) return const Center(child: Text('Nenhuma consulta realizada.'));
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            itemBuilder: (_, i) => Card(
              child: ListTile(leading: const Icon(Icons.history), title: Text(items[i].cep), subtitle: Text(items[i].fullAddress)),
            ),
          );
        }),
      );
}
