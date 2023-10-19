import 'package:app_calculadora_imc_view/models/resulado_imc_model.dart';
import 'package:flutter/material.dart';

class CalculadoraImcService {
  String getMsgResultado(double imc) {
    if (imc < 16) {
      return 'Magreza grave';
    } else if (imc >= 16 && imc < 17) {
      return 'Magreza moderada';
    } else if (imc >= 17 && imc < 18.5) {
      return 'Magreza leve';
    } else if (imc >= 18.5 && imc < 25) {
      return 'Saudável';
    } else if (imc >= 25 && imc < 30) {
      return 'Sobrepeso';
    } else if (imc >= 30 && imc < 35) {
      return 'Obesidade Grau I';
    } else if (imc >= 35 && imc < 40) {
      return 'Obesidade Grau II(severa)';
    } else if (imc >= 40) {
      return 'Obesidade Grau II(mórbida)';
    }
    throw Exception('Nenhuma opção de resultado encontrado.');
  }

  ColorSwatch<int> getCorResultado(double imc) {
    if (imc < 16) {
      return Colors.red;
    } else if (imc >= 16 && imc < 17) {
      return  Colors.deepOrange;
    } else if (imc >= 17 && imc < 18.5) {
      return  Colors.orange;
    } else if (imc >= 18.5 && imc < 25) {
      return  Colors.green;
    } else if (imc >= 25 && imc < 30) {
      return  Colors.orange;
    } else if (imc >= 30 && imc < 35) {
      return  Colors.orangeAccent;
    } else if (imc >= 35 && imc < 40) {
      return  Colors.deepOrange;
    } else if (imc >= 40) {
      return  Colors.red;
    }
    throw Exception('Nenhuma opção de resultado encontrado.');
  }

  double calculaIMC(ResultadoImcModel resultadoImcModel) {
    return double.parse((resultadoImcModel.peso /
        (resultadoImcModel.altura * resultadoImcModel.altura)).toStringAsFixed(2));
  }
}
