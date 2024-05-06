import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/app_pages.dart';
import '../components/drawer.dart';
import '../components/drawer_with_back.dart';
import '../components/navigation_manager.dart';
import '../main.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  int currentPage = 3;
  late NavigationManager navigationManager;
  late List<dynamic> news = [];
  String? _selectedTheme; // Variável para controlar o tema selecionado

  @override
  void initState() {
    super.initState();
    navigationManager = NavigationManager(context, currentPage: currentPage);
    _fetchNews();
  }

  void _navigateToPage(int index) {
    setState(() {
      currentPage = index;
    });
    navigationManager.navigateToPage(index);
  }

  Future<void> _fetchNews({String? theme}) async {
    const baseUrl = 'http://localhost:5000/get_news';
    final url =
        theme != null ? Uri.parse('$baseUrl?theme=$theme') : Uri.parse(baseUrl);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        news = data['news'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Erro ao buscar notícias. Tente novamente mais tarde.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 242, 237, 1),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: CustomAppBar(
          currentPage: currentPage,
          onMenuItemSelected: _navigateToPage,
        ),
      ),
      drawer: AppPages(
        menuItems: menuItems,
        currentPageTitle: menuItems[currentPage - 1],
        currentPageIndex: currentPage,
        onMenuItemSelected: _navigateToPage,
        pageIcons: pageIcons,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  menuItems[currentPage - 1],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildFilterDropdown(),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(news[index]['title']),
                        subtitle: Text(
                          news[index]['description'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailsPage(news: news[index]),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterDropdown() {
    List<String> themes = [
      'Politica',
      'Desporto',
      'Tecnologia',
      'Entretenimento',
      'Beleza',
      'Moda',
      'Economia',
      'Educação',
      'Cultura',
      'Automobilismo'
    ];

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, right: 20),
        child: PopupMenuButton<String>(
          offset: const Offset(0, 40),
          itemBuilder: (BuildContext context) {
            return themes.map((String theme) {
              return PopupMenuItem<String>(
                value: theme,
                child: Text(
                  theme,
                  style: TextStyle(
                    color:
                        theme == _selectedTheme ? Colors.green : Colors.black,
                  ),
                ),
              );
            }).toList();
          },
          onSelected: (String? value) {
            setState(() {
              if (_selectedTheme == value) {
                // Se o tema selecionado é o mesmo que já está selecionado,
                // então vamos remover o filtro.
                _selectedTheme = null;
              } else {
                _selectedTheme = value;
              }
            });
            _fetchNews(theme: _selectedTheme);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.filter_list),
                SizedBox(width: 8),
                Text('Filtrar por tema'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewsDetailsPage extends StatelessWidget {
  final dynamic news;

  const NewsDetailsPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBarWithBack(
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
          title: news['title'],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              news['description'],
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Tema: ${news['theme']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
