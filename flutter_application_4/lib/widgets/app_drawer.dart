import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
            child: Column(
          children: [
            Icon(
              Icons.person_sharp,
              size: 100,
              color: Colors.blueGrey,
            )
          ],
        )),
        ListTile(
          title: Text('Home'),
          onTap: (() {
            Navigator.pushReplacementNamed(context, 'home');
          }),
          selected: true,
        ),
        ListTile(
          title: Text('Mapa'),
          onTap: (() {
            Navigator.pushReplacementNamed(context, 'mapa');
          }),
        ),
        ListTile(
          title: Text('Opción 1'),
          onTap: (() {}),
        ),
        ListTile(
          title: Text('Opción 2'),
          onTap: (() {}),
        ),
        ListTile(
          title: Text('Acerca'),
          onTap: (() {
            Navigator.pushReplacementNamed(context, 'acerca');
          }),
        ),
      ]),
    );
  }
}
