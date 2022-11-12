import 'package:flutter/material.dart';
import 'package:flutter_application_4/providers/providers.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  Map<String, String> formData = {'email': '', 'password': ''};
  RegisterProvider registerProvider = RegisterProvider();

  @override
  Widget build(BuildContext context) {
    registerProvider = Provider.of<RegisterProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.indigo,
        child: Column(
          children: [
            const Icon(Icons.supervised_user_circle,
                size: 200, color: Colors.white),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const AppTitle('Registrate!'),
                        const SizedBox(height: 15),
                        AppFormField(
                            'email', 'Correo electrónico', Icons.email_outlined,
                            ((value) {
                          if (value!.length < 5) {
                            return "Correo no valido";
                          }
                          return null;
                        }), formData: formData, false),
                        AppFormField(
                            'password', 'Contraseña', Icons.password_outlined,
                            ((value) {
                          if (value!.length < 3) {
                            return "Contraseña no valida";
                          }
                          return null;
                        }), formData: formData, true),
                        ElevatedButton(
                            onPressed: formRegister,
                            child: const Text('Registrar'))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: (() {
                  Navigator.pushNamed(context, 'login');
                }),
                child: const Text('Iniciar sesión',
                    style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }

  formRegister() async {
    if (formKey.currentState!.validate()) {
      bool respuesta = await registerProvider.registrarUsuario(formData);
      if (respuesta) {
        AppDialogs.showDialog1(context, 'Usuario registrado con éxito!');
      }
    } else {
      AppDialogs.showDialog1(context, 'Registro de usuario fallido');
      print("No se pudo validar");
    }
  }
}
