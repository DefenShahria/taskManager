import 'package:flutter/material.dart';
import 'package:module11/screen/cancel.dart';
import 'package:module11/screen/completed.dart';
import 'package:module11/screen/inprogress.dart';
import 'package:module11/screen/newtsk.dart';

class BottomNave extends StatefulWidget {
  const BottomNave({super.key});

  @override
  State<BottomNave> createState() => _BottomNaveState();
}

class _BottomNaveState extends State<BottomNave> {

  int _selectscreen =0;

  final List<Widget> _screen = const[
    Newtask(),
    Inprogress(),
    cancel(),
    completed()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _screen[_selectscreen],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectscreen,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: const TextStyle(
            color: Colors.black
        ),
        showUnselectedLabels: true,
        selectedItemColor: Colors.cyan,
        onTap: (int index){
          _selectscreen =index;
          if(mounted){
            setState(() {});
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add_comment),label: 'New'),
          BottomNavigationBarItem(icon: Icon(Icons.autorenew_rounded),label: 'In progress'),
          BottomNavigationBarItem(icon: Icon(Icons.cancel_rounded),label: 'Cancel'),
          BottomNavigationBarItem(icon: Icon(Icons.done_all),label: 'Completed'),
        ],
      ),
    );
  }
}