import 'package:calculadoraimc/pages/pages.dart';
import 'package:calculadoraimc/providers/imc_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'colors.dart';

void main() async {
  await initializeDateFormatting("pt_BR", null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: ((context) => ImcProvider()),
      child: MaterialApp(
        title: 'Calculadora IMC',
        theme: ThemeData(
          primarySwatch: CustomColors.pinkpalette
        ),
        home: const Pages(title: 'Calculadora IMC'),
      )
    );
  }
}