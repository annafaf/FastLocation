// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HistoryController on HistoryControllerBase, Store {
  late final _$itemsAtom =
      Atom(name: 'HistoryControllerBase.items', context: context);

  @override
  ObservableList<AddressModel> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<AddressModel> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$HistoryControllerBaseActionController =
      ActionController(name: 'HistoryControllerBase', context: context);

  @override
  void loadHistory() {
    final _$actionInfo = _$HistoryControllerBaseActionController.startAction(
        name: 'HistoryControllerBase.loadHistory');
    try {
      return super.loadHistory();
    } finally {
      _$HistoryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items}
    ''';
  }
}
