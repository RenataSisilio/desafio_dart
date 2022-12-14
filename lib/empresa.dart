import 'package:desafio/address.dart';
import 'package:desafio/pessoa.dart';
import 'package:desafio/pessoa_fisica.dart';
import 'package:desafio/pessoa_juridica.dart';
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

  factory Empresa.fromJson(Map<String, dynamic> json) {
    final Pessoa soc;
    if (json['socio']['cpf'] != null) {
      soc = PessoaFisica(
        json['socio']['nome'],
        json['socio']['cpf'],
        endereco: Address(
          json['socio']['endereco']['cep'],
          bairro: json['socio']['endereco']['bairro'],
          cidade: json['socio']['endereco']['cidade'],
          estado: json['socio']['endereco']['estado'],
          logradouro: json['socio']['endereco']['logradouro'],
          numero: json['socio']['endereco']['numero'],
        ),
      );
    } else {
      soc = PessoaJuridica(
        json['socio']['cnpj'],
        endereco: Address(
          json['socio']['endereco']['cep'],
          bairro: json['socio']['endereco']['bairro'],
          cidade: json['socio']['endereco']['cidade'],
          estado: json['socio']['endereco']['estado'],
          logradouro: json['socio']['endereco']['logradouro'],
          numero: json['socio']['endereco']['numero'],
        ),
        razaoSocial: json['socio']['razaoSocial'],
        nomeFantasia: json['socio']['nomeFantasia'],
      );
    }
    return Empresa(
      json['cnpj'],
      json['telefone'],
      endereco: Address(
        json['endereco']['cep'],
        bairro: json['endereco']['bairro'],
        cidade: json['endereco']['cidade'],
        estado: json['endereco']['estado'],
        logradouro: json['endereco']['logradouro'],
        numero: json['endereco']['numero'],
      ),
      nomeFantasia: json['nomeFantasia'],
      razaoSocial: json['razaoSocial'],
      socio: soc,
    );
  }

  String get id => _id;

  // ------- valida????o oficial de CNPJ (segundo Minist??rio da Fazenda) -------
  String get cnpj {
    final str = _cnpj.toString();
    var mult = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    int val = 0;
    if (str.length == 14) {
      // valida????o do primeiro d??gito verificador
      for (var i = 0; i < 12; i++) {
        val += int.parse(str[i]) * mult[i];
      }
      val %= 11;
      val = val < 2 ? 0 : 11 - val;
      if (val == int.parse(str[12])) {
        // valida????o do segundo d??gito verificador
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
        '\nID: $id\nCNPJ: $cnpj Data Cadastro: $cadastroHora\nRaz??o Social: $razaoSocial\nNome Fantasia: $nomeFantasia\nTelefone: $telefone');
    endereco.printMe();
    print('S??cio:');
    socio.printMe();
  }

  Map toJson() => <String, dynamic>{
        'cnpj': _cnpj,
        'telefone': _telefone,
        'cadastroHora': cadastroHora.toString(),
        'endereco': endereco.toJson(),
        'id': id,
        'nomeFantasia': nomeFantasia,
        'razaoSocial': razaoSocial,
        'socio': socio.toJson()
      };
}
