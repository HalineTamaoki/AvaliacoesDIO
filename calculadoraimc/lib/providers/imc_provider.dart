
import 'package:flutter/material.dart';

class ImcProvider extends ChangeNotifier {
  double _imc = 0;

  double get imc => _imc;

  void setImc (double imc) {
    _imc = imc;
    notifyListeners();
  }

}