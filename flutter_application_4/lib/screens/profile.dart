import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProvider userProvider = UserProvider();
  Map<String, String> formData = {
    'localId': '',
    'email': '',
    'password': '',
    'name': '',
    'lastname': '',
    'image': ''
  };

  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  XFile? image;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    nameController.text = userProvider.user.name!;
    lastnameController.text = userProvider.user.lastname!;

    String title = "¡Bienvenid@ ${userProvider.user.name!}!";

    if (formData['name'] == "") {
      formData['name'] = nameController.text;
      formData['lastname'] = lastnameController.text;
      formData['localId'] = userProvider.user.localId!;
      formData['image'] = userProvider.user.image!;
    }
    
    return Scaffold(
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 3),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(15, 50, 15, 20),
          children: [
            GestureDetector(
              onTap: () async{
                final ImagePicker _picker = ImagePicker();
                image = await _picker.pickImage(source: ImageSource.gallery);
                if(image != null){
                  final bytes = File(image!.path).readAsBytesSync();
                  formData['image'] = base64Encode(bytes);
                }
                setState(() {
                  
                });
              },
              child: image == null ? userProvider.user.image == ""?
              const CircleAvatar(
                radius: 150,
                backgroundColor: Colors.purpleAccent,
                backgroundImage: AssetImage('assets/edit.png'),
              ): 
              CircleAvatar(
                radius: 150,
                backgroundColor: Colors.purpleAccent, 
                backgroundImage: Image.memory(base64Decode(userProvider.user.image!)).image
              )
              : CircleAvatar(
                radius: 150,
                backgroundColor: Colors.purpleAccent, 
                backgroundImage: Image.file(File(image!.path)).image
              )
              
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 10),
              child: Center(
                child: Text( title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
            ),
            const Center(
              child: Text(
              "¿Como va tu dia?",
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400
              ),
            )),
            Column(
              children: [
                AppFormField(
                    'name', 'Nombre', Icons.label_important_outline_rounded,
                    ((value) {
                  if (value!.length < 3) {
                    return "Nombre no válido";
                  }
                  return null;
                }), controller: nameController, formData: formData, false),
                AppFormField(
                    'lastname', 'Apellido', Icons.label_important_outline_rounded,
                    ((value) {
                  if (value!.length < 3) {
                    return "Apellido no válido";
                  }
                  return null;
                }), controller: lastnameController, formData: formData, false),
                const SizedBox(
                  height: 20,
                ),
                (loading == false)
                    ? ElevatedButton(
                        onPressed: formUpdate, child: const Text('Actualizar'))
                    : const Center(child: CircularProgressIndicator())
              ],
            )
          ],
        ),
      ),
    );
  }

  formUpdate() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});
      bool respuesta = await userProvider.updateUsuario(formData);
      loading = false;
      setState(() {});
      if (respuesta) {
        AppDialogs.showDialog1(context, 'Datos actualizados!');
      }
    } else {
      AppDialogs.showDialog1(context, 'Error al actualizar');
    }
  }
}
