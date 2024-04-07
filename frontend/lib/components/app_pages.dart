import 'package:flutter/material.dart';

class AppPages extends StatelessWidget {
  final List<String> menuItems;
  final String currentPageTitle;
  final int currentPageIndex;
  final ValueChanged<int> onMenuItemSelected;
  final List<IconData> pageIcons;

  const AppPages({
    Key? key,
    required this.menuItems,
    required this.currentPageTitle,
    required this.currentPageIndex,
    required this.onMenuItemSelected,
    required this.pageIcons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(233, 242, 237, 1),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'lib/images/logoSI.png',
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          ...menuItems.asMap().entries.map((entry) {
            int index = entry.key + 1;
            final item = entry.value;
            return ListTile(
              selectedTileColor: const Color.fromRGBO(94, 191, 118, 0.2),
              selectedColor: const Color.fromRGBO(94, 191, 118, 1),
              leading: Icon(pageIcons[index - 1]),
              title: Text(item),
              onTap: () {
                Navigator.pop(context); // Fecha o drawer após a seleção
                final route =
                    '/${menuItems[index - 1].toLowerCase().replaceAll(' ', '_')}';
                Navigator.of(context).pushReplacementNamed(route);
              },
              selected: index == currentPageIndex,
            );
          }).toList(),
        ],
      ),
    );
  }
}