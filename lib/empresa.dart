import 'package:desafio/address.dart';
import 'package:desafio/pessoa.dart';
import 'package:uuid/uuid.dart';

class Empresa {
  final int _cnpj;
  final String _id = Uuid().v1();
  final int _telefone;
  DateTime cadastroHora = DateTime.now();
  Address endereco;
  String nomeFantasia;
  String razaoSocial;
  Pessoa socio;

  Empresa(
    this._cnpj,
    this._telefone, {
    required this.endereco,
    required this.nomeFantasia,
    required this.razaoSocial,
    required this.socio,
  });

  String get id => _id;

  // ------- validação oficial de CNPJ (segundo Ministério da Fazenda) -------
  String get cnpj {
    final str = _cnpj.toString();
    var mult = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    int val = 0;
    if (str.length == 14) {
      // validação do primeiro dígito verificador
      for (var i = 0; i < 12; i++) {
        val += int.parse(str[i]) * mult[i];
      }
      val %= 11;
      val = val < 2 ? 0 : 11 - val;
      if (val == int.parse(str[12])) {
        // validação do segundo dígito verificador
        val = 0;
        mult.insert(0, 6);
        for (var i = 0; i < 13; i++) {
          val += int.parse(str[i]) * mult[i];
        }
        val %= 11;
        val = val < 2 ? 0 : 11 - val;
        if (val == int.parse(str[13])) {
          return '${str.substring(0, 2)}.${str.substring(2, 5)}.${str.substring(5, 8)}/${str.substring(8, 12)}-${str.substring(12)}';
        }
      }
    }
    return '';
  }

  String get telefone {
    final str = _telefone.toString();
    if (str.length == 11) {
      return '(${str.substring(0, 2)}) ${str[2]} ${str.substring(3, 7)}-${str.substring(7)}';
    } else if (str.length == 10) {
      return '(${str.substring(0, 2)}) ${str.substring(2, 6)}-${str.substring(6)}';
    } else {
      return '';
    }
  }

  void printMe() {
    print(
        '\nID: $id\nCNPJ: $cnpj Data Cadastro: $cadastroHora\nRazão Social: $razaoSocial\nNome Fantasia: $nomeFantasia\nTelefone: $telefone');
    endereco.printMe();
    print('Sócio:');
    socio.printMe();
  }

  Map toJson() => <String, dynamic>{
        'cnpj': _cnpj,
        'telefone': telefone,
        'cadastroHora': cadastroHora.toString(),
        'endereco': endereco.toJson(),
        'id': id,
        'nomeFantasia': nomeFantasia,
        'razaoSocial': razaoSocial,
        'socio': socio.toJson()
      };
}
