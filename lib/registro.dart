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
    /*
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
    final test = Empresa(cnpj, telefone,
        endereco: validAddress,
        nomeFantasia: nomeFantasia,
        razaoSocial: razaoSocial,
        socio: validPF);
    var error = false;
    var errorMsg = ' -------------------- ERRO --------------------\n';
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

      var socio;
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
      db.add(Empresa(cnpj, telefone,
          endereco: endereco,
          nomeFantasia: nomeFantasia,
          razaoSocial: razaoSocial,
          socio: socio));
    }
    */
    db.add(Empresa(11941838000104, 19988380630,
        endereco: validAddress,
        nomeFantasia: 'Pães e Doces',
        razaoSocial: 'Elisa e Flávia Pães e Doces ME',
        socio: validPF));
  }

  static Pessoa pfCreate() {
    stdout.write('Nome: ');
    var nome = stdin.readLineSync() ?? '';
    stdout.write('CPF: ');
    var cpf = int.tryParse(stdin.readLineSync()!) ?? 0;

    // validação dos dados do sócio
    final test = PessoaFisica(nome, cpf, endereco: validAddress);
    if (test.cpf == '') {
      print(
          ' -------------------- ERRO --------------------\n  -> Sócio: CPF inválido\nTente novamente...\n\nSócio:');
      return pfCreate();
    } else {
      // criação do endereço após validação dos dados do sócio
      stdout.write('\nEndereço do sócio:\n');
      var endereco = addressCreate();
      return PessoaFisica(nome, cpf, endereco: endereco);
    }
  }

  static Pessoa pjCreate() {
    stdout.write('Razão social: ');
    var razaoSocial = stdin.readLineSync() ?? '';
    stdout.write('Nome fantasia: ');
    var nomeFantasia = stdin.readLineSync() ?? '';
    stdout.write('CNPJ: ');
    var cnpj = int.tryParse(stdin.readLineSync()!) ?? 0;

    // validação dos dados do sócio
    var test = PessoaJuridica(cnpj,
        endereco: validAddress,
        nomeFantasia: nomeFantasia,
        razaoSocial: razaoSocial);
    if (test.cnpj == '') {
      print(
          ' -------------------- ERRO --------------------\n  -> Sócio: CNPJ inválido\nTente novamente...\n\nSócio:');
      return pjCreate();
    } else {
      // criação do endereço após validação dos dados do sócio
      stdout.write('\nEndereço do sócio:\n');
      var endereco = addressCreate();
      return PessoaJuridica(cnpj,
          endereco: endereco,
          nomeFantasia: nomeFantasia,
          razaoSocial: razaoSocial);
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
    final address = Address(cep,
        bairro: bairro,
        cidade: cidade,
        complemento: complemento,
        estado: estado,
        logradouro: logradouro,
        numero: numero);

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

/*
  // TODO: implement
  static Empresa buscaSocioDoc(int socioDoc) {
    return Empresa;
  }
*/
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
}
