class Imc {
  double _height = 0; 
  double _weight = 0;

  Imc(this._height, this._weight);
  
  double? getHeight() {return _height;}
  void setHeight(double height) {_height = height;}
  double? getWeight() {return _weight;}
  void setWeight(double weight) {_weight = weight;}

}
