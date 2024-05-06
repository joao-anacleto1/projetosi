import 'package:flutter/material.dart';
import '../components/app_pages.dart';
import '../components/drawer.dart';
import '../components/navigation_manager.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MakeNewsPage extends StatefulWidget {
  const MakeNewsPage({Key? key}) : super(key: key);

  @override
  _MakeNewsPageState createState() => _MakeNewsPageState();
}

class _MakeNewsPageState extends State<MakeNewsPage> {
  int currentPage = 2;
  late NavigationManager navigationManager;
  String? _selectedTheme;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    navigationManager = NavigationManager(context, currentPage: currentPage);
  }

  void _navigateToPage(int index) {
    setState(() {
      currentPage = index;
    });
    navigationManager.navigateToPage(index);
  }

  void _sendNews() async {
    final url = Uri.parse('http://localhost:5000/send_news');

    final Map<String, String> formData = {
      'title': _titleController.text,
      'theme': _selectedTheme!,
      'description': _descriptionController.text,
    };

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(formData),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notícia enviada com sucesso!'),
          duration: Duration(seconds: 3),
        ),
      );

      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedTheme = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content:
              Text('Falha ao enviar a notícia. Tente novamente mais tarde.'),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _buildNewsPublicationForm(),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Image.asset(
                          'lib/images/newspaper.jpg',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsPublicationForm() {
    List<String> _themes = [
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

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Título',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(94, 191, 118, 0.9),
                ),
              ),
              labelStyle: TextStyle(
                color: Color.fromRGBO(94, 191, 118, 0.9),
              ),
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _selectedTheme,
            items: _themes.map((theme) {
              return DropdownMenuItem<String>(
                value: theme,
                child: Text(theme),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedTheme = value;
                });
              }
            },
            decoration: const InputDecoration(
              labelText: 'Tema',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(94, 191, 118, 0.9),
                ),
              ),
              labelStyle: TextStyle(
                color: Color.fromRGBO(94, 191, 118, 0.9),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 400,
            child: TextField(
              controller: _descriptionController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(94, 191, 118, 0.9),
                  ),
                ),
                labelStyle: TextStyle(
                  color: Color.fromRGBO(94, 191, 118, 0.9),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (_titleController.text.isNotEmpty &&
                  _selectedTheme != null &&
                  _descriptionController.text.isNotEmpty) {
                _sendNews();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Por favor, preencha todos os campos obrigatórios.',
                    ),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  ),
                );
              }
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
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Publicar',
                style: TextStyle(
                  color: Color.fromRGBO(233, 242, 237, 0.8),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
