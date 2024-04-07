import 'package:flutter/material.dart';
import 'package:projetoSI/pages/chat.dart';
import 'package:projetoSI/pages/change_password.dart';
import 'package:projetoSI/pages/home.dart';
import 'package:projetoSI/pages/login.dart';
import 'package:projetoSI/pages/profile.dart';
import 'package:projetoSI/pages/register.dart';
import 'package:projetoSI/pages/settings.dart';

void main() {
  runApp(const MainApp());
}

// Menu Items ----------------------------

final menuItems = [
  'Home',
  'Chat',
  'User Profile',
  'Settings',
];


// Page Icons ----------------------------

final List<Icon> pageIcons = [
  const Icon(Icons.home, color: Color.fromRGBO(86, 140, 125, 1)),
  const Icon(Icons.chat, color: Color.fromRGBO(86, 140, 125, 1)),
  const Icon(Icons.person, color: Color.fromRGBO(86, 140, 125, 1)),
  const Icon(Icons.settings, color: Color.fromRGBO(86, 140, 125, 1)),
];


// -----------------------------------------

class MainApp extends StatelessWidget {
  const MainApp({super.key, Key? k});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DDOS33',
      theme: ThemeData(
        colorScheme: null,
        useMaterial3: false,
      ),
      initialRoute: '/', //Rota Inicial
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/chat': (context) => const ChatPage(),
        '/user_profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/change_password.dart': (context) => const ChangePasswordPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}