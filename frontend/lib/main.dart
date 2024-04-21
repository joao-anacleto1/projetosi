import 'package:flutter/material.dart';
import 'package:projetoSI/pages/chat.dart';
import 'package:projetoSI/pages/lrc/change_password.dart';
import 'package:projetoSI/pages/home.dart';
import 'package:projetoSI/pages/lrc/login.dart';
import 'package:projetoSI/pages/profile.dart';
import 'package:projetoSI/pages/lrc/register.dart';

void main() {
  runApp(const MainApp());
}

// Menu Items ----------------------------

final menuItems = [
  'Home',
  'Chat',
  'User Profile',
];


// Page Icons ----------------------------

final List<Icon> pageIcons = [
  const Icon(Icons.home, color: Color.fromRGBO(86, 140, 125, 1)),
  const Icon(Icons.chat, color: Color.fromRGBO(86, 140, 125, 1)),
  const Icon(Icons.person, color: Color.fromRGBO(86, 140, 125, 1)),
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
        '/change_password.dart': (context) => const ChangePasswordPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}