import 'package:calculadoraimc/models/history.dart';
import 'package:calculadoraimc/service/imc_service.dart';
import 'package:flutter/material.dart';

class HistoryRow extends StatelessWidget {
  final History history;

  const HistoryRow({super.key, required this.history});
  
  EvaluationAttributes getEvaluationAttribute (double imc){
    return ImcService.getAttibuteByImc(imc);
  } 
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color:getEvaluationAttribute(history.value).color,
                child: const Text(""),
              )
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(left:15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("IMC: ${history.value}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(getEvaluationAttribute(history.value).label),
                    Text("Data: ${history.getFormattedDate()}")
                  ]),
              )
            ),
          ],
        ) 
      ),
    );
  }
}