import 'package:flutter/material.dart';

class CustomAppBarWithBack extends StatelessWidget {
  final Function() onBackButtonPressed;

  const CustomAppBarWithBack({
    Key? key,
    required this.onBackButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(143, 194, 104, 1),
      leading: GestureDetector(
        onTap: onBackButtonPressed,
        child: Opacity(
          opacity: 0.9,
          child: Container(
            margin: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/arrowBack.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
            width: 25,
            height: 25,
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: 1,
            child: Image.asset(
              'lib/images/logoSI.png',
              width: 35,
              height: 35,
            ),
          ),
        ],
      ),
    );
  }
}