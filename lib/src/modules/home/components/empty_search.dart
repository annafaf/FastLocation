import 'package:flutter/material.dart';

/// Componente exibido quando a busca ainda não foi realizada ou não retornou resultados.
class EmptySearch extends StatelessWidget {
  const EmptySearch({super.key, this.message = 'O resultado da consulta aparecerá aqui.'});
  final String message;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(padding: const EdgeInsets.all(18), child: Text(message)),
      );
}
