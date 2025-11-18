import 'package:app/favoritos.dart';
import 'package:app/home.dart';
import 'package:app/pets.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int currentIndex = 0;

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
      home: Scaffold(
        body: screens.elementAt(currentIndex),
        bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home) ),
          BottomNavigationBarItem(label: "Pets", icon: Icon(Icons.pets) ),
          BottomNavigationBarItem(label: "Favoritos", icon: Icon(Icons.favorite) ),
        ],
        currentIndex: currentIndex, //a posição desejada
        onTap: changeIndex, //função que muda o index


        ),
      ),
    );
  }
}