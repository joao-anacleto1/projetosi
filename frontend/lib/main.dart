import 'package:flutter/material.dart';
import 'package:projetoSI/pages/lrc/change_password.dart';
import 'package:projetoSI/pages/home.dart';
import 'package:projetoSI/pages/lrc/login.dart';
import 'package:projetoSI/pages/publishNews.dart';
import 'package:projetoSI/pages/newsList.dart';
import 'package:projetoSI/pages/lrc/register.dart';

void main() {
  runApp(const MainApp());
}

// Menu Items ----------------------------

final menuItems = ['Home', 'Publish News', 'News List'];

// Page Icons ----------------------------

final List<Icon> pageIcons = [
  const Icon(Icons.home, color: Color.fromRGBO(86, 140, 125, 1)),
  const Icon(Icons.newspaper, color: Color.fromRGBO(86, 140, 125, 1)),
  const Icon(Icons.list_alt_outlined, color: Color.fromRGBO(86, 140, 125, 1)),
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
        '/change_password.dart': (context) => const ChangePasswordPage(),
        '/register': (context) => const RegisterPage(),
        '/publish_news': (context) => const MakeNewsPage(),
        '/news_list': (context) => const NewsListPage(),
      },
    );
  }
}
