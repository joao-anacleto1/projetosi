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
      case 2:
        routeName = '/change_password.dart';
        break;
      case 3:
        routeName = '/register';
        break;
      case 4:
        routeName = '/publish_news';
        break;
      case 5:
        routeName = '/news_list';
        break;
      default:
        routeName = '/';
    }

    Navigator.pop(context);
    Navigator.of(context).pushNamed(routeName);
    currentPage = index;
  }
}
