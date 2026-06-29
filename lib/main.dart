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
      title: 'receitas',
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
                    'Mundo das Receitas ​👩‍🍳​❤️​',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.person, 'Receitas', 0),
            _buildDrawerItem(Icons.school, 'Sobre', 1),
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
          BottomNavigationBarItem(icon: Icon(Icons.ramen_dining), label: 'Receitas'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Sobre'),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DocesPage()),
              );
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SalgadosPage()),
              );
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SucosPage()),
              );
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
                    '​Sucos ​​​🍹​',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
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

class DocesPage extends StatelessWidget {
  const DocesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Doces ​​​​🧁​")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/bolo_chocolate.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Bolo de Chocolate ​🍫​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​Bolo de Chocolate ​🍫​",
                      imagem: "assets/images/bolo_chocolate.jpeg",
                      ingredientes: [],
                      massa: [
                        "3 ovos",
                        "2 xícaras de farinha de trigo",
                        "1 e 1/2 xícara de açúcar",
                        "1 xícara de chocolate em pó",
                        "1 xícara de leite",
                        "1/2 xícara de óleo",
                        "1 colher (sopa) de fermento em pó",
                      ],
                      cobertura: [
                        "1 lata de leite condensado",
                        "1 colher (sopa) de manteiga",
                        "4 colheres (sopa) de chocolate em pó",
                        "Brigadeiros para decorar",
                      ],

                      preparo:
                          "1. Misture os ovos, o açúcar, o óleo e o leite.\n\n"
                          "2. Acrescente a farinha e o chocolate em pó e misture bem.\n\n"
                          "3. Adicione o fermento por último.\n\n"
                          "4. Coloque a massa em uma forma untada.\n\n"
                          "5. Asse em forno preaquecido a 180°C por aproximadamente 40 minutos.\n\n"
                          "6. Retire do forno, espere esfriar um pouco e sirva.",
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/pudim.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Pudim ​🍮​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​Pudim ​🍮​",
                      imagem: "assets/images/pudim.jpeg",
                      ingredientes: [],
                      massa: [
                        "1 lata de leite condensado",
                        "2 medidas da lata de leite (use a lata como medida)",
                        "3 ovos",
                      ],
                      cobertura: ["1 xícara de açúcar", "1/2 xícara de água"],

                      preparo:
                          "1. Coloque o açúcar em uma panela e leve ao fogo baixo até derreter e virar um caramelo dourado.\n\n"
                          "2. Adicione a água com cuidado e mexa até dissolver completamente o caramelo.\n\n"
                          "3. Despeje a calda em uma forma de pudim, espalhando bem no fundo e nas laterais.\n\n"
                          "4. No liquidificador, bata o leite condensado, o leite e os ovos por cerca de 2 a 3 minutos até ficar homogêneo.\n\n"
                          "5. Despeje a mistura na forma já com a calda.\n\n"
                          "6. Cubra a forma com papel alumínio.\n\n"
                          "7. Leve ao forno em banho-maria, com água quente, a 180°C.\n\n"
                          "8. Asse por aproximadamente 1 hora a 1 hora e 30 minutos.\n\n"
                          "9. Espete um palito no pudim: se sair limpo, está pronto.\n\n"
                          "10. Retire do forno e espere esfriar completamente.\n\n"
                          "11. Leve à geladeira por pelo menos 4 horas para firmar bem.\n\n"
                          "12. Desenforme com cuidado e sirva gelado.",
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/brownie.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Brownie ​​🍩​​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​Brownie 🍩​​",
                      imagem: "assets/images/brownie.jpeg",
                      ingredientes: [],
                      massa: [
                        "1. Derreta o chocolate com a manteiga em banho-maria ou no micro-ondas, mexendo até ficar homogêneo.\n\n"
                            "2. Em uma tigela, misture os ovos com o açúcar até ficar bem incorporado.\n\n"
                            "3. Adicione o chocolate derretido à mistura e mexa bem.\n\n"
                            "4. Acrescente a farinha de trigo aos poucos e misture até formar uma massa lisa.\n\n"
                            "5. Se quiser, adicione nozes ou pedaços de chocolate à massa.\n\n",
                      ],
                      cobertura: [
                        "1. Derreta um pouco de chocolate com creme de leite (opcional) até formar uma ganache cremosa.\n\n"
                            "2. Reserve para colocar por cima depois de assado.\n\n",
                      ],

