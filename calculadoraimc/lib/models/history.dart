import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class History{
  double value = 0;
  DateTime date = DateTime.now();
  int id =  0;

  History(this.value);

  get getId => id;

 set setId( id) => this.id = id;

  get getValue => value;

  set setValue( value) => this.value = value;

  get getDate =>date;
  set setDate( date) => this.date = date;

  String getFormattedDate(){
    return DateFormat('dd/MM/yyyy hh:mm', 'pt_Br').format(date);
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'date': date.millisecondsSinceEpoch,
    };
  }

  History.fromMap(Map map) {
    id = map['id'];
    date = DateTime.fromMillisecondsSinceEpoch(map['date']);
    value = map['value'];
  }
  
}