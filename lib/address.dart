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
      estado = estado.toLowerCase();
      switch (estado) {
        case 'acre':
          estado = 'AC';
          break;
        case 'alagoas':
          estado = 'AL';
          break;
        case 'amapá':
          estado = 'AP';
          break;
        case 'amazonas':
          estado = 'AM';
          break;
        case 'bahia':
          estado = 'BA';
          break;
        case 'ceará':
          estado = 'CE';
          break;
        case 'distrito federal':
          estado = 'DF';
          break;
        case 'espírito santo':
          estado = 'ES';
          break;
        case 'goiás':
          estado = 'GO';
          break;
        case 'maranhão':
          estado = 'MA';
          break;
        case 'mato grosso':
          estado = 'MT';
          break;
        case 'mato grosso do sul':
          estado = 'MS';
          break;
        case 'minas gerais':
          estado = 'MG';
          break;
        case 'pará':
          estado = 'PA';
          break;
        case 'paraíba':
          estado = 'PB';
          break;
        case 'paraná':
          estado = 'PR';
          break;
        case 'pernambuco':
          estado = 'PE';
          break;
        case 'piauí':
          estado = 'PI';
          break;
        case 'rio de janeiro':
          estado = 'RJ';
          break;
        case 'rio grande do norte':
          estado = 'RN';
          break;
        case 'rio grande do sul':
          estado = 'RS';
          break;
        case 'rondônia':
          estado = 'RO';
          break;
        case 'roraima':
          estado = 'RR';
          break;
        case 'santa catarina':
          estado = 'SC';
          break;
        case 'são paulo':
          estado = 'SP';
          break;
        case 'sergipe':
          estado = 'SE';
          break;
        case 'tocantins':
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
