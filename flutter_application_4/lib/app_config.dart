import 'package:flutter_application_4/screens/home.dart';
import 'screens/screens.dart';

class AppConfig {
  static String initialRoute = 'login';
  static routes() {
    return {
      'login': ((context) => const LoginScreen()),
      'register': ((context) => const RegisterScreen()),
      'home': ((context) => const HomeScreen()),
      'profile': ((context) => const ProfileScreen()),
      'habits': ((context) => const Habitspage()),
      'progress': ((context) => const ProgressPage()),
    };
  }
}
