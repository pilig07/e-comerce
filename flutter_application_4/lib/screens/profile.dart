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
    'email': '',
    'password': '',
    'name': '',
    'lastname': '',
    'image': ''
  };

  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  XFile? image;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);

    nameController.text = userProvider.user.name!;
    lastnameController.text = userProvider.user.lastname!;

    return Scaffold(
      drawer: AppDrawer(),
      appBar: getAppBar(context, 'Perfil', userProvider.user),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                image = await _picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  final bytes = File(image!.path).readAsBytesSync();
                  formData['image'] = base64Encode(bytes);
                }
                setState(() {});
              },
              child: image == null
                  ? const Image(
                      image: AssetImage('assets/edit.png'),
                      height: 200,
                      width: 200,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.file(
                        File(image!.path),
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                      ),
                    ),
            ),
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
            ElevatedButton(onPressed: (() {}), child: const Text('Actualizar'))
          ],
        ),
      ),
    );
  }
}
