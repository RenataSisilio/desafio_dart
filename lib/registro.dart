import 'dart:io';

import 'package:desafio/address.dart';
import 'package:desafio/empresa.dart';
import 'package:desafio/pessoa.dart';
import 'package:desafio/pessoa_fisica.dart';
import 'package:desafio/pessoa_juridica.dart';

class Registro {
  static List<Empresa> db = [];

  static void cadastrar() {
    var id = DateTime.now().microsecondsSinceEpoch.toString();

    stdout.write('Razão Social: ');
    var razaoSocial = stdin.readLineSync() ?? '';
    stdout.write('Nome fantasia: ');
    var nomeFantasia = stdin.readLineSync() ?? '';
    stdout.write('CNPJ: ');
    var cnpj = int.tryParse(stdin.readLineSync()!) ?? 0;
    stdout.write('Telefone: ');
    var telefone = int.tryParse(stdin.readLineSync()!) ?? 0;
    stdout.write('\nEndereço:');
    var endereco = addressCreate();

    stdout.write(
        '\nSócio:\nPor favor, digite:\n\t1 para PESSOA FÍSICA\n\t\tou\n\t2 para PESSOA JURÍDICA');
    var input = int.tryParse(stdin.readLineSync()!) ?? 0;
    var socio;
    if (input == 1) {
      socio = criarPF();
    } else if (input == 2) {
      socio = criarPJ();
    } else {
      input = 0;
    }

    var error = false;
    var errorMsg = ' -------------------- ERRO --------------------';
    final empresa = Empresa(cnpj, telefone,
        endereco: endereco,
        nomeFantasia: nomeFantasia,
        razaoSocial: razaoSocial,
        socio: socio);
    if (empresa.cnpj == '') {
      error = true;
    }
    if (error == true) {
      print(errorMsg);
      cadastrar();
    } else {
      db.add(empresa);
    }
  }

  static Pessoa criarPF() {
    stdout.write('Nome: ');
    var nome = stdin.readLineSync() ?? '';
    stdout.write('CPF: ');
    var cpf = int.tryParse(stdin.readLineSync()!) ?? 0;
    stdout.write('\nEndereço do sócio:');
    var endereco = addressCreate();
    return PessoaFisica(nome, cpf, endereco: endereco);
  }

  static Pessoa criarPJ() {
    stdout.write('Razão social: ');
    var razaoSocial = stdin.readLineSync() ?? '';
    stdout.write('Nome fantasia: ');
    var nomeFantasia = stdin.readLineSync() ?? '';
    stdout.write('CNPJ: ');
    var cnpj = int.tryParse(stdin.readLineSync()!) ?? 0;
    stdout.write('\nEndereço do sócio:');
    var endereco = addressCreate();
    return PessoaJuridica(cnpj,
        endereco: endereco,
        nomeFantasia: nomeFantasia,
        razaoSocial: razaoSocial);
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
    return Address(cep,
        bairro: bairro,
        cidade: cidade,
        complemento: complemento,
        estado: estado,
        logradouro: logradouro,
        numero: numero);
  }

/*
  // TODO: implement
  static Empresa buscaCNPJ(int cnpj) {
    return Empresa;
  }

  // TODO: implement
  static Empresa buscaSocioDoc(int socioDoc) {
    return Empresa;
  }
*/
  static void printAll() {
    db.sort(((a, b) => a.razaoSocial.compareTo(b.razaoSocial)));
    for (var element in db) {
      element.printMe();
      print('');
    }
  }

  static void excluir(String id) {
    db.removeWhere((element) => element.id == id);
  }
}
