import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  Map<String, String> formData = {'email': '', 'password': ''};

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.indigo,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
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
                        const Text(
                          'Iniciar Sesión',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          onChanged: (value) {
                            formData['email'] = value;
                          },
                          validator: ((value) {
                            if (value!.length < 5) {
                              return "Correo no valido";
                            }
                            return null;
                          }),
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email_outlined),
                            hintText: 'Correo electrónico',
                          ),
                        ),
                        TextFormField(
                          onChanged: (value) {
                            formData['password'] = value;
                          },
                          validator: ((value) {
                            if (value!.length < 3) {
                              return "Contraseña no valida";
                            }
                            return null;
                          }),
                          obscureText: true,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.password),
                            hintText: 'Contraseña',
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                bool respuesta =
                                    await loginProvider.loginUsuario(formData);
                                if (respuesta) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(actions: [
                                          TextButton(
                                              onPressed: (() {
                                                Navigator.pop(context);
                                                Navigator.pushReplacementNamed(
                                                    context, 'home');
                                              }),
                                              child: Text('OK'))
                                        ], title: Text('Sesión iniciada!'));
                                      });
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const AlertDialog(
                                          title: Text('Usuario no existente'));
                                    });
                                print("No se pudo validar");
                              }
                            },
                            child: const Text('Ingresar'))
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
                child:
                    Text('Registrarse', style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
