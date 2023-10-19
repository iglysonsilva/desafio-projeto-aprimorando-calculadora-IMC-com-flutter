 import 'package:app_calculadora_imc_view/models/resulado_imc_model.dart';
import 'package:app_calculadora_imc_view/repository/imc_pessoa_repository.dart';
import 'package:app_calculadora_imc_view/services/calcula_imc_service.dart';

class ResultadoImcServide {
  var calculadoraImcService = CalculadoraImcService();
  var resultadoImcRepository = ImcPessoaRepository();

  List<ResultadoImcModel> _resultados = [];

  List<ResultadoImcModel> get resultados => _resultados;

  Future<List<ResultadoImcModel>> carregaResultados() async {
    _resultados = await resultadoImcRepository.getListDados();

    return _resultados;
  }

  void add(ResultadoImcModel resultado) {
    var resultadoImc = calculadoraImcService.calculaIMC(resultado);
    var msgResultadoImc = calculadoraImcService.getMsgResultado(resultadoImc);
    var resultadoImcModelGravar = ResultadoImcModel(
      0,
      resultado.nome,
      resultado.altura,
      resultado.peso,
      resultadoImc,
      msgResultadoImc,
    );

    resultadoImcRepository.salvar(resultadoImcModelGravar);

    _resultados.add(resultadoImcModelGravar);
  }

  void remover(ResultadoImcModel resultadoImc) {
    resultadoImcRepository.remover(resultadoImc.id);
    _resultados.remove(resultadoImc);
  }
}
