import 'dart:convert';
import 'dart:io';

import 'package:desafio/address.dart';
import 'package:desafio/empresa.dart';
import 'package:desafio/pessoa.dart';
import 'package:desafio/pessoa_fisica.dart';
import 'package:desafio/pessoa_juridica.dart';

class Registro {
  static List<Empresa> db = [];

  static get validAddress => Address(00000000,
      bairro: 'b', cidade: 'c', estado: 'mg', logradouro: 'l', numero: 1);
  static get validPF =>
      PessoaFisica('nome', 76367980008, endereco: validAddress);

  static void cadastrar() {
    // inputs dos dados da empresa
    stdout.write('Razão Social: ');
    var razaoSocial = stdin.readLineSync() ?? '';
    stdout.write('Nome fantasia: ');
    var nomeFantasia = stdin.readLineSync() ?? '';
    stdout.write('CNPJ: ');
    var cnpj = int.tryParse(stdin.readLineSync()!) ?? 0;
    stdout.write('Telefone: ');
    var telefone = int.tryParse(stdin.readLineSync()!) ?? 0;

    // validação dos dados da empresa
    final test = Empresa(
      cnpj,
      telefone,
      endereco: validAddress,
      nomeFantasia: nomeFantasia,
      razaoSocial: razaoSocial,
      socio: validPF,
    );
    var error = false;
    var errorMsg = ' -------------------- ERRO --------------------\n';
    if (test.razaoSocial == '') {
      error = true;
      errorMsg += '  -> Razão social em branco\n';
    }
    if (test.nomeFantasia == '') {
      error = true;
      errorMsg += '  -> Nome fantasia em branco\n';
    }
    if (test.cnpj == '') {
      error = true;
      errorMsg += '  -> CNPJ inválido\n';
    }
    if (test.telefone == '') {
      error = true;
      errorMsg += '  -> Telefone inválido\n';
    }
    if (error == true) {
      print(errorMsg);
      print('Tecle ENTER para tentar novamente...');
      stdin.readByteSync();
      print('\x1B[2J\x1B[0;0H');
      cadastrar();
    } else {
      // continuação após validação dos dados da empresa
      stdout.write('\nEndereço:\n');
      var endereco = addressCreate();

      late Pessoa socio;
      do {
        error = false;
        stdout.write(
            '\nSócio:\nPor favor, digite:\n\t1 para PESSOA FÍSICA\n\t\tou\n\t2 para PESSOA JURÍDICA\n');
        var input = int.tryParse(stdin.readLineSync()!) ?? 0;
        if (input == 1) {
          socio = pfCreate();
        } else if (input == 2) {
          socio = pjCreate();
        } else {
          error = true;
        }
      } while (error);

      // cadastro da empresa após validação de todos os dados
      db.add(Empresa(
        cnpj,
        telefone,
        endereco: endereco,
        nomeFantasia: nomeFantasia,
        razaoSocial: razaoSocial,
        socio: socio,
      ));
    }
  }

  static PessoaFisica pfCreate() {
    stdout.write('Nome: ');
    var nome = stdin.readLineSync() ?? '';
    stdout.write('CPF: ');
    var cpf = int.tryParse(stdin.readLineSync()!) ?? 0;

    // validação dos dados do sócio
    final test = PessoaFisica(
      nome,
      cpf,
      endereco: validAddress,
    );
    var error = false;
    var errorMsg = ' -------------------- ERRO --------------------\n';
    if (test.nome == '') {
      error = true;
      errorMsg += '  -> Nome em branco\n';
    }
    if (test.cpf == '') {
      error = true;
      errorMsg += '  -> CPF inválido\n';
    }
    if (error) {
      print(errorMsg);
      return pfCreate();
    } else {
      // criação do endereço após validação dos dados do sócio
      stdout.write('\nEndereço do sócio:\n');
      var endereco = addressCreate();
      return PessoaFisica(
        nome,
        cpf,
        endereco: endereco,
      );
    }
  }

