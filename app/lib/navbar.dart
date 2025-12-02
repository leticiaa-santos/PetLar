import 'package:app/favoritos.dart';
import 'package:app/home.dart';
import 'package:app/pets.dart';
import 'package:app/profile.dart';
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
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> screens = [
    Home(),
    PetsPage(),
    Favoritos(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Pets", icon: Icon(Icons.pets)),
          BottomNavigationBarItem(label: "Favoritos", icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(label: "Perfil", icon: Icon(Icons.person)),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Color(0xff3E5674),
        onTap: changeIndex,
        backgroundColor: Color(0xffffffff),
      ),
    );
  }
}
