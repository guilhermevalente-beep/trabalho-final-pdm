import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 250, 128, 114);

    return MaterialApp(
      title: 'Perfil',
      debugShowCheckedModeBanner: false,

      // Tema Claro
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFE3F2FD),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),

      // Tema Escuro
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),

      themeMode: ThemeMode.light,
      home: const MyHomePage(title: 'Mundo das Receitas ​👩‍🍳​❤️​'),
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
    const SobrePage(),
    const Formacao(),
    const Contato(),
  ];

  void selecionarPagina(int index) {
    setState(() {
      _paginaAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.appBarTheme.backgroundColor,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/image.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Guilherme',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.person, 'Sobre', 0),
            _buildDrawerItem(Icons.school, 'Formação', 1),
            _buildDrawerItem(Icons.contact_mail, 'Contato', 2),
          ],
        ),
      ),
      body: _paginas[_paginaAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaAtual,
        onTap: selecionarPagina,
        selectedItemColor: isDark ? theme.colorScheme.primary : Colors.white,
        unselectedItemColor: isDark ? Colors.grey[500] : Colors.blue[200],
        backgroundColor: isDark
            ? const Color(0xFF1F1F1F)
            : theme.colorScheme.primary,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Sobre'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Formação'),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Contato',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return Tooltip(
      message: title,
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        onTap: () {
          Navigator.pop(context);
          selecionarPagina(index);
        },
      ),
    );
  }
}

Widget _buildSectionTitle(BuildContext context, String text) {
  return Center(
    child: Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );
}

Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
  final theme = Theme.of(context);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: theme.brightness == Brightness.dark ? 0.2 : 0.03,
            ),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: theme.colorScheme.primary),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCardContato(
  BuildContext context,
  IconData icon,
  String title,
  String subtitle,
) {
  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
      ),
    ),
    child: ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(
        title,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
    ),
  );
}

//PÁGINAS

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSectionTitle(context, 'Quem eu sou?'),
        const SizedBox(height: 24),
        Center(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.15),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const CircleAvatar(
                radius: 76,
                backgroundImage: AssetImage('assets/images/image.png'),
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              print("Clicou em Doces");
            },
            child: Column(
              children: [
                Image.asset(
                  'assets/images/capa_doce.jpeg',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    '🧁​ Doces',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),

        Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              print("Clicou em Salgados");
            },
            child: Column(
              children: [
                Image.asset(
                  'assets/images/capa_salgados.jpeg',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    '🍔​​ Salgados',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),

        Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              print("Clicou em Sucos");
            },
            child: Column(
              children: [
                Image.asset(
                  'assets/images/capa_sucos.jpeg',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    '​🥤​​​ Sucos',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildInfoRow(context, Icons.cake, 'Idade: 20 anos'),
      ],
    );
  }
}

class Formacao extends StatelessWidget {
  const Formacao({super.key});

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(
      color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
    );

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSectionTitle(context, 'Formação Acadêmica'),
        const SizedBox(height: 24),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderSide,
          ),
          child: const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            leading: Icon(Icons.school, size: 28),
            title: Text(
              'Curso: Ciências da Computação',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Instituição: UESPI'),
          ),
        ),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderSide,
          ),
          child: const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            leading: Icon(Icons.computer, size: 28),
            title: Text(
              'Curso: GitHub',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Instituição: UESPI'),
          ),
        ),
      ],
    );
  }
}

class Contato extends StatelessWidget {
  const Contato({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSectionTitle(context, 'Contato'),
        const SizedBox(height: 24),
        _buildCardContato(
          context,
          Icons.email,
          'Email',
          'guilhermevalente@aluno.uespi.br',
        ),
        _buildCardContato(
          context,
          Icons.code,
          'GitHub',
          'github.com/guilhermevalente-beep',
        ),
        _buildCardContato(context, Icons.phone, 'Telefone', '(89) 9 8115-6422'),
        _buildCardContato(context, Icons.location_on, 'Cidade', 'Floriano-PI'),
      ],
    );
  }
}

class Doces extends StatelessWidget {
  const Doces({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Doces'));
  }
}
