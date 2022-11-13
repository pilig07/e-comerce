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

    if (formData['name'] == "") {
      formData['name'] = nameController.text;
      formData['lastname'] = lastnameController.text;
      formData['localId'] = userProvider.user.localId!;
      formData['image'] = userProvider.user.image!;
    }
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: getAppBar(context, 'Perfil', userProvider.user),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              GestureDetector(
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    image =
                        await _picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      final bytes = File(image!.path).readAsBytesSync();
                      formData['image'] = base64Encode(bytes);
                    }
                    setState(() {});
                  },
                  child: userProvider.user.image == ""
                      ? const Image(
                          image: AssetImage('assets/edit.png'),
                          height: 200,
                          width: 200,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(400),
                          child: Image.memory(
                            base64Decode(formData['image']!),
                            height: 300,
                            width: 300,
                            fit: BoxFit.cover,
                          ))),
              const SizedBox(height: 20),
              const Text(
                'Realiza cambios a tu información!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
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
                  : Center(child: CircularProgressIndicator())
            ],
          ),
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
