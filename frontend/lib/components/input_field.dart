import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final bool isPassword;
  final ValueChanged<String>? onChanged;

  const InputField({
    Key? key,
    required this.labelText,
    this.isPassword = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: isPassword,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Color.fromRGBO(86, 140, 125, 1)),
          filled: true,
          fillColor: const Color.fromRGBO(81, 166, 102, 0.5),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(81, 166, 102, 0.2),
              width: 2,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(81, 166, 102, 0.2),
              width: 2,
            ),
          ),
        ),
        style: const TextStyle(
          color: Color.fromRGBO(233, 242, 237, 1),
          fontSize: 16,
        ),
      ),
    );
  }
}