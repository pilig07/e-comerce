import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        backgroundColor: Colors.indigo,
      ),
      drawer: AppDrawer(),
      body: Container(),
    );
  }
}
