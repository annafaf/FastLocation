import 'package:flutter/material.dart';

/// Indicador de carregamento compartilhado entre os módulos durante consultas externas.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()),
      );
}
