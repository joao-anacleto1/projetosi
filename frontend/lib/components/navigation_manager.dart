import 'package:flutter/material.dart';

class NavigationManager {
  final BuildContext context;
  int currentPage;

  NavigationManager(this.context, {required this.currentPage});

  void navigateToPage(int index) {
    String routeName;

    switch (index) {
      case 1:
        routeName = '/home';
        break;
      case 3:
        routeName = '/chat';
        break;
      case 3:
        routeName = '/user_profile';
        break;
      case 4:
        routeName = '/settings';
        break;
      case 5:
        routeName = '/change_password.dart';
        break;
      case 6:
        routeName = '/register';
        break;
      default:
        routeName = '/';
    }

    Navigator.pop(context);
    Navigator.of(context).pushNamed(routeName);
    currentPage = index;
  }
}