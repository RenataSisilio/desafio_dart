import 'package:desafio/pessoa.dart';

class PessoaJuridica extends Pessoa {
  String nomeFantasia;
  String razaoSocial;

  PessoaJuridica(
    super.documento, {
    required super.endereco,
    required this.nomeFantasia,
    required this.razaoSocial,
  });

// ------- validação oficial de CNPJ (segundo Ministério da Fazenda) -------
  String get cnpj {
    final str = super.documento.toString();
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

  @override
  void printMe() {
    print(
        'CNPJ: $cnpj\nRazão social: $razaoSocial\nNome fantasia: $nomeFantasia');
    endereco.printMe();
  }

  @override
  Map toJson() => <String, dynamic>{
        'nomeFantasia': nomeFantasia,
        'razaoSocial': razaoSocial,
        'cpf': documento,
        'endereco': endereco.toJson()
      };
}
