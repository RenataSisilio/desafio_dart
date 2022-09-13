// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:desafio/const.dart';

class Address {
  final int _cep;
  String bairro;
  String cidade;
  String complemento;
  String estado;
  String logradouro;
  int numero;

  Address(
    this._cep, {
    required this.bairro,
    required this.cidade,
    this.complemento = '',
    required this.estado,
    required this.logradouro,
    required this.numero,
  }) {
    if (estado.length == 2) {
      estado = estadoSigla.contains(estado.toUpperCase())
          ? estado.toUpperCase()
          : '';
    } else if (estado.length > 2) {
      estado = estados.contains(estado.toLowerCase())
          ? estadoSigla[estados.indexOf(estado.toLowerCase())]
          : '';
    }
  }

  String get cep {
    final cep = _cep.toString();
    if (cep.length == 8) {
      return '${cep.substring(0, 2)}.${cep.substring(2, 5)}-${cep.substring(5)}';
    } else {
      return '';
    }
  }

  void printMe() {
    print(
        'Endereço: $logradouro, $numero$complemento, $bairro, $cidade/$estado, $cep');
  }

  Map toJson() => <String, dynamic>{
        'cep': _cep,
        'bairro': bairro,
        'cidade': cidade,
        'complemento': complemento,
        'estado': estado,
        'logradouro': logradouro,
        'numero': numero
      };
}
