import 'package:desafio/address.dart';
import 'package:desafio/pessoa_fisica.dart';
import 'package:desafio/registro.dart';
import 'package:uuid/uuid.dart';

void main() {
  // CPF, CNPJ, Telefone e CEP entrada apenas com números
  Registro.cadastrar();
  Registro.printAll();
}
