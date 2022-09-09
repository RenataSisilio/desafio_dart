import 'package:desafio/pessoa.dart';

class PessoaFisica extends Pessoa {
  String nome;

  PessoaFisica(
    this.nome,
    super.documento, {
    required super.endereco,
  });

// ------- validação oficial de CPF (segundo Ministério da Fazenda) -------
  String get cpf {
    final str = super.documento.toString();
    String invalid = '';
    for (var i = 0; i < 11; i++) {
      invalid += str[0];
    }
    int val = 0;
    // validação do número de dígitos e da exceção de números repetidos
    if (str.length == 11 && str != invalid) {
      // validação do primeiro dígito verificador
      for (var i = 10; i > 1; i--) {
        val += int.parse(str[10 - i]) * i;
      }
      val = (val * 10) % 11;
      val = val == 10 ? 0 : val;
      if (val == int.parse(str[9])) {
        // validação do segundo dígito verificador
        val = 0;
        for (var i = 11; i > 1; i--) {
          val += int.parse(str[11 - i]) * i;
        }
        val = (val * 10) % 11;
        val = val == 10 ? 0 : val;
        if (val == int.parse(str[10])) {
          return '${str.substring(0, 3)}.${str.substring(3, 6)}.${str.substring(6, 9)}-${str.substring(9)}';
        }
      }
    }
    return '';
  }

  @override
  void printMe() {
    print('CPF: $cpf\nNome completo: $nome');
    endereco.printMe();
  }

  @override
  Map toJson() => <String, dynamic>{
        'nome': nome,
        'cpf': documento,
        'endereco': endereco.toJson()
      };
}
