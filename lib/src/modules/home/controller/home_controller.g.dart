// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  Computed<AddressModel?>? _$lastResultComputed;

  @override
  AddressModel? get lastResult =>
      (_$lastResultComputed ??= Computed<AddressModel?>(() => super.lastResult,
              name: 'HomeControllerBase.lastResult'))
          .value;

  late final _$loadingAtom =
      Atom(name: 'HomeControllerBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'HomeControllerBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$resultsAtom =
      Atom(name: 'HomeControllerBase.results', context: context);

  @override
  ObservableList<AddressModel> get results {
    _$resultsAtom.reportRead();
    return super.results;
  }

  @override
  set results(ObservableList<AddressModel> value) {
    _$resultsAtom.reportWrite(value, super.results, () {
      super.results = value;
    });
  }

  late final _$searchCepAsyncAction =
      AsyncAction('HomeControllerBase.searchCep', context: context);

  @override
  Future<void> searchCep(String cep) {
    return _$searchCepAsyncAction.run(() => super.searchCep(cep));
  }

  late final _$searchAddressAsyncAction =
      AsyncAction('HomeControllerBase.searchAddress', context: context);

  @override
  Future<void> searchAddress(String uf, String city, String street) {
    return _$searchAddressAsyncAction
        .run(() => super.searchAddress(uf, city, street));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
error: ${error},
results: ${results},
lastResult: ${lastResult}
    ''';
  }
}
