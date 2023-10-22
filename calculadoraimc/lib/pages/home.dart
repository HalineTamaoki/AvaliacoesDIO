import 'package:calculadoraimc/components/imc_form.dart';
import 'package:calculadoraimc/components/imc_result.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height
        ),
        child:Container(
            color: const Color.fromARGB(255, 243, 241, 241),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const ImcForm(),
                ImcResult()
              ],
            ) 
        ),
      ),
    );
  }
}
