import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import '../services.dart/lists.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserProvider userProvider = UserProvider();
  int counter = 0;

  TextEditingController habitNameController = TextEditingController();
  TextEditingController habitDescriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    userProvider = Provider.of<UserProvider>(context);

    void addToHabitList(String habitName, String habitDescription) {
      habitList.add([false, habitName, habitDescription, const Icon(Icons.abc)]);
    }

    void addHabit(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Agregar nuevo hábito"),
            content: Form(
              key: _formKey, 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Nombre del hábito',
                    ),
                    controller: habitNameController,
                    validator: (String? dato){
                      if(dato!.isEmpty){
                        return 'Este campo es requerido!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Descripción',
                    ),
                    controller: habitDescriptionController,
                    validator: (String? dato) {
                      if (dato!.isEmpty) {
                        return 'Este campo es requerido!';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                surfaceTintColor: MaterialStateProperty.all(Colors.purpleAccent)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancelar")),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                  surfaceTintColor: MaterialStateProperty.all(Colors.purpleAccent)
                ),
                onPressed: () {
                  setState(() {
                    addToHabitList(habitNameController.text,
                        habitDescriptionController.text);
                  });
                  Navigator.pop(context);
                  // if (_formKey.currentState!.validate()) {
                  //   bool result = await userProvider.saveHabit(habitNameController.text, habitDescriptionController.text, false);
                  //   if(result){
                  //     // ignore: use_build_context_synchronously
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(
                  //         content: Text('Habito guardado correctamente'),
                  //         backgroundColor: Colors.white10,
                  //       )
                  //     );
                  //   }else{
                  //     // ignore: use_build_context_synchronously
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(
                  //         content: Text('Algo salio mal'),
                  //         backgroundColor: Colors.white10,
                  //       )
                  //     );
                  //   }
                  // }
                },
                child: const Text("Guardar")
              )
            ],
          );
        }
      );
    }

    return Scaffold(
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.purple,
        onPressed: (() {
          addHabit(context);
        }),
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: EdgeInsets.zero, 
        children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(children: [
              Image.asset('assets/MainBackground.png'),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 140, 0, 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(children: [
                    const Text(
                      "Bienvenido de nuevo!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Tienes ${habitList.length - counter} hábitos restantes el dia de hoy.",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                      ),
                    ),
                  ]),
                ),
              )
            ]),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30))
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nivel de progreso!",
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                      Text("${((counter / habitList.length) * 100).round()}%",
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 16))
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                        minHeight: 12,
                        color: Colors.deepPurpleAccent,
                        backgroundColor: const Color.fromARGB(255, 192, 170, 250),
                        value: (counter / habitList.length)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Divider(),
                ),
                SizedBox(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: habitList.length,
                    itemBuilder: (context, int index) {
                      return ListTile(
                        title: Text(habitList[index][1]),
                        subtitle: Text(habitList[index][2]),
                        trailing: habitList[index][3],
                        leading: Checkbox(
                          value: habitList[index][0],
                          onChanged: ((value) {
                            setState(() {
                              if (value == false) {
                                counter -= 1;
                                habitList[index][0] = value;
                              } else
                                counter += 1;
                              habitList[index][0] = value;
                            });
                          }),
                        )
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
