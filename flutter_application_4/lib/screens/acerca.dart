import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class AcercaScreen extends StatefulWidget {
  const AcercaScreen({Key? key}) : super(key: key);

  @override
  State<AcercaScreen> createState() => _AcercaScreenState();
}

class _AcercaScreenState extends State<AcercaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca'),
        backgroundColor: Colors.indigo,
      ),
      drawer: AppDrawer(),
      body: Center(child: Text('Esta es la sección de acerca :D')),
    );
  }
}
