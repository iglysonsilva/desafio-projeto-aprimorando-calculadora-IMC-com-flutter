import 'package:app_calculadora_imc_view/custom_components/modal_custom.dart';
import 'package:app_calculadora_imc_view/custom_components/text_label_custom.dart';
import 'package:app_calculadora_imc_view/models/resulado_imc_model.dart';
import 'package:app_calculadora_imc_view/services/resultado_imc_service.dart';
import 'package:app_calculadora_imc_view/utils/double_utils.dart';
import 'package:app_calculadora_imc_view/utils/string_utils.dart';
import 'package:app_calculadora_imc_view/utils/validator_utils.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import '../services/calcula_imc_service.dart';

class CalculaImcPage extends StatefulWidget {
  @override
  _CalculaImcPageState createState() => _CalculaImcPageState();
}

class _CalculaImcPageState extends State<CalculaImcPage> {
  final nomeController = TextEditingController(text: '');
  final alturaController = MoneyMaskedTextController();
  final pesoController = MoneyMaskedTextController();
  final resultadoImcService = ResultadoImcServide();
  final calculadoraImcService = CalculadoraImcService();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    carregarResultados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de IMC')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextLabelCustom('Informe o nome'),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: nomeController,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Informe esse campo.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                // Linha para a altura e o peso
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextLabelCustom('Informe a altura'),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          controller: alturaController,
                          validator: (value) {
                            if (!ValidatorUtils.isCampoValido(value)) {
                              return 'Informe esse campo.';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextLabelCustom('Informe o peso'),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          controller: pesoController,
                          validator: (value) {
                            if (!ValidatorUtils.isCampoValido(value)) {
                              return 'Informe esse campo.';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () {
                      adicionarImc();
                    },
                    child: const Text("Adicionar"),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TextLabelCustom('Resultados'),
                ],
              ),
              Expanded(
                  child: resultadoImcService.resultados.isEmpty
                      ? const Padding(
                        padding: EdgeInsets.only(left: 12.0, right: 12),
                        child: Text('Nenhum resultado para exibir, informe os dados e toque em Adicionar.'),
                      )
                      : ListView.builder(
                          itemCount: resultadoImcService.resultados.length,
                          itemBuilder: (BuildContext context, int index) {
                            ResultadoImcModel resultado = resultadoImcService.resultados[index];
                            return ListTile(
                              dense: false,
                              isThreeLine: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 0),
                              title: Text(resultado.nome, style: TextStyle(color: calculadoraImcService.getCorResultado(resultado.imc)),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Resultado: ${resultado.resultado}',
                                    style: const TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                  Text('IMC: ${resultado.imc.toStringAsFixed(2)}, Altura: ${resultado.altura.toStringAsFixed(2)}, Peso: ${resultado.peso.toStringAsFixed(2)}',
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                              trailing: InkWell(
                                child: const Icon(Icons.delete_forever_outlined, color: Colors.red,),
                                onTap: () {
                                  _showCustomModal(context, resultado);
                                },
                              ),
                            );
                          },
                        )),
            ],
          ),
        ),
      ),
    );
  }

  void adicionarImc() {
    if (_formKey.currentState != null) {
      bool isValid = _formKey.currentState!.validate();

      if (!isValid) {
        return;
      }
      var nome = StringUtils.capitalizeAllWord(nomeController.text);
      var altura = DoubleUtils().transformaStringEmNum(alturaController.text);
      var peso = DoubleUtils().transformaStringEmNum(pesoController.text);

      var resultado = ResultadoImcModel(0, nome, altura, peso, 0, '');

      resultadoImcService.add(resultado);

      limparCamposNaTela();

      setState(() {});
    }
  }

  void limparCamposNaTela() {
    nomeController.clear();
    alturaController.clear();
    pesoController.clear();
  }

  void _showCustomModal(BuildContext context, ResultadoImcModel resulado) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return ModalCustom(resulado.nome);
      },
    ).then((value) {
      if (value == 'Sim') {
        resultadoImcService.remover(resulado);
        setState(() {});
      }
    });
  }

  void carregarResultados() async {
    await resultadoImcService.carregaResultados();
    setState(() {});
  }
}
