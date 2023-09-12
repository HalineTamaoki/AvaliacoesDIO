import 'dart:async';

import 'package:firstapp/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cronômetro',
      theme: ThemeData(
        primarySwatch: CustomColors.pinkpalette
      ),
      home: const MyHomePage(title: 'Cronômetro'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  String _result = '00:00:00';

  void _start() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) { 
      setState(() {
        _result = '${_stopwatch.elapsed.inMinutes.toString().padLeft(2, '0')}:${(_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}:${(_stopwatch.elapsed.inMilliseconds % 100).toString().padLeft(2, '0')}';
      });
    });
    _stopwatch.start();
  }

  void _stop(){
    _timer.cancel();
    _stopwatch.stop();
  }

    void _reset(){
    _stop();
    _stopwatch.reset();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:Text(
              _result,
              style: Theme.of(context).textTheme.headline4,            
              ),            
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _start, 
                  child: const Text('Iniciar')                  
                ),
                ElevatedButton(
                  onPressed: _stop, 
                  child: const Text('Pausar')
                ),
                ElevatedButton(
                  onPressed: _reset, 
                  child: const Text('Resetar'),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Desenvolvido por Haline Tamaoki',
          textAlign: TextAlign.center,
        ),  
      )
      
    );
  }
}
