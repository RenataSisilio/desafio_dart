// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:desafio/address.dart';

abstract class Pessoa {
  int _documento;
  Address endereco;

  Pessoa(
    this._documento, {
    required this.endereco,
  });

  int get documento => _documento;

  void printMe();
}
