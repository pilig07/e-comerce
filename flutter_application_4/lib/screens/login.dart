import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  Map<String, String> formData = {'email': '', 'password': ''};
  LoginProvider loginProvider = LoginProvider();
  UserProvider userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    loginProvider = Provider.of<LoginProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
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
                        const AppTitle('Iniciar Sesión'),
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
                            onPressed: formLogin, child: const Text('Ingresar'))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: (() {
                  Navigator.pushNamed(context, 'register');
                }),
                child: const Text('Registrarse',
                    style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }

  formLogin() async {
    if (formKey.currentState!.validate()) {
      var usuario = await loginProvider.loginUsuario(formData);
      if (usuario != null) {
        userProvider.setUser(usuario);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, 'home');
                    }),
                    child: Text('OK'))
              ], title: const Text('Sesión iniciada!'));
            });
      }
    } else {
      AppDialogs.showDialog1(context, 'Usuario no encontrado');
      print("No se pudo validar");
    }
  }
}
