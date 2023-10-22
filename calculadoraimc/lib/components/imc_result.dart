import 'package:calculadoraimc/components/evaluation_option.dart';
import 'package:calculadoraimc/providers/imc_provider.dart';
import 'package:calculadoraimc/service/imc_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImcResult extends StatelessWidget {
  ImcResult({super.key});

  final Map<double, EvaluationAttributes> _options =ImcService.getEvaluationsOptions();

  bool isSelected(double value, int index){
    double valueToCalc = double.parse(value.toStringAsFixed(2));

    if(index==0){
      return valueToCalc <= _options.keys.elementAt(index+1);
    }
    else if(index < _options.length-1){
      return valueToCalc >= _options.keys.elementAt(index) && valueToCalc <= _options.keys.elementAt(index+1);
    }
    else{
      return valueToCalc >= _options.keys.last;      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ImcProvider>(builder: ((context, value, child) => 
      value.imc!=0?Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Seu IMC: ${value.imc.toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ), 
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(children: [
                for(int i=0; i<_options.length; i++) 
                  Container(
                    color: isSelected(value.imc, i)?const Color.fromARGB(255, 206, 204, 204):Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: EvaluationOption(
                      attributes: _options.values.elementAt(i), 
                      min: i==0?0:_options.keys.elementAt(i),
                      max: i==_options.length-1?0:_options.keys.elementAt(i+1),
                    )
                  )
              ],)
            )
          ],        
        ),
      ): Column(children: const [],)
    ));
  }
}