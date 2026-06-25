import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryRed = Color.fromARGB(255, 255, 0, 30);
    
    return MaterialApp(
      title: 'App de receitas',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryRed,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFE3F2FD),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryRed,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _paginaAtual = 0;

  final List<Widget> _paginas = [
    const Inicio(),
    const Salgados(),
    const Doces(),
  ];

  void selecionarPagina(int index) {
    setState(() {
      _paginaAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 144, 133),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color.fromARGB(255, 252, 123, 109),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 236, 86, 56)),
      ),
      body: _paginas[_paginaAtual],
    );
  }
}

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Início'),
    );
  }
}

class Salgados extends StatelessWidget {
  const Salgados({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Salgados'),
    );
  }
}

class Doces extends StatelessWidget {
  const Doces({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Doces'),
    );
  }
}