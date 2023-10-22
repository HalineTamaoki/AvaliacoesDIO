import 'package:calculadoraimc/models/imc.dart';
import 'package:calculadoraimc/providers/imc_provider.dart';
import 'package:calculadoraimc/repository/imc_history_repository.dart';
import 'package:calculadoraimc/service/imc_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ImcForm extends StatefulWidget {
  const ImcForm({super.key});

  @override
  ImcFormState createState() {
    return ImcFormState();
  }
}

class ImcFormState extends State<ImcForm> {
  ImcHistoryRepository imcHistoryRepository = ImcHistoryRepository();

  final _formKey = GlobalKey<FormState>();
  double? _weight;
  double? _height;
  bool _heightError = false;
  bool _imcError = false;
  bool _isLoading = false;

  _validateHeight(String value){
    setState(() {
      _height = null;
      _heightError = false; 

      double? dbValue = double.tryParse(value);
      if(dbValue!=null&&dbValue<3){
        _height=dbValue;
      } else if (dbValue!=null) {
        _heightError = true;
      }
    });
  }

  calculateImc() async {
    _imcError = false;

    if(_height==null || _weight==null){
      _imcError = true;
    }
    else{
      _isLoading = true;

      var value = ImcService.calculateImc(Imc(_height!, _weight!));

      await imcHistoryRepository.save(value);
      saveValueOnProvider(value);
      _isLoading = false;      
    }
    setState(() {});
  }

  saveValueOnProvider(double value){
    Provider.of<ImcProvider>(context,listen: false).setImc(value);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(bottom: 15),child: 
                Column(
                  children: [
                    const Text("Peso (kg):", style: TextStyle(fontWeight: FontWeight.bold),),
                    TextField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                        TextInputFormatter.withFunction(
                          (oldValue, newValue) => newValue.copyWith(
                            text: newValue.text.replaceAll('.', ','),
                          ),
                        ),
                      ],
                      onChanged: (value) => _weight=double.tryParse(value),
                  )],
                ),
              ),
              Padding(padding: const EdgeInsets.only(bottom: 15), child:               
                Column(
                  children: [
                    const Text("Altura (m):", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                        TextInputFormatter.withFunction(
                          (oldValue, newValue) => newValue.copyWith(
                            text: newValue.text.replaceAll(',', '.'),
                          ),
                        ),
                      ],
                      onChanged: (value) => _validateHeight(value),
                    ),
                    if(_heightError)const Text(
                      "Preencha um valor válido em metros",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                )
              ),
              ElevatedButton(
                onPressed: _isLoading?null:() async {calculateImc();}, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Calcular"),
                    if(_isLoading) const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  ],
                )
              
              ),
              if(_imcError) const Text(
                "Preencha todos os campos",
                style: TextStyle(color: Colors.red),
              ) 
            ],
          ),
        ),
    );  
  }
}