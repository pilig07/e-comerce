import 'package:flutter/material.dart';
import 'package:flutter_application_4/app_config.dart';
import 'package:flutter_application_4/providers/providers.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(child: MyApp(), providers: [
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => RegisterProvider()),
    ]);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppConfig.initialRoute,
      routes: AppConfig.routes(),
    );
  }
}
