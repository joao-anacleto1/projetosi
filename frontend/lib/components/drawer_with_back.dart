import 'package:flutter/material.dart';

class CustomAppBarWithBack extends StatelessWidget {
  final Function() onBackButtonPressed;
  final String title;

  const CustomAppBarWithBack({
    Key? key,
    required this.onBackButtonPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(94, 191, 118, 1),
      leading: IconButton(
        onPressed: onBackButtonPressed,
        icon: const Icon(Icons.arrow_back),
      ),
      title: Text(title),
    );
  }
}
