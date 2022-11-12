import 'package:flutter/material.dart';
import 'package:flutter_application_4/providers/providers.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  Map<String, String> formData = {'email': '', 'password': ''};

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);

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
                        const Text(
                          'Registrate',
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
                                bool respuesta = await registerProvider
                                    .registrarUsuario(formData);
                                if (respuesta) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                            title: Text(
                                                'Usuario registrado con éxito!'));
                                      });
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const AlertDialog(
                                          title: Text(
                                              'Registro de usuario fallido'));
                                    });
                                print("No se pudo validar");
                              }
                            },
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
}
