import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const orange = Color(0xFFF47717);
const brown = Color(0xFF38241B);
const cream = Color(0xFFFFF8EF);
const softGold = Color(0xFFFFE8C5);
const fees = {'Centro': 5.0, 'Candeias': 7.0, 'Brasil': 8.0, 'Recreio': 6.0};
String money(double n) => 'R\$ ${n.toStringAsFixed(2).replaceAll('.', ',')}';

class Product {
  final String title, detail, category, icon, image;
  final double price;
  const Product(this.title, this.detail, this.category, this.icon, this.price, this.image);
}

const catalog = <Product>[
  Product('Misto Quente', 'Presunto e queijo', 'Lanches', '🍔', 8.00, 'assets/images/burger.png'),
  Product('Bauru', 'Queijo, presunto, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 11.00, 'assets/images/burger.png'),
  Product('Hambúrguer', 'Hambúrguer, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 11.00, 'assets/images/burger.png'),
  Product('X-Burguer', 'Hambúrguer, queijo, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 13.00, 'assets/images/burger.png'),
  Product('Cachorro Quente', 'Salsicha, queijo, tomate, milho verde e batata palha', 'Lanches', '🍔', 13.00, 'assets/images/burger.png'),
  Product('Americano', 'Ovo, queijo, presunto, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 15.00, 'assets/images/burger.png'),
  Product('X-Salada', 'Hambúrguer, presunto, queijo, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 15.00, 'assets/images/burger.png'),
  Product('X-Egg', 'Hambúrguer, ovo, queijo, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 15.00, 'assets/images/burger.png'),
  Product('Mexicano', 'Presunto, ovo, queijo, salsicha, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 15.00, 'assets/images/burger.png'),
  Product('Calabresinha', 'Pão de sal, calabresinha, queijo, tomate e cebola', 'Lanches', '🍔', 15.00, 'assets/images/burger.png'),
  Product('Filezinho de Frango', 'Pão de sal, filé de frango, queijo, tomate e cebola', 'Lanches', '🍔', 15.00, 'assets/images/burger.png'),
  Product('Filezinho Misto', 'Pão de sal, filé, filé de frango, queijo, tomate e cebola', 'Lanches', '🍔', 17.00, 'assets/images/burger.png'),
  Product('Hambúrguer Especial', 'Pão de sal, filé, queijo, tomate e cebola', 'Lanches', '🍔', 18.00, 'assets/images/burger.png'),
  Product('X-Bacon', 'Hambúrguer, bacon, queijo, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 17.00, 'assets/images/burger.png'),
  Product('Hot Dog Burguer', 'Hambúrguer, salsicha, queijo, tomate, cebola, milho verde e batata palha', 'Lanches', '🍔', 16.00, 'assets/images/burger.png'),
  Product('American Burguer', 'Hambúrguer, ovo, queijo, presunto, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 19.00, 'assets/images/burger.png'),
  Product('American Bacon', 'Bacon, ovo, queijo, presunto, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 19.00, 'assets/images/burger.png'),
  Product('Cachorro Quente c/Bacon', 'Salsicha, bacon, queijo, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 19.00, 'assets/images/burger.png'),
  Product('Sanduísser c/Frango', 'Hambúrguer, filé de frango, queijo, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 17.00, 'assets/images/burger.png'),
  Product('American Frango', 'Frango, presunto, ovo, queijo, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 17.00, 'assets/images/burger.png'),
  Product('2 Eggs Bacon', 'Hambúrguer, ovo, bacon, queijo, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 19.00, 'assets/images/burger.png'),
  Product('A. Calabresa', 'Presunto, queijo, salsicha, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 10.00, 'assets/images/burger.png'),
  Product('X-Hiper', 'Hambúrguer, ovo, bacon, presunto, queijo, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 20.00, 'assets/images/burger.png'),
  Product('X-Dog Hiper', 'Hambúrguer, bacon, ovo, salsicha, queijo, presunto, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 21.00, 'assets/images/burger.png'),
  Product('X-Frango', 'Filé de frango, queijo, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 20.00, 'assets/images/burger.png'),
  Product('X-Dog Galinha', 'Filé de frango, queijo, salsicha, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 21.00, 'assets/images/burger.png'),
  Product('Galinha Mista', 'Filé de frango, filé, queijo, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 21.00, 'assets/images/burger.png'),
  Product('Galinha Mista c/Bacon', 'Filé de frango, bacon, queijo, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 21.00, 'assets/images/burger.png'),
  Product('Galinhão', 'Filé de frango, filé, bacon, queijo, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 22.00, 'assets/images/burger.png'),
  Product('X-Filé', 'Filé, queijo, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 22.20, 'assets/images/burger.png'),
  Product('Super Boy', 'Filé, bacon, ovo, queijo, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 24.00, 'assets/images/burger.png'),
  Product('Filé Especial', 'Filé, frango, presunto, queijo, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 24.00, 'assets/images/burger.png'),
  Product('À Moda da Casa', 'Filé, filé de frango, ovo, bacon, queijo, presunto, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 24.00, 'assets/images/burger.png'),
  Product('Fiori Especial', 'Hambúrguer, filé, filé de frango, ovo, salsicha, queijo, presunto, tomate, alface, milho verde e batata palha', 'Lanches', '🍔', 26.00, 'assets/images/burger.png'),
  Product('Coca-Cola Lata 350ml', 'Refrigerante', 'Refrigerantes', '🥤', 6.00, 'assets/images/soda.png'),
  Product('Guaraná Antarctica Lata 350ml', 'Refrigerante', 'Refrigerantes', '🥤', 6.00, 'assets/images/soda.png'),
  Product('Fanta Lata 350ml', 'Refrigerante', 'Refrigerantes', '🥤', 6.00, 'assets/images/soda.png'),
  Product('Coca-Cola 1L', 'Refrigerante', 'Refrigerantes', '🥤', 9.00, 'assets/images/soda.png'),
  Product('Guaraná Antarctica 1L', 'Refrigerante', 'Refrigerantes', '🥤', 9.00, 'assets/images/soda.png'),
  Product('Fanta 1L', 'Refrigerante', 'Refrigerantes', '🥤', 8.00, 'assets/images/soda.png'),
];

const extras = <String, double>{
  'Hambúrguer': 7.00, 'Queijo': 2.00, 'Presunto': 2.00,
  'Ovo': 2.00, 'Bacon': 4.00, 'Frango': 4.00,
  'Filé': 4.00, 'Salsicha': 5.00, 'Salada': 3.00,
};

class CartItem {
  final int productIndex;
  final List<String> selectedExtras;
  final String note;
  final String doneness;
  int qty;
  CartItem(this.productIndex, this.selectedExtras, this.note, this.qty, this.doneness);
  double get unit => catalog[productIndex].price + selectedExtras.fold<double>(0, (v, k) => v + (extras[k] ?? 0));
  double get total => unit * qty;
}

void main() => runApp(const FioreApp());

class FioreApp extends StatelessWidget {
  const FioreApp({super.key});
  @override 
  Widget build(BuildContext context) => MaterialApp(
    title: 'Fiori Lanches', 
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true, 
      scaffoldBackgroundColor: cream,
      colorScheme: ColorScheme.fromSeed(seedColor: orange),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.w800, color: brown),
        titleMedium: TextStyle(fontWeight: FontWeight.w800, color: brown),
      ),
    ),
    home: const FioreSplash(),
  );
}

class FioreSplash extends StatefulWidget {
  const FioreSplash({super.key});
  @override 
  State<FioreSplash> createState() => _FioreSplashState();
}

class _FioreSplashState extends State<FioreSplash> {
  @override 
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const FioreHome()),
        );
      }
    });
  }

  @override 
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: orange,
    body: SafeArea(child: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(30), child: Image.asset('assets/images/logo_oficial.png', width: 300, height: 210, fit: BoxFit.contain)),
        const SizedBox(height: 24),
        const Text('Delivery Fiori Lanches',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
      ],
    ))),
  );
}

class FioreHome extends StatefulWidget {
  const FioreHome({super.key});
  @override 
  State<FioreHome> createState() => _FioreHomeState();
}

class _FioreHomeState extends State<FioreHome> {
  int tab = 0;
  String category = 'Todos';
  String search = '';
  String? neighborhood;
  String payment = 'Pix';
  final customer = TextEditingController();
  final phone = TextEditingController();
  final street = TextEditingController();
  final reference = TextEditingController();
  final change = TextEditingController();
  final items = <CartItem>[];

  double get subtotal => items.fold<double>(0, (sum, item) => sum + item.total);
  int get count => items.fold<int>(0, (sum, item) => sum + item.qty);
  double get fee => fees[neighborhood] ?? 0;

  @override 
  void dispose() { 
    for (final c in [customer, phone, street, reference, change]) { 
      c.dispose(); 
    } 
    super.dispose(); 
  }

  void notify(String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

  Widget orangeButton(String label, VoidCallback onTap, {IconData icon = Icons.arrow_forward}) =>
    SizedBox(width: double.infinity, height: 52, child: FilledButton.icon(
      style: FilledButton.styleFrom(backgroundColor: orange, foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      onPressed: onTap, icon: Icon(icon), label: Text(label, style: const TextStyle(fontWeight: FontWeight.w800))));

  Widget section(String title) => Padding(padding: const EdgeInsets.only(bottom: 12),
    child: Text(title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: brown)));

  Widget productTile(int index) {
    final p = catalog[index];
    return Card(color: Colors.white, elevation: 0, margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
      child: InkWell(borderRadius: BorderRadius.circular(19), onTap: () => details(index),
        child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
          ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset(p.image, width: 92, height: 92, fit: BoxFit.cover)),
          const SizedBox(width: 12), 
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(p.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: brown)),
            const SizedBox(height: 4), 
            Text(p.detail, maxLines: 2, overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
            const SizedBox(height: 8), 
            Text(money(p.price), style: const TextStyle(color: orange, fontWeight: FontWeight.w900, fontSize: 16)),
          ])), 
          const Icon(Icons.add_circle, color: orange, size: 30),
        ]))));
  }

  Future<void> details(int index) async {
    final p = catalog[index];
    final selected = <String>{};
    final note = TextEditingController();
    int qty = 1;

    await showModalBottomSheet<void>(
      context: context, 
      isScrollControlled: true,
      backgroundColor: cream, 
      showDragHandle: true,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, refresh) => SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, MediaQuery.of(context).viewInsets.bottom + 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                mainAxisSize: MainAxisSize.min, 
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22), 
                      child: Image.asset(index == 0 ? 'assets/images/hero.png' : p.image, width: double.infinity, height: 225, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 14), 
                  section(p.title), 
                  Text(p.detail),
                  const SizedBox(height: 8), 
                  Text(money(p.price), style: const TextStyle(color: orange, fontSize: 24, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 14), 
                  if (p.category == 'Lanches') ...[
                    const Text('Escolha seus adicionais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    ...extras.entries.map((e) => CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(e.key), 
                      subtitle: Text('+ ${money(e.value)}'), 
                      value: selected.contains(e.key),
                      activeColor: orange, 
                      onChanged: (v) => refresh(() { 
                        if (v == true) { 
                          selected.add(e.key); 
                        } else { 
                          selected.remove(e.key); 
                        } 
                      }),
                    )),
                  ],
                  TextField(
                    controller: note, 
                    maxLines: 2, 
                    decoration: const InputDecoration(
                      labelText: 'Observações (opcional)',
                      hintText: 'Ex.: sem cebola', 
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12), 
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    IconButton(onPressed: qty > 1 ? () => refresh(() => qty--) : null, icon: const Icon(Icons.remove_circle_outline)),
                    Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                    IconButton(onPressed: () => refresh(() => qty++), icon: const Icon(Icons.add_circle_outline)),
                  ]),
                  orangeButton('Adicionar • ${money((p.price + selected.fold<double>(0, (s, k) => s + extras[k]!)) * qty)}', () {
                    setState(() => items.add(CartItem(index, selected.toList(), note.text.trim(), qty, '')));
                    Navigator.pop(sheetContext); 
                    notify('Produto adicionado ao carrinho');
                  }, icon: Icons.add_shopping_cart),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    note.dispose();
  }

  Widget home() => ListView(padding: EdgeInsets.zero, children: [
    Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [Color(0xFFFFA42D), Color(0xFFF47717), Color(0xFFDF5B0B)]),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32))),
      child: Padding(padding: const EdgeInsets.fromLTRB(18, 16, 18, 28), child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Center(child: Image.asset('assets/images/logo_oficial.png',
            height: 170, width: 285, fit: BoxFit.contain)),
          const SizedBox(height: 4),
          const Text('SABOR QUE CONQUISTA!', textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 17,
              fontWeight: FontWeight.w900, letterSpacing: 1.6)),
          const SizedBox(height: 7),
          const Text('Seu hambúrguer favorito, entregue na sua porta.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 13)),
          const SizedBox(height: 22),
          Material(color: cream, elevation: 5, shadowColor: const Color(0x44000000),
            borderRadius: BorderRadius.circular(24), child: InkWell(
              onTap: () => details(0), borderRadius: BorderRadius.circular(24),
              child: Padding(padding: const EdgeInsets.all(14), child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: softGold, borderRadius: BorderRadius.circular(20)),
                    child: const Text('DESTAQUE DA CASA', style: TextStyle(
                      fontSize: 10, color: brown, fontWeight: FontWeight.w900))),
                  const SizedBox(height: 10),
                  const Text('Fiori Especial', style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w900, color: brown)),
                  const SizedBox(height: 7),
                  const Text('Hambúrguer, filé, frango, ovo, salsicha e acompanhamentos.',
                    style: TextStyle(color: brown, fontSize: 12)),
                  const SizedBox(height: 12),
                  Text(money(catalog[0].price), style: const TextStyle(
                    color: orange, fontSize: 22, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 9),
                  const Row(mainAxisSize: MainAxisSize.min, children: [
                    Text('Pedir agora', style: TextStyle(color: brown,
                      fontSize: 13, fontWeight: FontWeight.w800)),
                    SizedBox(width: 4), Icon(Icons.arrow_forward, size: 16, color: brown),
                  ]),
                ])),
                const SizedBox(width: 10),
                ClipRRect(borderRadius: BorderRadius.circular(18),
                  child: Image.asset('assets/images/burger.png', width: 125,
                    height: 180, fit: BoxFit.cover)),
              ])))),
        ]))),
    Padding(padding: const EdgeInsets.fromLTRB(18, 24, 18, 34), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: [
        section('O que deseja fazer?'),
        Row(children: [
          Expanded(child: _shortcut(Icons.restaurant_menu, 'Cardápio',
            () => setState(() => tab = 1))),
          const SizedBox(width: 12),
          Expanded(child: _shortcut(Icons.shopping_bag_outlined, 'Carrinho',
            () => setState(() => tab = 2))),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _shortcut(Icons.receipt_long_outlined, 'Meus pedidos',
            () => showDialog<void>(context: context, builder: (ctx) => AlertDialog(
              title: const Text('Meus pedidos'),
              content: const Text('Os pedidos são enviados pelo WhatsApp. Consulte a conversa com o Fiori Lanches para acompanhar seu pedido.'),
              actions: [TextButton(onPressed: () => Navigator.pop(ctx),
                child: const Text('Entendi'))])))),
          const SizedBox(width: 12),
          Expanded(child: _shortcut(Icons.person_outline, 'Meus dados',
            () => setState(() => tab = 2), light: true)),
        ]),
        const SizedBox(height: 26),
        section('Favoritos da casa'),
        productTile(0),
        productTile(13),
        const SizedBox(height: 10),
        orangeButton('Explorar cardápio completo',
          () => setState(() => tab = 1), icon: Icons.restaurant_menu),
      ])),
  ]);

  Widget _shortcut(IconData icon, String label, VoidCallback action, {bool light = false}) => Material(
    color: light ? Colors.white : orange,
    borderRadius: BorderRadius.circular(20),
    child: InkWell(onTap: action, borderRadius: BorderRadius.circular(20),
      child: SizedBox(height: 102, child: Column(
        mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: light ? orange : Colors.white, size: 31),
          const SizedBox(height: 9),
          Text(label, textAlign: TextAlign.center, style: TextStyle(
            color: light ? brown : Colors.white,
            fontWeight: FontWeight.w900, fontSize: 14)),
        ]))));

  Widget menu() => ListView(padding: const EdgeInsets.all(18), children: [
    section('Nosso cardápio'),
    TextField(onChanged: (v) => setState(() => search = v),
      decoration: InputDecoration(hintText: 'Buscar seu lanche...', prefixIcon: const Icon(Icons.search),
        filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none))),
    const SizedBox(height: 14), 
    SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
      for (final c in ['Todos', 'Lanches', 'Refrigerantes'])
        Padding(padding: const EdgeInsets.only(right: 7), child: ChoiceChip(label: Text(c), selected: category == c,
          selectedColor: const Color(0xFFFFD5AA), onSelected: (_) => setState(() => category = c))),
    ])), 
    const SizedBox(height: 16),
    for (int i = 0; i < catalog.length; i++) 
      if ((category == 'Todos' || catalog[i].category == category) &&
        (catalog[i].title.toLowerCase().contains(search.toLowerCase()) || catalog[i].detail.toLowerCase().contains(search.toLowerCase()))) 
        productTile(i),
  ]);

  Widget field(TextEditingController c, String label, {
