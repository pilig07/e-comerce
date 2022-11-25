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
  Map<String, String> formData = {
    'email': '',
    'password': '',
    'name': '',
    'lastname': ''
  };
  RegisterProvider registerProvider = RegisterProvider();

  @override
  Widget build(BuildContext context) {
    registerProvider = Provider.of<RegisterProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.purple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const AppTitle('Registrate!'),
                          AppFormField('name', 'Nombre',
                              Icons.supervised_user_circle_rounded, ((value) {
                            if (value!.length < 3) {
                              return "Nombre no válido";
                            }
                            return null;
                          }), formData: formData, false),
                          AppFormField('lastname', 'Apellido',
                              Icons.person_outline_outlined, ((value) {
                            if (value!.length < 3) {
                              return "Apellido no válido";
                            }
                            return null;
                          }), formData: formData, false),
                          AppFormField('email', 'Correo electrónico',
                              Icons.email_outlined, ((value) {
                            if (value!.length < 5) {
                              return "Correo no válido";
                            }
                            return null;
                          }), formData: formData, false),
                          AppFormField(
                              'password', 'Contraseña', Icons.password_outlined,
                              ((value) {
                            if (value!.length < 3) {
                              return "Contraseña no válida";
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

  // * Validar formulario de registro
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