                      preparo:
                          "1. Despeje a massa em uma forma untada ou forrada com papel manteiga.\n\n"
                          "2. Leve ao forno preaquecido a 180°C por cerca de 25 a 35 minutos.\n\n"
                          "3. Retire quando o centro ainda estiver levemente úmido.\n\n"
                          "4. Espere esfriar completamente.\n\n"
                          "5. Cubra com a ganache (se estiver usando) e corte em pedaços para servir.",
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/torta.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Torta de Limão 🍋"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​Torta de Limão 🍋​​",
                      imagem: "assets/images/torta.jpeg",
                      ingredientes: [],
                      massa: [
                        "1. Triture o biscoito maisena até virar uma farofa fina.\n\n"
                            "2. Misture a farofa com a manteiga derretida até formar uma massa úmida.\n\n"
                            "3. Forre o fundo e as laterais de uma forma com essa massa, apertando bem.\n\n"
                            "4. Leve ao forno preaquecido a 180°C por cerca de 10 minutos para firmar.\n\n"
                            " RECHEIO\n\n"
                            "5. Misture o leite condensado com o suco de limão até engrossar e virar um creme.\n\n"
                            "6. Adicione o creme de leite e mexa até ficar homogêneo.\n\n"
                            "7. Despeje o recheio sobre a massa já fria.\n\n",
                      ],
                      cobertura: [
                        "1. Bata claras em neve até ficarem firmes.\n\n"
                            "2. Adicione açúcar aos poucos até formar um merengue brilhante.\n\n"
                            "3. Espalhe o merengue por cima do recheio.\n\n"
                            "4. Se quiser, doure levemente com maçarico ou no forno.\n\n",
                      ],

                      preparo:
                          "1. Leve a torta à geladeira por pelo menos 3 a 4 horas.\n\n"
                          "2. Sirva bem gelada.",
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/travessa.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Bombom de Travessa ​​🍨​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​Bombom de Travessa ​​🍨​​​",
                      imagem: "assets/images/travessa.jpeg",
                      ingredientes: [],
                      massa: [
                        "1. Em uma panela, coloque o leite condensado, o leite e o amido de milho.\n\n"
                            "2. Misture bem antes de levar ao fogo para não empelotar.\n\n"
                            "3. Leve ao fogo médio, mexendo sempre até engrossar e formar um creme.\n\n"
                            "4. Desligue o fogo e adicione a essência de baunilha, misturando bem.\n\n"
                            "RECHEIO\n\n"
                            "5. Em uma travessa, espalhe uma camada de biscoito maisena ou champanhe no fundo.\n\n"
                            "6. Despeje metade do creme ainda morno sobre os biscoitos.\n\n"
                            "7. Adicione mais uma camada de biscoitos por cima.\n\n"
                            "8. Cubra com o restante do creme e nivele bem.\n\n",
                      ],
                      cobertura: [
                        "1. Derreta o chocolate meio amargo com o creme de leite até formar uma ganache.\n\n"
                            "2. Espalhe a ganache por cima da sobremesa na travessa.\n\n"
                            "3. Se quiser, decore com raspas de chocolate ou granulado.\n\n",
                      ],

