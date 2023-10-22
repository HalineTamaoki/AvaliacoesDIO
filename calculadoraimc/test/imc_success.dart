import 'package:calculadoraimc/models/imc.dart';
import 'package:calculadoraimc/service/imc_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculadoraimc/main.dart';

void main() {
  group("IMC Service", (){
    test ('Should calculate IMC', (){
      Imc imcValue = Imc(1.50, 50);
      double imc = ImcService.calculateImc(imcValue);
      expect(imc.toStringAsFixed(2), "22.22");
    });
    test("Should bring correct attribute", (){
      double imc = 22.22;
      EvaluationAttributes correctEvaluationAttribute = EvaluationAttributes("Sobrepeso", Colors.yellow);

      EvaluationAttributes expectedEvaluationAttributes = ImcService.getAttibuteByImc(imc);
      debugPrint(expectedEvaluationAttributes.label);
      expect(expectedEvaluationAttributes.label, correctEvaluationAttribute.label);
    });
  });
  
}
