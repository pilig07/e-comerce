// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import '../services.dart/lists.dart';
import '../services.dart/chartsBuilder.dart';

class Habitspage extends StatefulWidget {
  const Habitspage({Key? key}) : super(key: key);

  @override
  State<Habitspage> createState() => _HabitspageState();
}

class _HabitspageState extends State<Habitspage> {
  UserProvider userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    String name = userProvider.user.name!;

    return Scaffold(
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 1),
      backgroundColor: Colors.grey[100],
      body: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(children: [
              Image.asset('assets/HabitsPageBackground.png'),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 140, 0, 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(children: const [
                    Text(
                      "Estadisticas de tus hábitos",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Mira tu desempeño",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ]),
                ),
              )
            ]),
          ),
        ),
        ListView(
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 200,
              child: LineChartSample1(),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200,
              child: LineChartSample2(),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200,
              child: LineChartSample3(),
            )
          ],
        ),
      ]),
    );
  }
}
