import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/input_field.dart';

String usernameController = "";
String passwordController = "";

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //"NAV" part
          Container(
            decoration: const BoxDecoration(
            color: Color.fromRGBO(233, 242, 237, 1)
            ),
          ),
          Positioned(
            top: 33,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 85,
              color: const Color.fromRGBO(233, 242, 237, 1),
              child: Center(
                child: Image.asset(
                  'lib/images/logoSI.png',
                  width: 170,
                  height: 170,
                ),
              ),
            ),
          ),

          //"Login message"(...)

          Positioned(
            top: 200, // Ajuste de posição vertical
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Login",
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 40,
                    color: Color.fromRGBO(86, 140, 125, 0.9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Username step

          Positioned(
            top: 280,
            left: 0,
            right: 0,
            child: Center(
              child: InputField(
                labelText: 'Username',
                onChanged: (value) {
                  usernameController = value;
                },
              ),
            ),
          ),

          // Password step

          Positioned(
            top: 350,
            left: 0,
            right: 0,
            child: Center(
              child: InputField(
                labelText: 'Password',
                isPassword: true,
                onChanged: (value) {
                  passwordController = value;
                },
              ),
            ),
          ),

          // Forgot Password?

          Positioned(
            top: 415, // Ajuste de posição vertical
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(86, 140, 125, 1),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          Positioned(
            top: 445,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 105,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(86, 140, 125, 1),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: Text(
                    'Sign In',
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
          ),
        ],
      ),
    );
  }
}