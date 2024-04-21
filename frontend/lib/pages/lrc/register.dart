import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../components/input_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key});

  @override
  Widget build(BuildContext context) {
    String username = "";
    String password = "";
    String email = "";

    Future<void> registerUser() async {
      final response = await http.post(
        Uri.parse('http://localhost:5000/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        // Registro bem sucedido
        print('User registered successfully');
        // Navegar para a próxima tela (home)
        Navigator.pushNamed(context, '/');
      } else {
        // Registro falhou
        print('Failed to register user');
        // Exibir mensagem de erro para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to register user'),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color.fromRGBO(94, 191, 118, 1),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Image.asset(
                  'lib/images/logoSI4.png',
                  width: 170,
                  height: 170,
                ),
                const SizedBox(height: 5),
                Text(
                  "Register",
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
                    username = value;
                  },
                ),
                const SizedBox(height: 20),
                InputField(
                  labelText: 'Password',
                  isPassword: true,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 20),
                InputField(
                  labelText: 'Email',
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: registerUser,
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
