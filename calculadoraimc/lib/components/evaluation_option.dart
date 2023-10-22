import 'package:calculadoraimc/service/imc_service.dart';
import 'package:flutter/material.dart';

class EvaluationOption extends StatelessWidget {
  final EvaluationAttributes? attributes; 
  final double max; 
  final double min;

  const EvaluationOption({super.key, this.attributes,required this.max, required this.min});

  String getText(){
    if(min!=0&&max!=0){
      return  "$min - $max";
    }
    else if(min !=0){
      return "> $min";
    }
    else {
      return "< $max";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children:<Widget>[
        Expanded(
          flex: 1,
          child: Container(
            color:attributes?.color,
            child: const Text(""),
          )
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.only(left:15),
            child: Text(attributes!.label),
          )
        ),
        Expanded(
          flex: 3,
          child: Text(getText())
        ),
      ]
    );
  }
}