                      preparo:
                          "1. Leve à geladeira por pelo menos 4 horas até ficar bem firme.\n\n"
                          "2. Sirva gelado.",
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/morango.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Taça do amor ​​​​🍓​​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​Taça do amor ​​🍓​​​​",
                      imagem: "assets/images/morango.jpeg",
                      ingredientes: [],
                      massa: [
                        "1. Em uma tigela, bata os ovos com o açúcar até ficar um creme claro.\n\n"
                            "2. Adicione o leite e o óleo e misture bem.\n\n"
                            "3. Acrescente a farinha de trigo aos poucos, mexendo até ficar homogêneo.\n\n"
                            "4. Por último, adicione o fermento e misture levemente.\n\n"
                            "5. Despeje a massa em uma forma untada e leve ao forno preaquecido a 180°C por cerca de 35 a 40 minutos.\n\n"
                            " RECHEIO\n\n"
                            "6. Em uma panela, misture leite condensado, leite e amido de milho.\n\n"
                            "7. Leve ao fogo médio, mexendo até engrossar e virar um creme (tipo creme branco).\n\n"
                            "8. Desligue o fogo e espere esfriar.\n\n"
                            "9. Misture morangos picados ao creme já frio.\n\n",
                      ],
                      cobertura: [
                        "1. Bata chantilly bem gelado até ficar firme.\n\n"
                            "2. Se quiser, adicione morangos inteiros ou picados por cima.\n\n"
                            "3. Pode finalizar com raspas de chocolate branco (opcional).\n\n",
                      ],

