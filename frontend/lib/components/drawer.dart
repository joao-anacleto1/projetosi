import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final int currentPage;
  final Function(int) onMenuItemSelected;

  const CustomAppBar({
    Key? key,
    required this.currentPage,
    required this.onMenuItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(143, 194, 104, 1),
      leading: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Opacity(
                opacity: 1,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/images/menu.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 10,
                  height: 10,
                ),
              ));
        },
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
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Opacity(
            opacity: 1,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              child: const Icon(Icons.dashboard, size: 35,),
            ),
          ),
        ),
      ],

    );
  }
}