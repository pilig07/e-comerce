import 'package:flutter/material.dart';


class AppBottomNavigationBar extends StatefulWidget {
  AppBottomNavigationBar({required this.currentIndex});
  int currentIndex;
  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}


class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {

  @override
  Widget build(BuildContext context){
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.deepPurpleAccent,
      onTap: (index) {
        switch(index){
          case 0:
            Navigator.pushReplacementNamed(context, 'home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, 'habits');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, 'progress');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, 'profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Mis progresos"),
        BottomNavigationBarItem(icon: Icon(Icons.timeline), label: "Estadisticas"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Mi cuenta"),
      ],
    );
  }
}