                      preparo:
                          "1. Corte o bolo em pedaços ou esfarele levemente.\n\n"
                          "2. Em uma taça ou travessa, faça camadas de bolo, creme com morango e chantilly.\n\n"
                          "3. Repita as camadas até preencher a taça.\n\n"
                          "4. Finalize com chantilly e morangos por cima.\n\n"
                          "5. Leve à geladeira por pelo menos 2 a 3 horas antes de servir.",
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SalgadosPage extends StatelessWidget {
  const SalgadosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("​​🍔​ Salgados​")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/coxinha.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Coxinha ​​🌰​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​​​Coxinha 🌰",
                      imagem: "assets/images/coxinha.jpeg",
                      ingredientes: [],
                      massa: [
                        "1. Em uma panela, coloque a água, o leite, a manteiga e o sal.\n\n"
                            "2. Leve ao fogo até começar a ferver.\n\n"
                            "3. Adicione a farinha de trigo de uma vez e mexa rapidamente até formar uma massa que desgrude do fundo da panela.\n\n"
                            "4. Cozinhe a massa por alguns minutos, mexendo sempre, até ficar lisa e homogênea.\n\n"
                            "5. Desligue o fogo e espere a massa esfriar um pouco antes de modelar.\n\n"
                            "RECHEIO\n\n"
                            "6. Refogue o frango desfiado com alho, cebola, sal e temperos a gosto.\n\n"
                            "7. Adicione molho de tomate e misture bem até ficar suculento.\n\n"
                            "8. Se quiser, acrescente requeijão ou catupiry para deixar mais cremoso.\n\n"
                            " EMPANAMENTO\n\n"
                            "9. Passe as coxinhas modeladas no leite ou ovo batido.\n\n"
                            "10. Em seguida, passe na farinha de rosca até cobrir completamente.\n\n",
                      ],

                      cobertura: [
                        "Opcional: Catchup, maionese ou mostarda para servir.",
                      ],

                      preparo:
                          "1. Frite as coxinhas em óleo quente até ficarem douradas.\n\n"
                          "2. Retire e coloque sobre papel toalha para escorrer o excesso de óleo.\n\n"
                          "3. Sirva ainda quente.",
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/pastel.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Pastel ​​🥟​​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​Pastel ​​🥟​​",
                      imagem: "assets/images/pastel.jpeg",
                      ingredientes: [],
                      massa: [
                        "1. Em uma tigela, misture a farinha de trigo e o sal.\n\n"
                            "2. Adicione o óleo e misture com as mãos até formar uma farofa.\n\n"
                            "3. Acrescente a água morna aos poucos, sovando até formar uma massa lisa e homogênea.\n\n"
                            "4. Sove por cerca de 10 minutos até a massa ficar bem macia.\n\n"
                            "5. Cubra a massa e deixe descansar por 20 a 30 minutos.\n\n"
                            " RECHEIO\n\n"
                            "6. Escolha o recheio de sua preferência (carne moída, queijo, frango ou presunto e queijo).\n\n"
                            "7. Tempere e refogue o recheio até ficar bem sequinho para não soltar água na fritura.\n\n"
                            "MONTAGEM\n\n"
                            "8. Abra a massa com um rolo até ficar bem fina.\n\n"
                            "9. Corte em retângulos ou círculos do tamanho desejado.\n\n"
                            "10. Coloque o recheio no centro e feche bem as bordas com um garfo.\n\n",
                      ],
                      cobertura: [
                        "Opcional: Molho de pimenta ou ketchup para servir.",
                      ],

                      preparo:
                          "1. Frite os pastéis em óleo quente até ficarem dourados e crocantes.\n\n"
                          "2. Retire e coloque sobre papel toalha para escorrer o excesso de óleo.\n\n"
                          "3. Sirva ainda quente.",
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/empada.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Empada ​​🥯​​​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​Empada ​​🥯​​​",
                      imagem: "assets/images/empada.jpeg",
                      ingredientes: [],
                      massa: [
                        "1. Em uma tigela, misture a farinha de trigo e o sal.\n\n"
                            "2. Adicione a manteiga gelada e misture com as mãos até formar uma farofa úmida.\n\n"
                            "3. Acrescente o ovo e misture até formar uma massa lisa e homogênea.\n\n"
                            "4. Se necessário, adicione um pouco de água gelada para dar o ponto.\n\n"
                            "5. Embrulhe a massa e leve à geladeira por 20 a 30 minutos para descansar.\n\n"
                            " RECHEIO\n\n"
                            "6. Refogue frango desfiado com cebola, alho e temperos a gosto.\n\n"
                            "7. Adicione molho de tomate e deixe cozinhar até ficar bem sequinho.\n\n"
                            "8. Se quiser, acrescente requeijão para deixar mais cremoso.\n\n"
                            "9. Espere o recheio esfriar antes de montar as empadas.\n\n"
                            " MONTAGEM\n\n"
                            "10. Abra pequenas porções da massa e forre forminhas de empada.\n\n"
                            "11. Coloque o recheio no centro, sem encher demais.\n\n"
                            "12. Cubra com mais massa e feche bem as bordas.\n\n"
                            "13. Pincele gema de ovo por cima para dourar.\n\n",
                      ],
                      cobertura: ["Opcional: Catchup ou mostarda.\n\n"],

                      preparo:
                          "1. Leve ao forno preaquecido a 180°C por cerca de 25 a 35 minutos.\n\n"
                          "2. Asse até ficarem douradas por cima.\n\n"
                          "3. Espere esfriar um pouco e sirva.",
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/estrogonofe.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Estrogonofe 🥘​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​Estrogonofe 🥘​​​",
                      imagem: "assets/images/estrogonofe.jpeg",
                      ingredientes: [],
                      massa: [
                        "1. Corte o frango em cubos pequenos ou use carne bovina em tiras.\n\n"
                            "2. Tempere com sal, alho e pimenta a gosto.\n\n"
                            "3. Em uma panela, aqueça um fio de óleo ou manteiga e doure a carne.\n\n"
                            "4. Refogue até a carne ficar bem cozida e dourada por igual.\n\n"
                            "5. Adicione a cebola picada e refogue até murchar.\n\n"
                            "6. Acrescente o molho de tomate e misture bem.\n\n"
                            "7. Coloque o ketchup e a mostarda e mexa até incorporar.\n\n"
                            "8. Adicione o creme de leite e misture até ficar um molho cremoso.\n\n"
                            "9. Ajuste o sal e a pimenta se necessário.\n\n",
                      ],
                      cobertura: [
                        "Opcional: Sirva com arroz branco e batata palha por cima.",
                      ],

                      preparo:
                          "1. Cozinhe por mais alguns minutos em fogo baixo, sem deixar ferver muito após adicionar o creme de leite.\n\n"
                          "2. Se quiser, adicione champignon fatiado.\n\n",
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/lasanha.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Lasanha 🍝​​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​Lasanha 🍝​​​​",
                      imagem: "assets/images/lasanha.jpeg",
                      ingredientes: [],
                      massa: [
                        "MOLHO DE CARNE\n\n"
                            "1. Em uma panela, aqueça um fio de óleo e refogue alho e cebola picados.\n\n"
                            "2. Adicione a carne moída e cozinhe até ela perder a cor crua.\n\n"
                            "3. Tempere com sal, pimenta e orégano a gosto.\n\n"
                            "4. Acrescente molho de tomate e deixe cozinhar por alguns minutos até encorpar.\n\n"
                            " MOLHO BRANCO\n\n"
                            "5. Em outra panela, derreta a manteiga e adicione a farinha de trigo, mexendo bem.\n\n"
                            "6. Acrescente o leite aos poucos, mexendo sempre para não empelotar.\n\n"
                            "7. Cozinhe até engrossar e ficar um creme liso.\n\n"
                            "8. Tempere com sal, noz-moscada e pimenta a gosto.\n\n"
                            " MONTAGEM\n\n"
                            "9. Em um refratário, espalhe uma camada de molho de carne no fundo.\n\n"
                            "10. Coloque uma camada de massa de lasanha.\n\n"
                            "11. Adicione molho de carne, molho branco e queijo.\n\n"
                            "12. Repita as camadas até acabar os ingredientes.\n\n"
                            "13. Finalize com molho branco e bastante queijo por cima.\n\n",
                      ],
                      cobertura: ["Opcinoal: Colocar Orégano.\n\n"],

                      preparo:
                          "1. Cubra com papel alumínio e leve ao forno preaquecido a 180°C.\n\n"
                          "2. Asse por cerca de 30 a 40 minutos.\n\n"
                          "3. Retire o papel alumínio e deixe gratinar por mais 10 minutos.\n\n"
                          "4. Espere alguns minutos antes de servir.",
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/pizza.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Pizza ​🍕​​​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​Pizza ​🍕​",
                      imagem: "assets/images/pizza.jpeg",
                      ingredientes: [],
                      massa: [
                        "1. Em uma tigela, misture o fermento biológico seco com o açúcar e a água morna.\n\n"
                            "2. Deixe descansar por 5 a 10 minutos até espumar.\n\n"
                            "3. Adicione a farinha de trigo, o sal e o óleo.\n\n"
                            "4. Misture e sove a massa por cerca de 10 minutos até ficar lisa e elástica.\n\n"
                            "5. Cubra a massa e deixe descansar por 30 a 60 minutos até dobrar de tamanho.\n\n"
                            " MOLHO\n\n"
                            "6. Em uma panela, aqueça um fio de azeite e refogue alho e cebola picados.\n\n"
                            "7. Adicione o molho de tomate e tempere com sal, orégano e pimenta.\n\n"
                            "8. Cozinhe por alguns minutos até o molho encorpar levemente.\n\n"
                            " RECHEIO\n\n"
                            "9. Separe os ingredientes de sua preferência (mussarela, presunto, calabresa, frango, etc.).\n\n"
                            "10. Se quiser, pré-cozinhe ou refogue os ingredientes para melhor sabor.\n\n",
                      ],
                      cobertura: [
                        "Opcional: Catchup, maionese ou mostarda.\n\n",
                      ],

                      preparo:
                          "1. Abra a massa em formato redondo e coloque em uma forma de pizza.\n\n"
                          "2. Espalhe o molho sobre a massa.\n\n"
                          "3. Adicione o recheio e finalize com bastante queijo por cima.\n\n"
                          "4. Leve ao forno preaquecido a 200°C por cerca de 15 a 25 minutos.\n\n"
                          "5. Retire quando a borda estiver dourada e o queijo derretido.\n\n"
                          "6. Corte e sirva quente.",
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SucosPage extends StatelessWidget {
  const SucosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("​​Sucos ​🍹​​")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/suco_maracunja.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Suco de maracunja ​🍈​​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​​​Suco de maracunja 🍈",
                      imagem: "assets/images/suco_maracunja.jpeg",
                      ingredientes: [],
                      massa: [
                        "EXTRAÇÃO DA POLPA\n\n"
                            "1. Lave bem os maracujás antes de cortar.\n\n"
                            "2. Corte os maracujás ao meio com cuidado.\n\n"
                            "3. Com uma colher, retire toda a polpa com sementes e coloque no liquidificador.\n\n"
                            "4. Adicione um pouco de água para ajudar a bater.\n\n"
                            "5. Bata rapidamente (ou pulse) apenas para soltar a polpa das sementes, sem triturar demais.\n\n"
                            "6. Coe a mistura em uma peneira para separar o suco das sementes.\n\n",
                      ],

                      cobertura: [
                        "1. Se quiser, adicione gelo para deixar o suco mais refrescante.\n\n"
                            "2. Pode decorar com sementes de maracujá ou folhas de hortelã.\n\n",
                      ],

                      preparo:
                          "1. No liquidificador, coloque a polpa coada do maracujá.\n\n"
                          "2. Adicione água gelada e açúcar a gosto.\n\n"
                          "3. Bata por alguns segundos até ficar bem misturado.\n\n"
                          "4. Prove e ajuste o açúcar se necessário.\n\n",
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/suco_laranja.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Suco de laranja ​​🍊​​​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​Suco de laranja ​​🍊​​​",
                      imagem: "assets/images/suco_laranja.jpeg",
                      ingredientes: [],
                      massa: [
                        "EXTRAÇÃO DO SUCO\n\n"
                            "1. Lave bem as laranjas antes de usar.\n\n"
                            "2. Corte as laranjas ao meio.\n\n"
                            "3. Esprema cada metade em um espremedor de frutas até extrair todo o suco.\n\n"
                            "4. Coe o suco, se preferir, para retirar o excesso de bagaço e sementes.\n\n",
                      ],
                      cobertura: [
                        "1. Adicione pedras de gelo para deixar o suco bem refrescante.\n\n"
                            "2. Decore com uma rodela de laranja ou folhas de hortelã, se desejar.\n\n",
                      ],

                      preparo:
                          "1. Coloque o suco em uma jarra.\n\n"
                          "2. Adicione água gelada, se desejar um suco mais suave.\n\n"
                          "3. Acrescente açúcar ou adoçante a gosto e misture bem.\n\n"
                          "4. Prove e ajuste o açúcar, se necessário.\n\n",
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/suco_abacate.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Suco de abacate ​​​🥑​​​​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​Suco de abacate ​​​🥑​​​​",
                      imagem: "assets/images/suco_abacate.jpeg",
                      ingredientes: [],
                      massa: [
                        "PREPARO DO ABACATE\n\n"
                            "1. Lave bem o abacate antes de cortar.\n\n"
                            "2. Corte o abacate ao meio e retire o caroço com cuidado.\n\n"
                            "3. Com uma colher, retire toda a polpa e coloque no liquidificador.\n\n",
                      ],
                      cobertura: [
                        "1. Adicione gelo para deixar mais refrescante.\n\n"
                            "2. Se quiser, polvilhe um pouco de canela por cima.\n\n",
                      ],

                      preparo:
                          "1. Adicione leite gelado ao liquidificador com a polpa do abacate.\n\n"
                          "2. Acrescente açúcar ou adoçante a gosto.\n\n"
                          "3. Se quiser, adicione um pouco de leite condensado para deixar mais cremoso.\n\n"
                          "4. Bata tudo por cerca de 1 a 2 minutos até ficar bem cremoso e homogêneo.\n\n"
                          "5. Sirva imediatamente após bater para evitar que oxide.\n\n"
                          "6. Misture antes de beber caso fique parado por alguns minutos.",
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/suco_acerola.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Suco de acerola ​​​🍒​​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​Suco de acerola ​​​🍒​​​​",
                      imagem: "assets/images/suco_acerola.jpeg",
                      ingredientes: [],
                      massa: [
                        "EXTRAÇÃO DA POLPA\n\n"
                            "1. Lave bem as acerolas antes de usar.\n\n"
                            "2. Coloque as acerolas no liquidificador com um pouco de água.\n\n"
                            "3. Bata rapidamente para soltar a polpa das sementes, sem triturar demais.\n\n"
                            "4. Coe a mistura em uma peneira para separar o suco das sementes.\n\n",
                      ],
                      cobertura: [
                        "1. Adicione gelo para deixar o suco mais refrescante.\n\n"
                            "2. Pode decorar com algumas acerolas inteiras ou folhas de hortelã.\n\n",
                      ],

                      preparo:
                          "1. Coloque a polpa coada em uma jarra ou no liquidificador.\n\n"
                          "2. Adicione água gelada a gosto.\n\n"
                          "3. Acrescente açúcar ou adoçante a gosto e misture bem.\n\n"
                          "4. Prove e ajuste o sabor se necessário.\n\n"
                          "5. Sirva imediatamente bem gelado.\n\n"
                          "6. Misture antes de beber caso fique parado por alguns minutos.",
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/suco_limao.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Suco de limão ​​​🍋​​​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​Suco de limão ​​​🍋​​​​​",
                      imagem: "assets/images/suco_limao.jpeg",
                      ingredientes: [],
                      massa: [
                        "EXTRAÇÃO DO SUCO\n\n"
                            "1. Lave bem os limões antes de usar.\n\n"
                            "2. Corte os limões ao meio.\n\n"
                            "3. Esprema cada metade em um espremedor até extrair todo o suco.\n\n"
                            "4. Coe o suco, se preferir, para retirar sementes e excesso de bagaço.\n\n",
                      ],
                      cobertura: [
                        "1. Adicione gelo para deixar o suco mais refrescante.\n\n"
                            "2. Se quiser, decore com rodelas de limão ou folhas de hortelã.\n\n",
                      ],

                      preparo:
                          "1. Coloque o suco em uma jarra ou liquidificador.\n\n"
                          "2. Adicione água gelada a gosto.\n\n"
                          "3. Acrescente açúcar ou adoçante a gosto e misture bem.\n\n"
                          "4. Prove e ajuste o sabor, se necessário.\n\n"
                          "5. Sirva imediatamente para manter o sabor e a vitamina C.\n\n"
                          "6. Misture antes de servir se o suco ficar parado por alguns minutos.",
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Image.asset(
                "assets/images/suco_uva.jpeg",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text("Suco de uva ​​​🍇​​​​"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceitaPage(
                      nome: "​Suco de uva ​​​🍇​​",
                      imagem: "assets/images/suco_uva.jpeg",
                      ingredientes: [],
                      massa: [
                        "EXTRAÇÃO DO SUCO\n\n"
                            "1. Lave bem as uvas antes de usar.\n\n"
                            "2. Coloque as uvas no liquidificador com um pouco de água.\n\n"
                            "3. Bata rapidamente até soltar bem a polpa das cascas.\n\n"
                            "4. Coe a mistura em uma peneira para separar o suco das cascas e sementes.\n\n",
                      ],
                      cobertura: [
                        "1. Adicione gelo para deixar o suco mais refrescante.\n\n"
                            "2. Se quiser, decore com algumas uvas inteiras ou folhas de hortelã.\n\n",
                      ],

                      preparo:
                          "1. Coloque o suco coado em uma jarra ou liquidificador.\n\n"
                          "2. Adicione água gelada a gosto para diluir.\n\n"
                          "3. Acrescente açúcar ou adoçante a gosto e misture bem.\n\n"
                          "4. Prove e ajuste o sabor se necessário.\n\n"
                          "5. Sirva imediatamente bem gelado.\n\n"
                          "6. Misture antes de beber caso fique parado por alguns minutos.",
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReceitaPage extends StatelessWidget {
  final String nome;
  final String imagem;
  final List<String> ingredientes;
  final List<String> massa;
  final List<String> cobertura;
  final String preparo;

  const ReceitaPage({
    super.key,
    required this.nome,
    required this.imagem,
    required this.ingredientes,
    required this.massa,
    required this.cobertura,
    required this.preparo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(nome)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imagem,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Massa",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ...massa.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text("• $item"),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Cobertura",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ...cobertura.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text("• $item"),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Modo de preparo",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(preparo, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
