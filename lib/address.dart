// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      final verif = [
        'AC',
        'AL',
        'AP',
        'AM',
        'BA',
        'CE',
        'DF',
        'ES',
        'GO',
        'MA',
        'MT',
        'MS',
        'MG',
        'PA',
        'PB',
        'PR',
        'PE',
        'PI',
        'RJ',
        'RN',
        'RS',
        'RO',
        'RR',
        'SC',
        'SP',
        'SE',
        'TO'
      ];
      estado = verif.contains(estado.toUpperCase()) ? estado.toUpperCase() : '';
    } else if (estado.length > 2) {
      switch (estado) {
        case 'Acre':
          estado = 'AC';
          break;
        case 'Alagoas':
          estado = 'AL';
          break;
        case 'Amapá':
          estado = 'AP';
          break;
        case 'Amazonas':
          estado = 'AM';
          break;
        case 'Bahia':
          estado = 'BA';
          break;
        case 'Ceará':
          estado = 'CE';
          break;
        case 'Distrito Federal':
          estado = 'DF';
          break;
        case 'Espírito Santo':
          estado = 'ES';
          break;
        case 'Goiás':
          estado = 'GO';
          break;
        case 'Maranhão':
          estado = 'MA';
          break;
        case 'Mato Grosso':
          estado = 'MT';
          break;
        case 'Mato Grosso do Sul':
          estado = 'MS';
          break;
        case 'Minas Gerais':
          estado = 'MG';
          break;
        case 'Pará':
          estado = 'PA';
          break;
        case 'Paraíba':
          estado = 'PB';
          break;
        case 'Paraná':
          estado = 'PR';
          break;
        case 'Pernambuco':
          estado = 'PE';
          break;
        case 'Piauí':
          estado = 'PI';
          break;
        case 'Rio de Janeiro':
          estado = 'RJ';
          break;
        case 'Rio Grande do Norte':
          estado = 'RN';
          break;
        case 'Rio Grande do Sul':
          estado = 'RS';
          break;
        case 'Rondônia':
          estado = 'RO';
          break;
        case 'Roraima':
          estado = 'RR';
          break;
        case 'Santa Catarina':
          estado = 'SC';
          break;
        case 'São Paulo':
          estado = 'SP';
          break;
        case 'Sergipe':
          estado = 'SE';
          break;
        case 'Tocantins':
          estado = 'TO';
          break;
        default:
          estado = '';
          break;
      }
    } else {
      estado = '';
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
}
