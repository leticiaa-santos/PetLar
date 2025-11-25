import 'package:app/favoritos.dart';
import 'package:app/home.dart';
import 'package:app/pets.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {

  final int initialIndex;

  const NavBar({this.initialIndex = 0, super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int currentIndex = 0;

  @override
  void initState(){
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void changeIndex (int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> screens = [
    Home(),
    Pets(),
    Favoritos(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screens.elementAt(currentIndex),
        bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home) ),
          BottomNavigationBarItem(label: "Pets", icon: Icon(Icons.pets) ),
          BottomNavigationBarItem(label: "Favoritos", icon: Icon(Icons.favorite) ),
        ],
        currentIndex: currentIndex, //a posição desejada
        selectedItemColor: Color(0xff3E5674),
        onTap: changeIndex, //função que muda o index
        backgroundColor: Color(0xffffffff),


        ),
      ),
    );
  }
}