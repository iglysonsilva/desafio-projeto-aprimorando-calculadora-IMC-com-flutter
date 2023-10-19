import 'package:app_calculadora_imc_view/models/resulado_imc_model.dart';

import '../sqlite/sqlite_dabase.dart';

class ImcPessoaRepository {

  Future<List<ResultadoImcModel>> getListDados() async {
    List<ResultadoImcModel> tarefas = [];
    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery('SELECT * FROM imc_pessoa');
    for (var element in result) {
      tarefas.add(ResultadoImcModel(
        int.parse(element['id'].toString()),
         element['nome'].toString() ,
        double.parse(element['peso'].toString()),
        double.parse(element['altura'].toString()),
        double.parse(element['imc'].toString()),
        element['resultado'].toString(),
      ));
    }
    return tarefas;
  }

  Future<void> salvar(ResultadoImcModel resultadoImcModel) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawInsert('INSERT INTO imc_pessoa(nome, peso, altura, imc, resultado) values (?,?,?,?,?)',
        [ resultadoImcModel.nome,
          resultadoImcModel.peso,
          resultadoImcModel.altura,
          resultadoImcModel.imc,
          resultadoImcModel.resultado]);
  }

  Future<void> remover(int id) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawDelete('DELETE FROM imc_pessoa where id = ?;', [id]);
  }
}
