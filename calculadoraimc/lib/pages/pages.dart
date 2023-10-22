import 'package:calculadoraimc/pages/history.dart';
import 'package:calculadoraimc/pages/home.dart';
import 'package:flutter/material.dart';

class Pages extends StatefulWidget {
  const Pages({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int _selectedIndex = 0;
  static const List<Widget> _pagesOptions = <Widget>[
    MyHomePage(),
    HistoryPage()
  ];

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _pagesOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const<BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: ((value) => setState(() {
          _selectedIndex = value;
        })),
      ),
    );
  }
}