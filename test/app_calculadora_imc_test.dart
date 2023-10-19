import 'dart:ffi';

import 'package:app_calculadora_imc_view/models/pessoa_model.dart';
import 'package:app_calculadora_imc_view/services/calcula_imc_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Teste o a mensagem do resultado do cálculo do imc', () {
    expect(CalculadoraImcService().getMsgResultado(15), equalsIgnoringCase('Magreza grave'));
    expect(CalculadoraImcService().getMsgResultado(16.5), equals('Magreza moderada'));
    expect(CalculadoraImcService().getMsgResultado(18), equals('Magreza leve'));
    expect(CalculadoraImcService().getMsgResultado(22), equals('Saudável'));
    expect(CalculadoraImcService().getMsgResultado(28), equals('Sobrepeso'));
    expect(CalculadoraImcService().getMsgResultado(33), equals('Obesidade Grau I'));
    expect(CalculadoraImcService().getMsgResultado(37.5), equals('Obesidade Grau II(severa)'));
    expect(CalculadoraImcService().getMsgResultado(42), equals('Obesidade Grau II(mórbida)'));
  });

  test('Calcula IMC corretamente', () {
    var resultado = CalculadoraImcService().calculaIMC(PessoaModel('Mauro', 1.70, 40.0));
    expect(resultado, equals(13.84));

    resultado = CalculadoraImcService().calculaIMC(PessoaModel('Mauro', 1.70, 45.0));
    expect(resultado, equals(15.57));

    resultado = CalculadoraImcService().calculaIMC(PessoaModel('Mauro', 1.70, 50.0));
    expect(resultado, equals(17.30));

    resultado = CalculadoraImcService().calculaIMC(PessoaModel('Mauro', 1.70, 70.0));
    expect(resultado, equals(24.22));

    resultado = CalculadoraImcService().calculaIMC(PessoaModel('Mauro', 1.70, 80.0));
    expect(resultado, equals(27.68));

    resultado = CalculadoraImcService().calculaIMC(PessoaModel('Mauro', 1.70, 95.0));
    expect(resultado, equals(32.87));

    resultado = CalculadoraImcService().calculaIMC(PessoaModel('Mauro', 1.70, 110.0));
    expect(resultado, equals(38.06));

    resultado = CalculadoraImcService().calculaIMC(PessoaModel('Mauro', 1.70, 130));
    expect(resultado, equals(44.98));
  });
}
