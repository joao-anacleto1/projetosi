import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/input_field.dart';

String usernameController = "";
String oldPasswordController = "";
String newPasswordController = "";

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key});

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 20),
                Text(
                  "Change Password",
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
                  labelText: 'Old Password',
                  isPassword: true,
                  onChanged: (value) {
                    oldPasswordController = value;
                  },
                ),
                const SizedBox(height: 20),
                InputField(
                  labelText: 'New Password',
                  isPassword: true,
                  onChanged: (value) {
                    newPasswordController = value;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // LOGICA PARA MUDAR A PASSWORD -> INTERLIDADA
                          // COM O BACKEND
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
                            'Change Password',
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
