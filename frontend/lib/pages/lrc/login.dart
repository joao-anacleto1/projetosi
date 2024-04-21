import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../components/input_field.dart';

String usernameController = "";
String passwordController = "";

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    Future<void> loginUser() async {
      final response = await http.post(
        Uri.parse('http://localhost:5000/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': usernameController,
          'password': passwordController,
        }),
      );

      if (response.statusCode == 200) {
        // Login bem sucedido
        print('Login successful');
        // Navegar para a próxima tela (home)
        Navigator.pushNamed(context, '/home');
      } else {
        // Login falhou
        print('Invalid username or password');
        // Exibir mensagem de erro para o user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid username or password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(233, 242, 237, 0.7),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'lib/images/logoSI4.png',
                  width: 170,
                  height: 170,
                ),
                const SizedBox(height: 20),
                Text(
                  "Login",
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 40,
                      color: Color.fromRGBO(94, 191, 118, 0.9),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InputField(
                  labelText: 'Username',
                  onChanged: (value) {
                    usernameController = value;
                  },
                ),
                const SizedBox(height: 20),
                InputField(
                  labelText: 'Password',
                  isPassword: true,
                  onChanged: (value) {
                    passwordController = value;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/change_password.dart');
                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                  (states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return Colors.green.withOpacity(0.2);
                                }
                                return null;
                              },
                            ),
                          ),
                          child: Text(
                            'Want to change your password?',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(94, 191, 118, 0.9),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: loginUser, // Chamar a função para fazer login
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(94, 191, 118, 0.9),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Log In',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(233, 242, 237, 0.8),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(94, 191, 118, 0.9),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Register',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(233, 242, 237, 0.8),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
