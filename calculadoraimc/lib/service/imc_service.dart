import 'dart:math';

import 'package:calculadoraimc/models/imc.dart';
import 'package:flutter/material.dart';

class ImcService{
  static double calculateImc (Imc imc) {
    return imc.getWeight()!/pow(num.parse(imc.getHeight().toString()), 2);
  }

  static Map<double, EvaluationAttributes> getEvaluationsOptions(){
    return ({
      0: EvaluationAttributes("Abaixo do peso", Colors.blue),
      18.5: EvaluationAttributes("Peso saudável",Colors.green),
      25: EvaluationAttributes("Sobrepeso", Colors.yellow),
      30: EvaluationAttributes("Obeso",Colors.orange),
      40: EvaluationAttributes("Muito obeso", Colors.red)
    });
  }

  static EvaluationAttributes getAttibuteByImc(double imc){
    Map<double, EvaluationAttributes> evaluationOptions = getEvaluationsOptions();
    List<double> keyList = evaluationOptions.keys.where((key) => key>imc).toList();

    EvaluationAttributes? response; 
    keyList.isEmpty?response = evaluationOptions.values.last: response = evaluationOptions[keyList.first];

    return response??EvaluationAttributes("", Colors.white);
  }
}

class EvaluationAttributes{
  String label = "";
  Color color = Colors.white;

  EvaluationAttributes(this.label, this.color);
}

