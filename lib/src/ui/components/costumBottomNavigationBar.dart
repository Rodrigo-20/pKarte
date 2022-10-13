import 'package:flutter/material.dart';

class costumBottomNavigation extends StatefulWidget {
  const costumBottomNavigation({Key? key}) : super(key: key);

  @override
  State<costumBottomNavigation> createState() => _costumBottomNavigationState();
}

class _costumBottomNavigationState extends State<costumBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
      items:const  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon:Icon(Icons.home),
            label:'Home'),
        BottomNavigationBarItem(
            icon:  Icon(Icons.format_list_bulleted),
            label:'Etiquetas' )
      ],
    );
  }
}
