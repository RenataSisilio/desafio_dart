import 'dart:io';

import 'package:desafio/registro.dart';

// TODO: handle special characters inputs
void main() {
  Registro.initDB();
  menu();
}

void menu() {
  print('''\x1B[2J\x1B[0;0H
                      MENU INICIAL

  1. Cadastrar uma nova empresa
  2. Buscar Empresa cadastrada por CNPJ
  3. Buscar Empresa por CPF/CNPJ do Sócio
  4. Listar Empresas cadastradas em ordem alfabética (baseado na Razão Social)
  5. Excluir uma empresa (por ID)
  6. Sair''');
  var input = int.tryParse(stdin.readLineSync() ?? '0');
  print('\x1B[2J\x1B[0;0H');
  switch (input) {
    case 1:
      Registro.cadastrar();
      menu();
      break;
    case 2:
      stdout.write('\nCNPJ da empresa: ');
      input = int.tryParse(stdin.readLineSync()!) ?? 0;
      Registro.buscaCNPJ(input);
      stdin.readLineSync();
      menu();
      break;
    case 3:
      stdout.write('\nCPF/CNPJ do sócio: ');
      input = int.tryParse(stdin.readLineSync()!) ?? 0;
      Registro.buscaSocioDoc(input);
      stdin.readLineSync();
      menu();
      break;
    case 4:
      Registro.printAll();
      stdin.readLineSync();
      menu();
      break;
    case 5:
      stdout.write('\nID da empresa: ');
      var input = stdin.readLineSync() ?? '0';
      Registro.excluir(input);
      menu();
      break;
    case 6:
      Registro.saveDB();
      break;
    default:
      menu();
  }
}
