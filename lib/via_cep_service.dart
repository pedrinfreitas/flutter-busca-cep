import 'package:http/http.dart' as http;
import 'package:app_cep_turma/result_cep.dart';

class ViaCepService {
  static Future<ResultCep> fetchCep({String? cep}) async {
    String url = 'https://viacep.com.br/ws/$cep/json/';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return ResultCep.fromJson(response.body);
    } else {
      throw Exception('Requisição inválida!');
    }
  }
}
