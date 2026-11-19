import 'package:hive/hive.dart';

part 'address_model.g.dart';

/// Estrutura de dados para o retorno da consulta da API externa (ViaCEP) e para o histórico local.
@HiveType(typeId: 0)
class AddressModel {
  AddressModel({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    this.consultedAt,
  });

  @HiveField(0)
  final String cep;
  @HiveField(1)
  final String logradouro;
  @HiveField(2)
  final String complemento;
  @HiveField(3)
  final String bairro;
  @HiveField(4)
  final String localidade;
  @HiveField(5)
  final String uf;
  @HiveField(6)
  final DateTime? consultedAt;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        cep: '${json['cep'] ?? ''}',
        logradouro: '${json['logradouro'] ?? ''}',
        complemento: '${json['complemento'] ?? ''}',
        bairro: '${json['bairro'] ?? ''}',
        localidade: '${json['localidade'] ?? ''}',
        uf: '${json['uf'] ?? ''}',
      );

  AddressModel copyWithConsultedAt(DateTime date) => AddressModel(
        cep: cep,
        logradouro: logradouro,
        complemento: complemento,
        bairro: bairro,
        localidade: localidade,
        uf: uf,
        consultedAt: date,
      );

  String get fullAddress =>
      [logradouro, bairro, '$localidade - $uf'].where((s) => s.trim().isNotEmpty).join(', ');
}
