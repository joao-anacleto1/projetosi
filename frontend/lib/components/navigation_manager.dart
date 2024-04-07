import 'package:flutter/material.dart';

class NavigationManager {
  final BuildContext context;
  int currentPage;

  NavigationManager(this.context, {required this.currentPage});

  void navigateToPage(int index) {
    String routeName;

    switch (index) {
      case 1:
        routeName = '/login';
        break;
      case 2:
        routeName = '/registration';
        break;
      case 3:
        routeName = '/chat';
        break;
      case 4:
        routeName = '/user_profile';
        break;
      case 5:
        routeName = '/configuration';
        break;
      case 6:
        routeName = '/password_recovery';
        break;
      default:
        routeName = '/';
    }

    Navigator.pop(context);
    Navigator.of(context).pushNamed(routeName);
    currentPage = index;
  }
}