  static PessoaJuridica pjCreate() {
    stdout.write('Razão social: ');
    var razaoSocial = stdin.readLineSync() ?? '';
    stdout.write('Nome fantasia: ');
    var nomeFantasia = stdin.readLineSync() ?? '';
    stdout.write('CNPJ: ');
    var cnpj = int.tryParse(stdin.readLineSync()!) ?? 0;

    // validação dos dados do sócio
    var test = PessoaJuridica(
      cnpj,
      endereco: validAddress,
      nomeFantasia: nomeFantasia,
      razaoSocial: razaoSocial,
    );
    var error = false;
    var errorMsg = ' -------------------- ERRO --------------------\n';
    if (test.razaoSocial == '') {
      error = true;
      errorMsg += '  -> Razão social em branco\n';
    }
    if (test.nomeFantasia == '') {
      error = true;
      errorMsg += '  -> Nome fantasia em branco\n';
    }
    if (test.cnpj == '') {
      error = true;
      errorMsg += '  -> CNPJ inválido\n';
    }
    if (error) {
      print(errorMsg);
      return pjCreate();
    } else {
      // criação do endereço após validação dos dados do sócio
      stdout.write('\nEndereço do sócio:\n');
      var endereco = addressCreate();
      return PessoaJuridica(
        cnpj,
        endereco: endereco,
        nomeFantasia: nomeFantasia,
        razaoSocial: razaoSocial,
      );
    }
  }

  static Address addressCreate() {
    stdout.write('Logradouro: ');
    var logradouro = stdin.readLineSync() ?? '';
    stdout.write('Número: ');
    var numero = int.tryParse(stdin.readLineSync()!) ?? 0;
    stdout.write('Complemento: ');
    var complemento = stdin.readLineSync() ?? '';
    stdout.write('Bairro: ');
    var bairro = stdin.readLineSync() ?? '';
    stdout.write('Cidade: ');
    var cidade = stdin.readLineSync() ?? '';
    stdout.write('Estado: ');
    var estado = stdin.readLineSync() ?? '';
    stdout.write('CEP: ');
    var cep = int.tryParse(stdin.readLineSync()!) ?? 0;
    final address = Address(
      cep,
      bairro: bairro,
      cidade: cidade,
      complemento: complemento,
      estado: estado,
      logradouro: logradouro,
      numero: numero,
    );

    // validação do endereço
    var error = false;
    var errorMsg = ' -------------------- ERRO --------------------\n';
    if (address.numero == 0) {
      error = true;
      errorMsg += '  -> Número inválido\n';
    }
    if (address.estado == '') {
      error = true;
      errorMsg += '  -> Estado inválido\n';
    }
    if (address.cep == '') {
      error = true;
      errorMsg += '  -> CEP inválido\n';
    }
    if (error == true) {
      print(errorMsg);
      print('Tente novamente...');
      return addressCreate();
    } else {
      return address;
    }
  }

  static void buscaCNPJ(int cnpj) {
    try {
      final empresa = db.firstWhere(
          (e) => e.cnpj.replaceAll(RegExp(r'[\.\-/]'), '') == cnpj.toString());
      empresa.printMe();
    } catch (e) {
      print('\nNão foi possível encontrar este CNPJ em nossos registros.');
    }
  }

  static void buscaSocioDoc(int socioDoc) {
    try {
      final empresa = db.firstWhere((e) => e.socio.documento == socioDoc);
      empresa.printMe();
    } catch (e) {
      print('\nNão foi possível encontrar este CNPJ em nossos registros.');
    }
  }

  static void printAll() {
    print('\x1B[2J\x1B[0;0H');
    db.sort(((a, b) => a.razaoSocial.compareTo(b.razaoSocial)));
    for (var element in db) {
      element.printMe();
    }
  }

  static void excluir(String id) {
    db.removeWhere((element) => element.id == id);
  }

  static void saveDB() {
    var tojson = [];
    for (var empresa in db) {
      tojson.add(empresa.toJson());
    }
    var encoded = jsonEncode(tojson);
    File('lib/database.json').writeAsString(encoded);
  }

  static void initDB() {
    final json = jsonDecode(File('lib/database.json').readAsStringSync());
    for (var e in json) {
      db.add(Empresa.fromJson(e));
    }
  }
}
