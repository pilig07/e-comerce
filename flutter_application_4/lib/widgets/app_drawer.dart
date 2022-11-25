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
          children: const [
            Icon(
              Icons.person_sharp,
              size: 100,
              color: Colors.blueGrey,
            )
          ],
        )),
        ListTile(
          title: const Text('Resumen'),
          onTap: (() {
            Navigator.pushReplacementNamed(context, 'home');
          }),
          selected: true,
        ),
        ListTile(
          title: const Text('Mis hábitos'),
          onTap: (() {
            Navigator.pushReplacementNamed(context, 'habits');
          }),
        ),
        ListTile(
          title: const Text('Perfil'),
          onTap: (() {
            Navigator.pushReplacementNamed(context, 'profile');
          }),
        ),
        ListTile(
          title: const Text('Progreso'),
          onTap: (() {
            Navigator.pushReplacementNamed(context, 'progress');
          }),
        ),
      ]),
    );
  }
}
