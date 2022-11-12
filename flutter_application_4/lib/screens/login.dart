import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
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
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email_outlined),
                          hintText: 'Correo electrónico',
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.password),
                          hintText: 'Contraseña',
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Ingresar'))
                    ],
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
